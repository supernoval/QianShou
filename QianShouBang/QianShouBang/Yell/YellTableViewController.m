//
//  YellTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/10.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "YellTableViewController.h"
#import "PublishYellViewController.h"

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
    
   
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.header beginRefreshing];
    
    [self getweibolist];
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
    
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    [query includeKey:@"user"];
    [query orderByDescending:@"creatdAt"];
    [query includeKey:@"attachItem"];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (pageIndex == 0) {
            
            [_weiboListArray removeAllObjects];
            
        }
        
        [_weiboListArray addObjectsFromArray:array];
        
        
        [self.tableView reloadData];
        
        
    }];
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
            return 190;
            
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

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section < _weiboListArray.count)
    {
        
      BmobObject *weiboObject = [_weiboListArray objectAtIndex:indexPath.section];
        
        
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:contentCell];
            
            
                
            
            UIImageView *headImageView = (UIImageView*)[cell viewWithTag:100];
            
            UILabel *headTitle = (UILabel*)[cell viewWithTag:101];
            
            UIImageView *sexImageview = (UIImageView*)[cell viewWithTag:102];
            
            UIImageView *vipImageView = (UIImageView *)[cell viewWithTag:103];
            
            UILabel *timeLabel = (UILabel*)[cell viewWithTag:104];
            
            UILabel *contentLabel = (UILabel*)[cell viewWithTag:105];
            
            UIView *imageView = [cell viewWithTag:106];
            
            headImageView.clipsToBounds = YES;
            headImageView.layer.cornerRadius = 30.0;
                
            BmobUser *user = [[_weiboListArray objectAtIndex:indexPath.section] objectForKey:@"user"];
            
            [headImageView sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"avatar"]]];
            
            
            headTitle.text = [user objectForKey:@"nick"];
                
            contentLabel.text = [weiboObject objectForKey:@"content"];
                
                
            [self setImageViewWithObject:weiboObject withView:imageView];
            
            timeLabel.text = [CommonMethods timeStringFromNow:weiboObject.createdAt];
            
            
            //性别
            NSInteger user_sex = [[user objectForKey:@"user_sex"]integerValue];
            
            if (user_sex == 1) {
                
                sexImageview.image = [UIImage imageNamed:@"male"];
                
            }
            else
            {
                sexImageview.image = [UIImage imageNamed:@"female"];
                
            }
            
            //Vip
//            NSInteger agent_user
            
            
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:infoCell];
            
            UILabel *fromlabel = (UILabel*)[cell viewWithTag:100];
            
            UILabel *distanceLabel = (UILabel*)[cell viewWithTag:101];
            
            UIButton *likeButton = (UIButton*)[cell viewWithTag:102];
            
            UILabel *likeNumLabel = (UILabel*)[cell viewWithTag:103];
            
            UILabel *commentNumlabel = (UILabel*)[cell viewWithTag:104];
            
            
            fromlabel.text = [weiboObject objectForKey:@"build_model"];
            
            NSInteger commentNum = [[weiboObject objectForKey:@"comment_total"]integerValue];
            NSInteger totalNum = [[weiboObject objectForKey:@"total"]integerValue];
            
            commentNumlabel.text = [NSString stringWithFormat:@"%ld",(long)commentNum];
            
            likeNumLabel.text = [NSString stringWithFormat:@"%ld",(long)totalNum];
            
            BmobGeoPoint *point = [weiboObject objectForKey:@"location"];
            
            double distance = [CommonMethods distanceFromLocation:point.latitude longitude:point.longitude];
            
            
            if (distance > 1000) {
                
                distance = distance/1000.0;
                
                distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",distance];
            }
            else
            {
                distanceLabel.text = [NSString stringWithFormat:@"%.0fm",distance];
                
                
            }
            
            
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


-(void)setImageViewWithObject:(BmobObject *)object withView:(UIView*)view
{
    
    
    NSArray *items = [object objectForKey:@"attachItem"];
    
//    if (items)
//    {
//        
//        NSLog(@"items:%ld",(long)items.count);
//        
//        if (items.count > 0)
//        {
//            for (int i = 0; i < items.count; i++)
//            {
//                
//                if (i < 4)
//                {
//                    
//                    BmobObject *attachObject = items[i];
//                    UIImageView *imageView = (UIImageView*)[view viewWithTag:i+1];
//                    [imageView sd_setImageWithURL:[attachObject objectForKey:@"attach_url"]];
//                    
//                    
//                    
//                }
//                
//                
//                
//            }
//            
//        }
//        
//    }
//    BmobQuery *query = [BmobQuery queryWithClassName:kAttachItem];
    
//    [query whereObjectKey:@"items" relatedTo:object];
    
//
//    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        
//        if (error) {
//            
//        }
//        else
//        {
//            if (array.count > 0)
//            {
//                for (int i = 0; i < array.count; i++) {
//                    
//                    if (i < 4)
//                    {
//                        
//                      BmobObject *attachObject = array[i];
//                      UIImageView *imageView = (UIImageView*)[view viewWithTag:i+1];
//                    [imageView sd_setImageWithURL:[attachObject objectForKey:@"attach_url"]];
//                        
//                        
//                        
//                    }
//                   
//                    
//                    
//                }
//                
//            }
//        }
//        
//    }];
    
}





- (IBAction)publish:(id)sender {
    
    PublishYellViewController *pushYell = [self.storyboard instantiateViewControllerWithIdentifier:@"PublishYellViewController"];
    pushYell.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushYell animated:YES];
    
    
    
}
@end
