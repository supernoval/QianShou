//
//  YellTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/10.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "YellTableViewController.h"
#import "PublishYellViewController.h"
#import "SDPhotoGroup.h"
#import "SDBrowserImageView.h"
#import "SDPhotoItem.h"
#import "YellCell.h"
#import "StringHeight.h"
#import "CommonUtil.h"
#import "YellDetailTableViewController.h"



static NSString *contentCell = @"contentCell";

static NSString *infoCell = @"infoCell";
static NSInteger pageSize = 10;



@interface YellTableViewController ()
{
    NSMutableArray *_weiboListArray;
    
    NSInteger pageIndex;
    
  
   
    
}
@end

@implementation YellTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _weiboListArray = [[NSMutableArray alloc]init];
  
    
    
    pageIndex = 0;
    
    
    [self addHeaderRefresh];
    
    [self addFooterRefresh];
    
     [self getweibolist];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
  
}

-(void)headerRefresh
{
    pageIndex = 0;
    [self getweibolist];
    
    
}

-(void)footerRefresh
{
    pageIndex ++;
    
    [self getweibolist];
    
}

-(void)getweibolist
{
    BmobQuery *query = [BmobQuery queryWithClassName:kWeiboListItem];
    
    query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    [query includeKey:@"user"];
    
    
    [query orderByDescending:@"createdAt"];
    
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (pageIndex == 0) {
            
            [_weiboListArray removeAllObjects];
            
        }
        
        for (int i = 0; i < array.count; i ++) {
            
            YellModel *oneModel = [[YellModel alloc]init];
            
            oneModel.yellObject = array[i];
            
            [_weiboListArray addObject:oneModel];
            
            
        }
        
        [self getPhotos];
        
        
//        [self.tableView reloadData];
        
        
    }];
}

-(void)getPhotos
{
    
    __block NSInteger count = 0;
    
    for (int i = 0; i < _weiboListArray.count; i ++) {
        
        YellModel *oneModel = _weiboListArray[i];
        
        if (!oneModel.photos)
        {
            BmobQuery *query = [[BmobQuery alloc]initWithClassName:kAttachItem];
            
            [query whereKey:@"items" equalTo:oneModel.yellObject];
            
//            NSLog(@"yellobjectid:%@",oneModel.yellObject.objectId);
            
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
                    
//                    NSLog(@"photos:%@",array);
                    
                    oneModel.photos = urls;
                    
                    
                    
                }
                
                if (count == _weiboListArray.count)
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    
    blankView.backgroundColor = [ UIColor clearColor];
    
    
    return blankView;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
              YellModel *weiboModel = [_weiboListArray objectAtIndex:indexPath.section];
            
              CGFloat photoViewHeight = 0;
            
                
                NSArray *imgs = weiboModel.photos;
                
                long imageCount = imgs.count;
                int perRowImageCount = ((imageCount == 4) ? 2 : 3);
                CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
                int totalRowCount = ceil(imageCount / perRowImageCountF);
                
                photoViewHeight = 95 * totalRowCount;
                
                
                
                CGFloat textHeight = 0;
                
                
                NSString *text = [weiboModel.yellObject objectForKey:@"content"];
            
//            text = [CommonUtil turnStringToEmojiText:text];
            
                textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth - 16];
                
                if (textHeight < 30)
                {
                    
                    textHeight = 30;
                
         
                   }
            
            
            
              return 158 + photoViewHeight + textHeight;
           
            
            
            
        }
            break;
        case 1:
        {
            return 70;
            
        }
            break;
            
            
        default:
            break;
    }
    
    return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _weiboListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YellCell *cell = nil;
    
    if (indexPath.section < _weiboListArray.count)
    {
        
      YellModel *weiboModel = [_weiboListArray objectAtIndex:indexPath.section];
        
        
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:contentCell];
            
            
          
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.contentView.tag = indexPath.section;
           
            UIImageView *headImageView = (UIImageView*)[cell viewWithTag:100];
            
            UILabel *headTitle = (UILabel*)[cell viewWithTag:101];
            
            UIImageView *sexImageview = (UIImageView*)[cell viewWithTag:102];
            
            UIImageView *vipImageView = (UIImageView *)[cell viewWithTag:103];
            
            UILabel *timeLabel = (UILabel*)[cell viewWithTag:104];
            
            UILabel *contentLabel = (UILabel*)[cell viewWithTag:105];
            
          SDPhotoGroup *imageView = (SDPhotoGroup*)[cell viewWithTag:106];
            
            headImageView.clipsToBounds = YES;
            headImageView.layer.cornerRadius = 30.0;
                
            BmobUser *user = [weiboModel.yellObject objectForKey:@"user"];
            
                NSInteger viplevel = [[user objectForKey:@"user_level"]integerValue];
                if (viplevel == 2) {
                    
                    vipImageView.hidden = NO;
                }
                else
                {
                    vipImageView.hidden = YES;
                    
                }
                
                int i = arc4random()%10;
                
                NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
            [headImageView sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:headString]];
            
            
            headTitle.text = [user objectForKey:@"nick"];
            
            cell.nameLabelWithConstrain.constant = [StringHeight widthtWithText:headTitle.text font:FONT_15 constrainedToHeight:21];
                
            
           // 文字内容
                NSString * content = [weiboModel.yellObject objectForKey:@"content"];
//                content = [CommonUtil escapeUnicodeString:content];
//                content = [CommonUtil turnStringToEmojiText:content];
                
                contentLabel.text = content;
            
            NSString *text = [weiboModel.yellObject objectForKey:@"content"];
            
            CGFloat  textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth - 16];
            
            if (textHeight < 30) {
                
                textHeight = 30;
            }
            
            cell.contentTextHeight.constant = textHeight;
            
            
            
            
            //图片view  高度
      
            
            

                
            if (weiboModel.photos)
            {
                    
                imageView.photoItemArray = weiboModel.photos;
                    
                }
                
                
            
            CGFloat photoViewHeight = 0;
            
         
            NSArray *imgs =weiboModel.photos;
                        
            long imageCount = imgs.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF);
            photoViewHeight  = 95 * totalRowCount;
                
        
            cell.photoViewHeight.constant = photoViewHeight;
            
            
            
            timeLabel.text = [CommonMethods timeStringFromNow:weiboModel.yellObject.createdAt];
            
            
            
            //性别
            NSInteger user_sex = [[user objectForKey:@"user_sex"]integerValue];
            
            if (user_sex == 1) {
                
                sexImageview.image = [UIImage imageNamed:@"male"];
                
            }
            else
            {
                sexImageview.image = [UIImage imageNamed:@"female"];
                
            }
            
      
            
            UILabel *fromlabel = (UILabel*)[cell viewWithTag:107];
            
            UILabel *distanceLabel = (UILabel*)[cell viewWithTag:108];
            
            UIButton *likeButton = (UIButton*)[cell viewWithTag:109];
            
            UILabel *likeNumLabel = (UILabel*)[cell viewWithTag:110];
            
            UILabel *commentNumlabel = (UILabel*)[cell viewWithTag:111];
            
                BOOL hadzan = [self hadZan:weiboModel.yellObject];
                
                if (hadzan) {
                    
                    [likeButton setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
                    
                }
                else
                {
                  
                    [likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
                    
                }
                
                [likeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
                
            
            fromlabel.text = [weiboModel.yellObject objectForKey:@"build_model"];
            
            NSInteger commentNum = [[weiboModel.yellObject objectForKey:@"comment_total"]integerValue];
            NSInteger totalNum = [[weiboModel.yellObject objectForKey:@"zan_total"]integerValue];
            
            commentNumlabel.text = [NSString stringWithFormat:@"%ld",(long)commentNum];
            
            likeNumLabel.text = [NSString stringWithFormat:@"%ld",(long)totalNum];
            
            BmobGeoPoint *point = [weiboModel.yellObject objectForKey:@"location"];
            
            double distance = [CommonMethods distanceFromLocation:point.latitude longitude:point.longitude];
            
            
            if (distance > 1000) {
                
                distance = distance/1000.0;
                
                distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",distance];
            }
            else
            {
                distanceLabel.text = [NSString stringWithFormat:@"%.0fm",distance];
                
                
            }
                
                BOOL hideInfo = [[weiboModel.yellObject objectForKey:@"hide_info"]boolValue];
                
                
                //匿名 隐藏信息
                if (hideInfo) {
                    
                    headTitle.text = @"匿名";
                    
                    distanceLabel.text = @"0.0km";
                    
                    int i = arc4random()%10;
                    
                    NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
                    
                    headImageView.image = [UIImage imageNamed:headString];
                    
                }
            
              });
            
        }
            break;
    
            
            
        default:
        {
            
        }
            break;
    }
    }
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      YellModel *weiboModel = [_weiboListArray objectAtIndex:indexPath.section];
    
    YellDetailTableViewController *_detail = [self.storyboard instantiateViewControllerWithIdentifier:@"YellDetailTableViewController"];
    _detail.yellmodel = weiboModel;
    
    _detail.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:_detail animated:YES];
    
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (IBAction)publish:(id)sender {
    
    PublishYellViewController *pushYell = [self.storyboard instantiateViewControllerWithIdentifier:@"PublishYellViewController"];
    pushYell.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushYell animated:YES];
    
    
    
}

-(void)likeAction:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    
    YellModel *model = [_weiboListArray objectAtIndex:cell.tag];
    
    NSString *objectId = model.yellObject.objectId;
    
    BmobUser *currentUser = [BmobUser getCurrentUser];
    
    NSString *userObjectId = currentUser.objectId;
    
    NSArray *zanArray = [[NSUserDefaults standardUserDefaults ] objectForKey:kZanList];
    
    BOOL finalZan = YES;
    
    if (zanArray)
    {
        NSMutableArray *muZanArray = [[NSMutableArray alloc]initWithArray:zanArray];
        
       
        
        
        BOOL had = NO;
        
        for (int i = 0 ; i < zanArray.count; i ++) {
            
            NSDictionary *dict = [zanArray objectAtIndex:i];
            
            NSString *temObjectId = [dict objectForKey:@"weiboObjectId"];
            NSString *temuserObjectId = [dict objectForKey:@"userObjectId"];
            
            if ([temObjectId isEqualToString:objectId] && [temuserObjectId isEqualToString:userObjectId]) {
                
                BOOL hadzan = [[dict objectForKey:@"hadzan"]boolValue];
                
                if (hadzan) {
                    
                    hadzan = NO;
                    
                    finalZan = NO;
                    
                }
                else
                {
                    hadzan = YES;
                    
                  
                    
                }
                
                NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
                [mudict setObject:@(hadzan) forKey:@"hadzan"];
                
                [muZanArray replaceObjectAtIndex:i withObject:mudict];
                
                
                had = YES;
                
            }
        }
        
        
        if (!had)
        {
            
         
            
            NSDictionary *dict = @{@"weiboObjectId":objectId,@"userObjectId":userObjectId,@"hadzan":@YES};
            
            [muZanArray addObject:dict];
            
        }
        
        [[NSUserDefaults standardUserDefaults ] setObject:muZanArray forKey:kZanList];
        [[NSUserDefaults standardUserDefaults ] synchronize];
        
        
    }
    else
    {
        NSArray *zanArray = @[@{@"weiboObjectId":objectId,@"userObjectId":userObjectId,@"hadzan":@YES}];
        
        [[NSUserDefaults standardUserDefaults ] setObject:zanArray forKey:kZanList];
        [[NSUserDefaults standardUserDefaults ] synchronize];
        
  
        
        
    }
    
//    BmobUser *fromuser = [model.yellObject objectForKey:@"user"];
//    
//    [model.yellObject setObject:fromuser forKey:@"user"];
    
    NSInteger zanNum = [[model.yellObject objectForKey:@"zan_total"]integerValue];
    
    
    
    

    
    BmobObject *object = [BmobObject objectWithoutDatatWithClassName:kWeiboListItem objectId:model.yellObject.objectId];
    
    if (finalZan) {
        
        [object incrementKey:@"zan_total"];
    }
    else
    {
        if (zanNum > 0)
        {
            
            [object decrementKey:@"zan_total"];
            
        }
        
        
    }
    
    [MyProgressHUD showProgress];
    
    [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        
        if (isSuccessful)
        {
            
            BmobQuery *query = [BmobQuery queryWithClassName:kWeiboListItem];
            [query includeKey:@"user"];
            [query whereKey:@"objectId" equalTo:object.objectId];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (array) {
                    
                    BmobObject *firstObject = [array firstObject];
                    model.yellObject = firstObject;
                    
                    [self.tableView reloadData];
                    
                }
                
                [MyProgressHUD dismiss];
                
            }];
            
            
            
        
        
        }
     
     
        if (error) {
            
            NSLog(@"error:%@",error);
            [MyProgressHUD dismiss];
            
        }
        
    }];
}

-(BOOL)hadZan:(BmobObject*)weiboObject
{
    NSString *objectId = weiboObject.objectId;
    
    BmobUser *currentUser = [BmobUser getCurrentUser];
    
    NSString *userObjectId = currentUser.objectId;
    
    NSArray *zanArray = [[NSUserDefaults standardUserDefaults ] objectForKey:kZanList];
    
    if (zanArray)
    {
        
        for (int i = 0 ; i < zanArray.count; i ++) {
            
            NSDictionary *dict = [zanArray objectAtIndex:i];
            
            NSString *temObjectId = [dict objectForKey:@"weiboObjectId"];
            NSString *temuserObjectId = [dict objectForKey:@"userObjectId"];
            BOOL hadZan = [[dict objectForKey:@"hadzan"]boolValue];
            
            
            if ([temObjectId isEqualToString:objectId] && [temuserObjectId isEqualToString:userObjectId] && hadZan) {
                
                
                return YES;
                
            }
        }
        
    }
    
    return NO;
    
}
@end
