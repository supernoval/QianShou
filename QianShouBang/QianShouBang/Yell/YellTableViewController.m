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



@interface YellTableViewController ()<UIAlertViewDelegate>
{
    NSMutableArray *_weiboListArray;
    
    NSInteger pageIndex;
    
  
    UIAlertView *_deleteAlertView;
    
    
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
    if (self.tableView.footer.state !=  MJRefreshFooterStateRefreshing)
    {
    
       pageIndex = 0;
       [self getweibolist];
        
    
    }
    
}

-(void)footerRefresh
{
    
    if (self.tableView.header.state !=  MJRefreshHeaderStateRefreshing)
    {
        
        pageIndex ++;
        
        [self getweibolist];
    }
   
    
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
       
      
        
    
        NSMutableArray *muArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < array.count; i ++) {
            
            YellModel *oneModel = [[YellModel alloc]init];
            
            oneModel.yellObject = array[i];
            
        
            [muArray addObject:oneModel];
            
            
        }
        
//        if (pageIndex == 0) {
//            
//            NSMutableArray *newMuArray = [[NSMutableArray alloc]init];
//            
//            for (int i = 0 ; i < muArray.count; i ++) {
//                
//                YellModel *newObjectModel = [muArray objectAtIndex:i];
//                
//                BOOL isexit = NO;
//                
//                for (int d = 0; d < _weiboListArray.count; d++) {
//                    
//                    YellModel* model = [muArray objectAtIndex:d];
//                    
//                    if ([model.yellObject.objectId isEqualToString:newObjectModel.yellObject.objectId])
//                    {
//                        
//                        isexit = YES;
//                        model.yellObject = newObjectModel.yellObject;
//                        
//                        [_weiboListArray replaceObjectAtIndex:d withObject:model];
//                        
//                    }
//                    
//                    
//                    
//                }
//                
//                if (!isexit)
//                {
//                    
//                    [newMuArray addObject:newObjectModel];
//                    
//                }
//                
//            }
//            
//            muArray = newMuArray;
//            
//            [muArray addObjectsFromArray:_weiboListArray];
//            
//        }
//        else
//        {
//            [_weiboListArray addObjectsFromArray:muArray];
//        }
        
        
        
        if (pageIndex == 0)
        {
            
            [self getPhotoswithWeibolist:muArray];
            
        }
        
        else
        {
            NSMutableArray *temMuArray = [[NSMutableArray alloc]initWithArray:_weiboListArray];
            
            [temMuArray addObjectsFromArray:muArray];
            
            [self getPhotoswithWeibolist:temMuArray];
            
        }
        
        
        
       
        
        
//        [self.tableView reloadData];
        
        
    }];
}

-(void)getPhotoswithWeibolist:(NSArray*)weibolist
{
    
    if (weibolist.count == 0)
    {
        
    
        
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
    }
    
    __block NSInteger count = 0;
    
    for (int i = 0; i < weibolist.count; i ++) {
        
        YellModel *oneModel = weibolist[i];
        
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
                
                if (count == weibolist.count)
                {
                    
                 
                    
                    [self endHeaderRefresh];
                    [self endFooterRefresh];
                    
                    
                    [_weiboListArray setArray:weibolist];
                    
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
            
                textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth - 25];
                
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
                
                NSInteger i = (indexPath.section)%11;
                
//                NSLog(@"indexPathsection:%ld,i:%d",(long)indexPath.section,i );
            
                NSString *headString = [NSString stringWithFormat:@"head_default_%ld",(long)i];
                NSString *default_loading = @"default_loading";
                
                NSString *avatar = [user objectForKey:@"avatar"];
                
            
                BmobUser *currentUser = [BmobUser getCurrentUser];
                
                if ([currentUser.objectId isEqualToString:user.objectId]) {
                    
                    cell.deleteButton.hidden = NO;
                    
                    [cell.deleteButton addTarget:self action:@selector(deleteYell:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                else
                {
                    cell.deleteButton.hidden = YES;
                    
                }
            
            
            headTitle.text = [user objectForKey:@"nick"];
            
            cell.nameLabelWithConstrain.constant = [StringHeight widthtWithText:headTitle.text font:FONT_16 constrainedToHeight:21];
                
            
           // 文字内容
                NSString * content = [weiboModel.yellObject objectForKey:@"content"];
//                content = [CommonUtil escapeUnicodeString:content];
                content = [CommonUtil turnStringToEmojiText:content];
                
                contentLabel.text = content;
            
            NSString *text = [weiboModel.yellObject objectForKey:@"content"];
            
            CGFloat  textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth - 25];
            
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
                    
                    int i = indexPath.section%11;
                    
                    NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
                    
                    headImageView.image = nil;
                    
                    headImageView.image = [UIImage imageNamed:headString];
                    
                }
                else
                {
                    if (avatar)
                    {
                        
                        [headImageView sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:default_loading]];
                    }
                    else
                    {
                        headImageView.image = [UIImage imageNamed:headString];
                        
                    }
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
    
    int i = indexPath.section%11;
    
    NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
    BmobUser *user = [weiboModel.yellObject objectForKey:@"user"];
    
     NSString *avatar = [user objectForKey:@"avatar"];
    
    BOOL hideInfo = [[weiboModel.yellObject objectForKey:@"hide_info"]boolValue];

    
    
    YellDetailTableViewController *_detail = [self.storyboard instantiateViewControllerWithIdentifier:@"YellDetailTableViewController"];
    
    _detail.yellmodel = weiboModel;
    
  
    
    if (hideInfo) {
        
        _detail.headImage = headString;
        
    }
    else
    {
        if (!avatar) {
            
            _detail.headImage = headString;
            
        }
    }
    
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

-(void)deleteYell:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    
   
    _deleteAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除该呐喊?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    _deleteAlertView.tag = cell.tag;
    
    [_deleteAlertView show];
    
    
    
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _deleteAlertView && buttonIndex == 1) {
        
        YellModel *model = [_weiboListArray objectAtIndex:alertView.tag];
        
        NSString *objectId = model.yellObject.objectId;
        
        BmobObject *YellObject = [BmobObject objectWithoutDatatWithClassName:kWeiboListItem objectId:objectId];
        
        [MyProgressHUD showProgress];
        
        [YellObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
           
            [MyProgressHUD dismiss];
            
            if (isSuccessful)
            {
                
                [MyProgressHUD showError:@"删除成功"];
                
                [self.tableView.header beginRefreshing];
                
                
                
            }
            else
            {
                 [MyProgressHUD showError:@"删除失败，请重试"];
            }
            
        }];
        
        
    }
}

@end
