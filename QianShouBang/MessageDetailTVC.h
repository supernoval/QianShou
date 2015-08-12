//
//  MessageDetailTVC.h
//  QianShouBang
//
//  Created by ucan on 15/8/11.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MessageDetailTVC : BaseTableViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)BmobObject *messageObj;

@end
