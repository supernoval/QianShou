//
//  TheAcceptedOrderTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "TheAcceptedOrderTVC.h"
#import "AcceptedOrderCell.h"
#import "LocationViewController.h"
#import "MZTimerLabel.h"
#import "YellModel.h"
#import "SDPhotoItem.h"
#import "SDPhotoGroup.h"


static NSUInteger pageSize = 10;

@interface TheAcceptedOrderTVC ()<MZTimerLabelDelegate>

@end

@implementation TheAcceptedOrderTVC{
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已接订单";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self addHeaderRefresh];
    self.tableView.header.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    [self addFooterRefresh];
    self.tableView.footer.stateHidden = YES;
    
    _dataArray = [[NSMutableArray alloc]init];
    pageIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.header beginRefreshing];
    
}


- (void)headerRefresh{
    pageIndex = 0;
    [self getData];
}
- (void)footerRefresh{
    pageIndex ++;
    [self getData];
}

- (void)getData{
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    BmobQuery *query = [BmobQuery queryWithClassName:kOrder];
    query.limit = pageSize;
    query.skip = pageSize * pageIndex;
    
    [query includeKey:@"user"];
    [query whereKey:@"receive_user" equalTo:user];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        if (error) {
            NSLog(@"%@",error);
        }else{
            
            if (pageIndex == 0) {
                
                [_dataArray removeAllObjects];
                
            }
            
            for (int i = 0; i < array.count; i ++) {
                
                BmobObject *orderObject = [array objectAtIndex:i];
                
                YellModel *model = [[YellModel alloc]init];
                
                model.yellObject = orderObject;
                
                [_dataArray addObject:model];
                
                
            }
            
            
            [self getPhotos];
            
    
        }
        
        
    }];
    
    
}

-(void)getPhotos
{
    
   __block NSInteger count = 0;
    
    for (int i = 0; i < _dataArray.count; i ++) {
        
        YellModel *oneModel = _dataArray[i];
        
        if (!oneModel.photos)
        {
            BmobQuery *query = [[BmobQuery alloc]initWithClassName:kAttachItem];
            
            [query whereKey:@"order" equalTo:oneModel.yellObject];
            
            NSLog(@"yellobjectid:%@",oneModel.yellObject.objectId);
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
             
                count ++;
                
                if (array)
                {
                    
                    NSMutableArray *urls = [[NSMutableArray alloc]init];
                    
                    for (int d =0; d < array.count; d++) {
                        
                        BmobObject *attachObject = array[d];
                        
                        SDPhotoItem *it = [[SDPhotoItem alloc]init];
                        it.thumbnail_pic =[attachObject objectForKey:@"attach_url"];
                        
                        [urls addObject:it];
                        
                    
                        
                      
                    }
                    
                      NSLog(@"photos:%@",array);
                    
                        oneModel.photos = urls;
           
                    
                    
                }
                
                if (count == _dataArray.count)
                {
                    
                    [self.tableView reloadData];
                    
                }
            }];
            
            
            
        }
        else
        {
            count ++;
        }
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    
    
    CGFloat photoViewHeight = 0;
    
      CGFloat textHeight = 0;
    
    if (_dataArray.count > 0) {
        
        YellModel *weiboModel = [_dataArray objectAtIndex:indexPath.section];
        NSArray *imgs = weiboModel.photos;
        
        long imageCount = imgs.count;
        int perRowImageCount = ((imageCount == 4) ? 2 : 3);
        CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
        int totalRowCount = ceil(imageCount / perRowImageCountF);
        
        photoViewHeight = 95 * totalRowCount;
        
        
        
        NSString *text = [weiboModel.yellObject objectForKey:@"content"];
        
        textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth];
        
        if (textHeight < 20)
        {
            
            textHeight = 20;
            
            
        }
    }

    
    
    return 164 + photoViewHeight + textHeight;
    
    
    return 235;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"AcceptedOrderCell";
    AcceptedOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"AcceptedOrderCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    cell.contentView.tag = indexPath.section;
    
    if (_dataArray.count > indexPath.section)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
      
        YellModel *model = [_dataArray objectAtIndex:indexPath.section];
        
        BmobObject *_orderObject = model.yellObject;
        
        BmobUser *publishUser = [_orderObject objectForKey:@"user"];
        
        NSString *nick = [publishUser objectForKey:@"nick"];
        
        double nickWith = [StringHeight widthtWithText:nick font:FONT_16 constrainedToHeight:250];
        cell.name_width.constant = nickWith;
        
        
        cell.people_send.text =nick;
        
        NSString *orderTime = [_orderObject objectForKey:@"order_start_time"];
        
        
        NSString *title = [_orderObject objectForKey:@"order_title"];
        
        NSString *description = [_orderObject objectForKey:@"order_description"];
        
        NSString *address  = [_orderObject objectForKey:@"order_address"];
        
        cell.time.text = orderTime;
        
        cell.title.text = title;
        
        cell.descriptionLabel.text = description;
        
        
        [cell.addressButton setTitle:address forState:UIControlStateNormal];
        
        [cell.addressButton addTarget:self action:@selector(showLocation:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //图片
        if (model.photos) {
            
            cell.photosView.photoItemArray = model.photos;
            
            CGFloat photoViewHeight = 0;
            
            
            YellModel *weiboModel = [_dataArray objectAtIndex:indexPath.section];
            NSArray *imgs = weiboModel.photos;
            
            long imageCount = imgs.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF);
            
            photoViewHeight = 95 * totalRowCount;
            
            cell.heightContraints.constant = photoViewHeight;
            
        }
        else
        {
            cell.heightContraints.constant = 0;
            
        }
        
 
            
        //内容
            
            double textHeight = 20;
            
            NSString *text = [_orderObject objectForKey:@"content"];
            
            textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth];
          
            if (textHeight < 20) {
                
                textHeight = 20;
                
            }
            cell.textHeightContrains.constant = textHeight;
            
            
        
        //倒计时
        
        
        for (UIView *labelview in cell.remainTime.subviews) {
            
            [labelview removeFromSuperview];
            
        }
            MZTimerLabel *_timerLabel = [[MZTimerLabel alloc] initWithLabel:cell.remainTime andTimerType:MZTimerLabelTypeTimer];
            
            double lefttime= [CommonMethods timeLeft:[_orderObject objectForKey:@"order_start_time"] ];
            
         
            [_timerLabel setCountDownTime:lefttime];
            _timerLabel.delegate = self;
            [_timerLabel start];
            
          });
      
    }
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark - 显示地理位置
- (void)showLocation:(UIButton*)sender
{
    
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    
    YellModel *model = [_dataArray objectAtIndex:cell.tag];
    
    BmobGeoPoint *point = [model.yellObject objectForKey:@"location"];
    
    LocationViewController *locVC = [[LocationViewController alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
    locVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:locVC animated:YES];
    
    
}

#pragma mark- MZTimerLabelDelegate
- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    int second = (int)time  % 60;
    int minute = ((int)time / 60) % 60;
    int hours = ((int)(time / 3600))%24;
//    int days = (int)(time/3600/24);
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minute,second];
    //    return [NSString stringWithFormat:@"剩余%1d天 %02d:%02d:%02d",days,hours,minute,second];
}


#pragma mark - 获取图片
-(void)setImageViewWithObject:(YellModel *)weiboModel withView:(SDPhotoGroup*)view
{
    
    //
    
    if (weiboModel.photos)
    {
        
        view.photoItemArray = weiboModel.photos;
        
        
        
        return;
        
    }
    
    
    BmobQuery *query = [BmobQuery queryWithClassName:kAttachItem];
    
    [query whereKey:@"items" equalTo:weiboModel.yellObject];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (error) {
            
        }
        else
        {
            if (array.count > 0)
            {
                NSMutableArray *imgURLs = [[NSMutableArray alloc ]init];
                
                for (int i = 0; i < array.count; i++)
                {
                    
                    
                    BmobObject *attachObject = array[i];
                    
                    SDPhotoItem *it = [[SDPhotoItem alloc]init];
                    it.thumbnail_pic =[attachObject objectForKey:@"attach_url"];
                    
                    [imgURLs addObject:it];
                    
                    
                    
                    
                }
                
                
                weiboModel.photos = imgURLs;
                
                
                
                
                NSInteger tag = [view superview].tag;
                
                
                NSIndexPath *indexpath = [NSIndexPath indexPathForItem:0  inSection:tag];
                
                
                [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
                
                
            }
        }
        
    }];
    
}

@end
