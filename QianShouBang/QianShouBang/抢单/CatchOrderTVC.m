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

static NSString *orderCellId = @"orderCell";


typedef NS_ENUM(NSInteger, OrderState)
{
    OrderStateUnPay = 3, //未付款
    OrderStateDone = 4,// 完成
    OrderStateAccepted = 2,//被接单
    OrderStatePayedUnAccepted = 1,//已付款未接单
    OrderStateAcceperCancel = 5, //接单者取消订单
    OrderStatePublishCancel = 6, //发单者取消订单
    OrderStateDelete = 10, //删除订单记录
    
    
    
};

@interface CatchOrderTVC ()
{
    NSMutableArray *_ordersArray;
    
    NSMutableArray *_darenArray;
    
    NSInteger pageNum;
    NSInteger pageSize;
    
    
}
@end

@implementation CatchOrderTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _ordersArray = [[NSMutableArray alloc]init];
    _darenArray = [[NSMutableArray alloc]init];
    
    pageNum = 0;
    pageSize = 10;
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    [self.tableView.header beginRefreshing];
    
   

    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
  
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin])
    {
        UINavigationController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:loginVC animated:NO completion:nil];
        
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
    
    [query whereKey:@"order_state" equalTo:@(OrderStatePayedUnAccepted)];
    query.limit = pageSize;
    query.skip = pageSize *pageNum;
    [query includeKey:@"user"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (array.count > 0)
        {
            
              [_ordersArray addObjectsFromArray:array];
            
              [self.tableView reloadData];
            
        }
        
        if (array.count < pageSize) {
            
            [self removeFooterRefresh];
            
        }
        
        
    }];
    
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
    
    return _ordersArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellId];
    
    
    
    return cell;
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
