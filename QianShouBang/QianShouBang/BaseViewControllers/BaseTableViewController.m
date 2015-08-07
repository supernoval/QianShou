//
//  BaseTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()
{
     UITapGestureRecognizer *_tapResign;
}
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBarController.tabBar.tintColor = TabbarTintColor;
    
     _tapResign = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
 
  
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (self.title.length > 0 && !_notNeedSetTitle) {
        
        [self setNavigationTitleColor];
        
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarddidShow) name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyboarddidShow
{
    [self.view addGestureRecognizer:_tapResign];
    
    
}
-(void)hideKeyboard
{
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:_tapResign];
    
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



#pragma mark - 设置title  颜色
-(void)setNavigationTitleColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    self.navigationItem.titleView = label;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Heiti SC" size:18];
    label.backgroundColor = [UIColor clearColor];
    //    label.textColor = [UIColor colorWithRed:0.686 green:0.49 blue:0.231 alpha:1];
    label.textColor = [UIColor whiteColor];
    label.text = self.title;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
