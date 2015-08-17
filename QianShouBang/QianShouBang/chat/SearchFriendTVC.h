//
//  SearchFriendTVC.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface SearchFriendTVC : BaseTableViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;




@end
