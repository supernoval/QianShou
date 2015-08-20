//
//  MyOrdersTableViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/8.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MyOrdersTableViewController.h"


static NSString *myOrderCell = @"myOrderCell";

static NSInteger pageSize = 10;


@interface MyOrdersTableViewController ()
{
    NSInteger index;
    
    NSMutableArray *ordersArray ;
    
    
}
@end

@implementation MyOrdersTableViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    ordersArray = [[NSMutableArray alloc]init];
    
    [self addHeaderRefresh];
    
    [self addFooterRefresh];
    
    index = 0;
    
//    [self getOrders];
    
    [self.tableView.header beginRefreshing];
    
    
    
}

-(void)headerRefresh
{
    index = 0;
    [self getOrders];
}

-(void)footerRefresh
{
    index ++;
    [self getOrders];
    
}


-(void)getOrders
{
    BmobQuery *query = [[BmobQuery alloc]initWithClassName:kOrder];
    
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser].objectId];
    
    
    query.limit = pageSize;
    query.skip = pageSize *index;

   
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (index == 0) {
            
            [ordersArray removeAllObjects];
            
            
            
        }
        
        [ordersArray addObjectsFromArray:array];
        
        
        [self.tableView reloadData];
        
        
    }];
    
    
}
#pragma mark - UITabelViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCell];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
   
    
    UILabel *timeLabel = (UILabel*)[cell viewWithTag:100];
    UILabel *titlelabel = (UILabel*)[cell viewWithTag:101];
    UILabel *contentlabel = (UILabel*)[cell viewWithTag:102];
    UILabel *benjinLabel = (UILabel *)[cell viewWithTag:103];
    UILabel *tipLabel = (UILabel*)[cell viewWithTag:104];
    UILabel *statuslabel = (UILabel *)[cell viewWithTag:105];
    
    
    statuslabel.clipsToBounds = YES;
    statuslabel.layer.cornerRadius = 15.0;
    
    
    if (indexPath.section < ordersArray.count) {
        
        BmobObject *oneObject = [ordersArray objectAtIndex:indexPath.section];
        
        timeLabel.text = [CommonMethods getYYYYMMddhhmmDateStr:oneObject.createdAt];
        
        
        titlelabel.text = [oneObject objectForKey:@"order_title"];
        
        contentlabel.text = [oneObject objectForKey:@"order_description"];
        
        benjinLabel.text = [NSString stringWithFormat:@"%.2f元",[[oneObject objectForKey:@"order_benjin"]floatValue]];
        
        tipLabel.text = [NSString stringWithFormat:@"%.2f元",[[oneObject objectForKey:@"order_commission"]floatValue]];
        
        switch ([[oneObject objectForKey:@"order_state"]integerValue]) {
            case 0:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
                
            default:
            {
                
            }
                break;
        }
        
        
        
    }
    
         });
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ordersArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    
    blankView.backgroundColor = [UIColor clearColor];
    
    
    return blankView;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
