//
//  ContactTVC.h
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SearchFriendTVC.h"

@interface ContactTVC : BaseTableViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


- (IBAction)addNewfriends:(id)sender;


@end
