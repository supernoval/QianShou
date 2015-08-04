//
//  BaseTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.tintColor = TabbarTintColor;
    
    
 
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)addHeaderRefresh
{
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    
    
    
    
}
-(void)headerRefresh
{
    
    
}

-(void)addFooterRefresh
{
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    
}
-(void)footerRefresh
{
    
}

-(void)endHeaderRefresh
{
    [self.tableView.header endRefreshing];
    
}
-(void)endFooterRefresh
{
    [self.tableView.footer endRefreshing];
    
}

-(void)removeHeaderRefresh
{
    [self.tableView removeHeader];
    
}
-(void)removeFooterRefresh
{
    [self.tableView removeFooter];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
