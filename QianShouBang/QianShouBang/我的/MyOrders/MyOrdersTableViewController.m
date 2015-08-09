//
//  MyOrdersTableViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/8.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MyOrdersTableViewController.h"


static NSString *myOrderCell = @"myOrderCell";



@interface MyOrdersTableViewController ()

@end

@implementation MyOrdersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
    
}

#pragma mark - UITabelViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCell];
    
    UILabel *timeLabel = (UILabel*)[cell viewWithTag:100];
    UILabel *titlelabel = (UILabel*)[cell viewWithTag:101];
    UILabel *contentlabel = (UILabel*)[cell viewWithTag:102];
    UILabel *benjinLabel = (UILabel *)[cell viewWithTag:103];
    UILabel *tipLabel = (UILabel*)[cell viewWithTag:104];
    UILabel *statuslabel = (UILabel *)[cell viewWithTag:105];
    
    
    statuslabel.clipsToBounds = YES;
    statuslabel.layer.cornerRadius = 15.0;
    
    
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
    return 5;
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
