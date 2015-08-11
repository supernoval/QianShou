//
//  MallTableViewController.h
//  QianShouBang
//
//  Created by ucan on 15/8/7.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MallTableViewController : BaseTableViewController<UITableViewDataSource,UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftItem;
- (IBAction)theExchangesGoods:(UIBarButtonItem *)sender;

@end
