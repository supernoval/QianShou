//
//  YellTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/10.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "YellTableViewController.h"

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
            
              
                
            BmobUser *user = [[_weiboListArray objectAtIndex:indexPath.section] objectForKey:@"user"];
            
            headTitle.text = [user objectForKey:@"nick"];
                
                contentLabel.text = [weiboObject objectForKey:@"content"];
                
                
          
            
            
            
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








@end
