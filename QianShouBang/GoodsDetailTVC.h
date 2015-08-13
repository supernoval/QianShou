//
//  GoodsDetailTVC.h
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface GoodsDetailTVC : BaseTableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)BmobObject *obj;

@end
