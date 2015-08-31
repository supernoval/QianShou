//
//  CatchOrderTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//


//订单状态3是未付款，4是完成，2是被接单，1是已付款但是未接单，5是接单者取消订单，6是发单者取消订单，10是删除订单纪录，


#import "CatchOrderTVC.h"
#import "LoginViewController.h"
#import "OrderCell.h"
#import "StringHeight.h"
#import "LocationViewController.h"
#import "YellModel.h"
#import "SDPhotoItem.h"
#import "DarenListCell.h"
#import "DarenDetailTableViewController.h"
#import "GuideViewController.h"
#import "Location.h"


static NSString *orderCellId = @"orderCell";

static NSString *dareCellId = @"dasrenCell";




@interface CatchOrderTVC ()<UIAlertViewDelegate>
{
    NSMutableArray *_ordersArray;
    
    NSMutableArray *_darenArray;
    
    NSInteger pageNum;
    NSInteger pageSize;
    
    BmobGeoPoint *currentPoint;
    
    double distance;
    
    UIView *rightView;
    
    UIAlertView *_catchOrderAlert;
    
    BOOL isShowDaRen; //是否显示达人
    
    
    
    
    
}
@end

@implementation CatchOrderTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    


    
    _ordersArray = [[NSMutableArray alloc]init];
    _darenArray = [[NSMutableArray alloc]init];
    
    pageNum = 0;
    pageSize = 10;
    
    CLLocationCoordinate2D coord = [Location shareInstance].currentLocation;
    
    currentPoint = [[BmobGeoPoint alloc]initWithLongitude:coord.longitude WithLatitude:coord.latitude];
    
    
    
    distance = 1000000;
    
    rightView = [self  nearCatagoryVeiw];
    
    isShowDaRen = NO;
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    [self.tableView.header beginRefreshing];
    
   

    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [rightView removeFromSuperview];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //引导页设置
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"FirstLaunch"])
    {
        self.view.alpha = 0;
        [UIView animateWithDuration:3.0 animations:^{
            self.view.alpha = 1;
        }];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"alpha"];
        animation.duration = 3;
        animation.fromValue = @0.5;
        animation.toValue = @1.0;
        [self.view.layer addAnimation:animation forKey:@"animation"];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
        GuideViewController *guideVC = [sb instantiateViewControllerWithIdentifier:@"GuideViewController"];
        [self presentViewController:guideVC animated:NO completion:nil];
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin])
    {
        UINavigationController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }
}


-(void)headerRefresh
{
    pageNum = 0;
    [self getOrders];
    
}
-(void)footerRefresh
{
    pageNum ++;
    
    [self getOrders];
    
}
#pragma mark - 获取订单数据
- (void)getOrders
{
    BmobQuery *query = [BmobQuery queryWithClassName:kOrder];
    
    [query whereKey:@"location" nearGeoPoint:currentPoint withinKilometers:distance];
    
    
    query.limit = pageSize;
    query.skip = pageSize *pageNum;
    [query includeKey:@"user"];
    
    if (isShowDaRen)
    {
        
       [query whereKey:@"order_type" equalTo:@(100)];
    }
    else
    {
        [query whereKey:@"order_type" equalTo:@(0)];
        
        [query whereKey:@"order_state" equalTo:@(OrderStatePayedUnAccepted)];
        
        [query whereKeyDoesNotExist:@"receive_user"];
    }
    
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (error) {
            
            NSLog(@"error:%@",error);
            
        }
        NSMutableArray *temArray = [[NSMutableArray alloc]init];
        
        if (isShowDaRen) {
            
            temArray = _darenArray;
        }
        else
        {
            temArray = _ordersArray;
            
        }
        
        if (array.count > 0)
        {
            if (pageNum == 0) {
                
                [temArray removeAllObjects];
                
            }
            
            
            for (int i = 0; i < array.count; i ++) {
                
                BmobObject *orderObject = [array objectAtIndex:i];
                
                YellModel *model = [[YellModel alloc]init];
                
                model.yellObject = orderObject;
                
                [temArray addObject:model];
                
                
            }
            
            
            if (isShowDaRen) {
                
                _darenArray = temArray;
            }
            else
            {
                _ordersArray = temArray;
                
            }
            
             [self getPhotos];
            
            
            
         }
        else
        {
            
            if (pageNum == 0) {
                
                [temArray removeAllObjects];
                
             }
            
            if (isShowDaRen) {
                
                _darenArray = temArray;
            }
            else
            {
                _ordersArray = temArray;
                
            }
            
            [self getPhotos];
            
       
            
            
        }
        
        if (array.count < pageSize) {
            
            [self removeFooterRefresh];
            
        }
        
        
    }];
    
}



-(void)getPhotos
{
    
    __block NSInteger count = 0;
    
    NSMutableArray *temArray = [[NSMutableArray alloc]init];
    
    if (isShowDaRen) {
        
        temArray = _darenArray;
    }
    else
    {
        temArray = _ordersArray;
        
    }
    
    if (temArray.count == 0) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        [self.tableView reloadData];
    }
    
    for (int i = 0; i < temArray.count; i ++) {
        
        YellModel *oneModel = temArray[i];
        
        if (!oneModel.photos)
        {
            BmobQuery *query = [[BmobQuery alloc]initWithClassName:kAttachItem];
            
            [query whereKey:@"order" equalTo:oneModel.yellObject];
            
//            NSLog(@"yellobjectid:%@",oneModel.yellObject.objectId);
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (error) {
                    
                    NSLog(@"getphotoerror:%@",error);
                    
                }
                
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
                    
//                    NSLog(@"photos:%@",array);
                    
                    oneModel.photos = urls;
                    
                    
                    
                }
                
                if (count == temArray.count)
                {
                    [self endHeaderRefresh];
                    [self endFooterRefresh];
                    
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

#pragma mark - UITableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    
    footerView.backgroundColor = [UIColor clearColor];
    
    return footerView;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_darenArray.count == 0 && _ordersArray.count == 0) {
        
     
        return 1;
        
    }
    
    if (isShowDaRen) {
        
       return  _darenArray.count;
    }
    else
    {
        return _ordersArray.count;
        
        
    }
    return _ordersArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat photoViewHeight = 0;
    
    CGFloat textHeight = 0;
    
    NSMutableArray *temArray = [[NSMutableArray alloc]init];
    
    if (isShowDaRen) {
        
        temArray = _darenArray;
    }
    else
    {
        temArray = _ordersArray;
        
    }
    
    if (temArray.count == 0) {
        
        return 44;
        
    }
    if (temArray.count > 0) {
        
        YellModel *weiboModel = [temArray objectAtIndex:indexPath.section];
        NSArray *imgs = weiboModel.photos;
        
        long imageCount = imgs.count;
        int perRowImageCount = ((imageCount == 4) ? 2 : 3);
        CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
        int totalRowCount = ceil(imageCount / perRowImageCountF);
        
        photoViewHeight = 95 * totalRowCount;
        
        
        
        NSString *text  = [weiboModel.yellObject objectForKey:@"order_description"];;
        
        textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth - 125];
//        textHeight -= 10;
        
        if (textHeight < 20)
        {
            
            textHeight = 20;
            
            
        }
    }
    
    
    
    return 120 + photoViewHeight + textHeight;
    
    return 180;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSMutableArray *temArray = [[NSMutableArray alloc]init];
    
    if (isShowDaRen) {
        
        temArray = _darenArray;
    }
    else
    {
        temArray = _ordersArray;
        
    }

    
    if (temArray.count == 0) {
        
        UITableViewCell *blankCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
        
        blankCell.textLabel.text = @"暂无数据";
        
        blankCell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        blankCell.textLabel.font = FONT_16;
        blankCell.textLabel.textColor = kDarkTintColor;
        
        blankCell.userInteractionEnabled = NO;
        
       
        
        
        return blankCell;
        
    }
    if (isShowDaRen) {
        
        DarenListCell *cell = [tableView dequeueReusableCellWithIdentifier:dareCellId];
        
        if (indexPath.section < temArray.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                YellModel *model = [temArray objectAtIndex:indexPath.section];
                
                BmobObject *_object = model.yellObject;
                
                BmobUser *_user = [_object objectForKey:@"user"];
                
                NSString *avatar = [_user objectForKey:@"avatar"];
                NSString *nick = [_user objectForKey:@"nick"];
                NSInteger user_level = [[_user objectForKey:@"user_level"]integerValue];
                
                int i = arc4random()%10;
                
                NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
                
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:headString]];
                
                cell.nameLabel.text = nick;
                CGFloat nickwith = [StringHeight widthtWithText:nick font:FONT_15 constrainedToHeight:200];
                cell.nickNameWithContraints.constant = nickwith;
                
                if (user_level != 2) {
                    
                    cell.vipImageView.hidden = NO;
                }
                else
                {
                    cell.vipImageView.hidden = YES;
                    
                }
                
                 NSString *title = [_object objectForKey:@"order_title"];
                 cell.titleLabel.text = title;
                
                
                
                //保证金
                CGFloat benjin = [[_object objectForKey:@"order_benjin"]floatValue];
                
                cell.benjinLabel.text = [NSString stringWithFormat:@"已交保证金:%.1f元",benjin];
                
                
                
                NSString *order_description = [_object objectForKey:@"order_description"];
                

                NSString *order_address = [_object objectForKey:@"order_address"];
                BmobGeoPoint *point = [_object objectForKey:@"location"];
                NSString * distanceStr = [CommonMethods distanceStringWithLatitude:point.latitude longitude:point.longitude];
                
                
                
                
                [cell.addressButton setTitle:order_address forState:UIControlStateNormal];
                //        cell.locationButton.titleLabel.adjustsFontSizeToFitWidth = YES;
                
                
                
                [cell.addressButton addTarget:self action:@selector(showLocation:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.distanceLabel.text = distanceStr;
                cell.distanceLabel.adjustsFontSizeToFitWidth = YES;
                
                
                cell.contentView.tag = indexPath.section;
                
               
                
                
                //内容
                
                double textHeight = 20;
                
                
                cell.descripLabel.text = [NSString stringWithFormat:@"%@",order_description];
                
                textHeight = [StringHeight heightWithText:order_description font:FONT_17 constrainedToWidth:ScreenWidth - 125];
//                textHeight -= 10;
                if (textHeight < 20) {
                    
                    textHeight = 20;
                    
                }
                
                
                cell.descripHeight.constant = textHeight;
                
                if (model.photos) {
                    
                    cell.imagesView.photoItemArray = model.photos;
                    
                    CGFloat photoViewHeight = 0;
                    
                    
                    YellModel *weiboModel = [temArray objectAtIndex:indexPath.section];
                    NSArray *imgs = weiboModel.photos;
                    
                    long imageCount = imgs.count;
                    int perRowImageCount = ((imageCount == 4) ? 2 : 3);
                    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
                    int totalRowCount = ceil(imageCount / perRowImageCountF);
                    
                    photoViewHeight = 95 * totalRowCount;
                    
                    cell.imageViewHeightConstraints.constant = photoViewHeight;
                    
                }
                else
                {
                    cell.imageViewHeightConstraints.constant = 0;
                    
                }
                
            });
        }
         return cell;
        
    }
    else
    {
     OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellId];
        
    if (indexPath.section < temArray.count) {
         dispatch_async(dispatch_get_main_queue(), ^{
             
        YellModel *model = [temArray objectAtIndex:indexPath.section];
        
        BmobObject *_object = model.yellObject;
        
        BmobUser *_user = [_object objectForKey:@"user"];
        
        NSString *avatar = [_user objectForKey:@"avatar"];
        NSString *nick = [_user objectForKey:@"nick"];
        NSInteger user_level = [[_user objectForKey:@"user_level"]integerValue];
        
        int i = arc4random()%10;
             
        NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
             
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:headString]];
        
        cell.nicknameLabel.text = nick;
        CGFloat nickwith = [StringHeight widthtWithText:nick font:FONT_15 constrainedToHeight:200];
        cell.nicknameLabelWithConstraint.constant = nickwith;
        
        if (user_level != 2) {
            
            cell.vipImageView.hidden = NO;
        }
        else
        {
            cell.vipImageView.hidden = YES;
            
        }
        
             
  
            
            CGFloat order_commission = [[_object objectForKey:@"order_commission"]floatValue];
            
             cell.moneyLabel.text = [NSString stringWithFormat:@"佣金:%.2f",order_commission];
            cell.moneyLabel.textColor = [UIColor redColor];
            cell.accepteButton.hidden = NO;
        
             
        
        NSString *order_description = [_object objectForKey:@"order_description"];
        
       
       
        
        NSString *order_address = [_object objectForKey:@"order_address"];
        BmobGeoPoint *point = [_object objectForKey:@"location"];
        NSString * distanceStr = [CommonMethods distanceStringWithLatitude:point.latitude longitude:point.longitude];
        
       
            
       
        [cell.locationButton setTitle:order_address forState:UIControlStateNormal];
//        cell.locationButton.titleLabel.adjustsFontSizeToFitWidth = YES;
             
            
          
        [cell.locationButton addTarget:self action:@selector(showLocation:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.distanceLabel.text = distanceStr;
        cell.distanceLabel.adjustsFontSizeToFitWidth = YES;
             
        
        cell.contentView.tag = indexPath.section;
       
        [cell.accepteButton addTarget:self
                               action:@selector(catchOrder:)
                     forControlEvents:UIControlEventTouchUpInside];
        
        
        //内容
        
        double textHeight = 20;
        
        
         cell.descripLabel.text = [NSString stringWithFormat:@"%@",order_description];
        
        textHeight = [StringHeight heightWithText:order_description font:FONT_15 constrainedToWidth:ScreenWidth - 125];
        textHeight -= 10;
        if (textHeight < 20) {
            
            textHeight = 20;
            
        }
        
        
        cell.descripContraints.constant = textHeight;
        
        if (model.photos) {
            
            cell.photoView.photoItemArray = model.photos;
            
            CGFloat photoViewHeight = 0;
            
            
            YellModel *weiboModel = [temArray objectAtIndex:indexPath.section];
            NSArray *imgs = weiboModel.photos;
            
            long imageCount = imgs.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF);
            
            photoViewHeight = 95 * totalRowCount;
            
            cell.photoViewHeightContraint.constant = photoViewHeight;
            
        }
        else
        {
            cell.photoViewHeightContraint.constant = 0;
            
        }
        
                 });
    }
        
           return cell;
    }
    
 
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleInsert;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (isShowDaRen) {
        
        DarenDetailTableViewController *_drVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DarenDetailTableViewController"];
        _drVC.hidesBottomBarWhenPushed = YES;
        
         YellModel *model = [_darenArray objectAtIndex:indexPath.section];
        
        _drVC.darenObject = model.yellObject;
        
        [self.navigationController pushViewController:_drVC animated:YES];
        
        
        
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark- 右上角弹出框
- (UIView *)nearCatagoryVeiw{
    CGFloat width = 100;
    CGFloat height = 160;
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-width-2, 2, width, height)];
    greenView.backgroundColor = kBlueColor;
    
    [CommonMethods addLine:15 startY:height/4 color:[UIColor whiteColor] toView:greenView];
    [CommonMethods addLine:15 startY:height*2/4 color:[UIColor whiteColor] toView:greenView];
    [CommonMethods addLine:15 startY:height*3/4 color:[UIColor whiteColor] toView:greenView];
    
    UIButton *femaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, height/4)];
    femaleBtn.backgroundColor = [UIColor clearColor];
    [femaleBtn setTitle:@"5KM" forState:UIControlStateNormal];
    [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [femaleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    femaleBtn.titleLabel.font = FONT_16;
    [femaleBtn addTarget:self action:@selector(fiveKiloMeters) forControlEvents:UIControlEventTouchUpInside];
    [greenView addSubview:femaleBtn];
    
    UIButton *maleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, height/4, width, height/4)];
    maleBtn.backgroundColor = [UIColor clearColor];
    [maleBtn setTitle:@"10KM" forState:UIControlStateNormal];
    [maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [maleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    maleBtn.titleLabel.font = FONT_16;
    [maleBtn addTarget:self action:@selector(tenKiloMeters) forControlEvents:UIControlEventTouchUpInside];
    [greenView addSubview:maleBtn];
    
    UIButton *thirtyButton = [[UIButton alloc]initWithFrame:CGRectMake(0, height*2/4, width, height/4)];
    thirtyButton.backgroundColor = [UIColor clearColor];
    [thirtyButton setTitle:@"30KM" forState:UIControlStateNormal];
    [thirtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [thirtyButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    thirtyButton.titleLabel.font = FONT_16;
    [thirtyButton addTarget:self action:@selector(thirtyKiloMeters) forControlEvents:UIControlEventTouchUpInside];
    [greenView addSubview:thirtyButton];
    
    UIButton *greetBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, height*3/4, width, height/4)];
    greetBtn.backgroundColor = [UIColor clearColor];
    [greetBtn setTitle:@"不限距离" forState:UIControlStateNormal];
    [greetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [greetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    greetBtn.titleLabel.font = FONT_16;
    [greetBtn addTarget:self action:@selector(unlimitDistance) forControlEvents:UIControlEventTouchUpInside];
    [greenView addSubview:greetBtn];
    
    
    UIControl *backView = [[UIControl alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth, ScreenHeight- 64)];
    
    backView.backgroundColor = kTransParentBackColor;
    
    [backView addTarget:self action:@selector(dismissRight) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:greenView];
    
    
    return backView;
}

- (void)fiveKiloMeters
{
    distance = 5;
    
    [self.tableView.header beginRefreshing];
    
    [self dismissRight];
    
}

-(void)tenKiloMeters
{
    distance = 10;
    
  [self.tableView.header beginRefreshing];
    
    [self dismissRight];
}

-(void)thirtyKiloMeters
{
    distance = 30;
    
    [self.tableView.header beginRefreshing];
    
    [self dismissRight];
}
-(void)unlimitDistance
{
    distance = 1000000;
    
  [self.tableView.header beginRefreshing];
    
    
    [self dismissRight];
}

- (void)dismissRight
{
    [rightView removeFromSuperview];
    
}

#pragma mark - 抢单
- (void)catchOrder:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    
    YellModel *oneModel = [_ordersArray objectAtIndex:cell.tag];
    
    BmobObject *orderObject = oneModel.yellObject;
   
    
    _catchOrderAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"确定接单:%@?",[orderObject objectForKey:@"order_title"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    _catchOrderAlert.tag = cell.tag;
    
    [_catchOrderAlert show];
    
    
    
}

#pragma mark - 显示地理位置
- (void)showLocation:(UIButton*)sender
{
    
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    YellModel *oneModel = [_ordersArray objectAtIndex:cell.tag];
    
    BmobObject *orderObject = oneModel.yellObject;
    BmobGeoPoint *point = [orderObject objectForKey:@"location"];
    
    LocationViewController *locVC = [[LocationViewController alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
    locVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:locVC animated:YES];
      
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)getDistance:(id)sender {
    
    if (rightView.superview) {
        
        [rightView removeFromSuperview];
        
    }
    
    else
    {
        [self.navigationController.view addSubview:rightView];
        
    }
}


#pragma mark - 有事找你 有事找我 切换
- (IBAction)zhaonizhaowo:(id)sender {
    
     UISegmentedControl*switcher = (UISegmentedControl*)sender;
    
    switch (switcher.selectedSegmentIndex) {
        case 0:  // 有事找你
        {
            isShowDaRen = NO;
            [self.tableView reloadData];
            
          [self.tableView.header beginRefreshing];
            
        }
            break;
            
        case 1: //有事找我
        {
            isShowDaRen = YES;
            [self.tableView reloadData];
           [self.tableView.header beginRefreshing];
            
        }
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _catchOrderAlert && buttonIndex == 1)
    {
        
        YellModel *oneModel = [_ordersArray objectAtIndex:alertView.tag];
        
        BmobObject *orderObject = oneModel.yellObject;
        BmobUser *user = [orderObject objectForKey:@"user"];
        
        BmobUser *currentUser = [BmobUser getCurrentUser];
        //判断是不是自己发的订单
        if ([user.objectId isEqualToString:currentUser.objectId]) {
            
            [CommonMethods showDefaultErrorString:@"不能抢自己的订单"];
            
            return;
            
        }
        
        
        [orderObject setObject:user forKey:@"user"];
        [orderObject setObject:currentUser forKey:@"receive_user"];
        
//        [orderObject setObject:@(OrderStateAccepted) forKey:@"order_state"];
        
        
        //抢单时间
        NSString *startString = [CommonMethods getYYYYMMddHHmmssDateStr:[NSDate date]];
        
        [orderObject setObject:startString forKey:@"order_start_time"];
        [orderObject setObject:@(1) forKey:@"order_timeType"];
        
        
        
        [MyProgressHUD showProgress];
        
        [orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            [MyProgressHUD dismiss];
            
            if (isSuccessful) {
                
                [CommonMethods showDefaultErrorString:@"抢单成功"];
                
                [self headerRefresh];
                
                
            }
            else
            {
                [CommonMethods showDefaultErrorString:@"抢单失败"];
                NSLog(@"%@",error);
                
            }
        }];

        
    }
}
@end
