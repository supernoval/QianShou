//
//  PersonInfoSettingTVC.h
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "QSUser.h"

@interface PersonInfoSettingTVC : BaseTableViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)QSUser *currentUser;

@end
