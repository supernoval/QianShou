//
//  AccountDetailViewController.h
//  QianShouBang
//
//  Created by ucan on 15/8/14.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface AccountDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)NSInteger from;
@property (nonatomic, strong)UITableView *tableView;
@end
