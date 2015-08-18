//
//  ContactTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ContactTVC.h"
#import "ContactCell.h"
#import "SettingTVC.h"
#import "PersonInfoSettingTVC.h"
#import "NearPeopleTVC.h"
#import "NewFriendsTableViewController.h"
#import "ChatViewController.h"

@interface ContactTVC ()
{
    NSArray *_friendListArray;
    
}
@property(strong,nonatomic)UISearchBar *headSearchBar;

@end

@implementation ContactTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.tableHeaderView = [self tableHeadView];
    
    
   
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self getFriendList];
}

-(void)getFriendList
{
//    [[BmobUserManager currentUserManager] queryCurrentContactArray:^(NSArray *array, NSError *error) {
//        NSMutableArray *chatUserArray = [NSMutableArray array];
//        for (BmobUser * user in array)
//        {
//            BmobChatUser *chatUser = [[BmobChatUser alloc] init];
//            chatUser.username      = [user objectForKey:@"username"];
//            chatUser.avatar        = [user objectForKey:@"avatar"];
//            chatUser.nick          = [user objectForKey:@"nick"];
//            chatUser.objectId      = user.objectId;
//            [chatUserArray addObject:chatUser];
//            
//            
//        }
//        
//        
//        _friendListArray = chatUserArray;
//        
//        
//        [self.tableView reloadData];
//        
//    
//    
//    
//    }];
    
    
    NSArray *array = [[BmobDB currentDatabase] contaclList];
    
    if (array) {
       
        _friendListArray = array;
        
        
        [self.tableView  reloadData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma- tableHeadView
- (UIView *)tableHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headView.backgroundColor = kContentColor;
   
    _headSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-10 ,40)];
    
    _headSearchBar.placeholder = @"搜索";
    
    _headSearchBar.backgroundColor = [UIColor clearColor];
    
    [_headSearchBar setBarTintColor:kBlueColor];
    _headSearchBar.layer.borderColor = [UIColor clearColor].CGColor;
    _headSearchBar.layer.borderWidth = 0.0;
    
    _headSearchBar.delegate = self;
    
    //    _headSearchBar.showsCancelButton = YES;
    
    _headSearchBar.searchBarStyle = UISearchBarStyleDefault;
    
    //去掉搜索框背景
    for (UIView *view in _headSearchBar.subviews) {
        
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0)
        {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    [headView addSubview:_headSearchBar];
    return headView;

}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section < 3) {
        
      return 1;
    }
    
    return _friendListArray.count;
    
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section < 3)
    {
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    }
    
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
   
    
    
  
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section < 3) {
        
        return 1;
        
    }
    return 20;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
   
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"ContactCell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ContactCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    
    switch (indexPath.section) {
        case 0:
            cell.image.image = [UIImage imageNamed:@"chat_message"];
            cell.text.text = @"聊天消息";
            break;
            
        case 1:
            cell.image.image = [UIImage imageNamed:@"new_friend"];
            cell.text.text = @"新朋友";
            break;
            
        case 2:
            cell.image.image = [UIImage imageNamed:@"near_by"];
            cell.text.text = @"附近人";
            break;
            
        case 3:
        {
            BmobChatUser *chatUser = [_friendListArray objectAtIndex:indexPath.row];
            if (chatUser.avatar) {
                
                   [cell.image sd_setImageWithURL: [NSURL URLWithString:chatUser.avatar]]; 
            }
        
            if (chatUser.nick) {
                
                 cell.text.text = chatUser.nick;
            }
           
            
            
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    
        switch (indexPath.section) {
                
            case 0:
            {
               
            }
                break;
    
            case 1:
            {
                
                NewFriendsTableViewController *newFriends = [self.storyboard instantiateViewControllerWithIdentifier:@"NewFriendsTableViewController"];
                
                newFriends.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:newFriends animated:YES];
                
                
            }
                break;
    
            case 2:
            {
                NearPeopleTVC *nearTVC = [sb instantiateViewControllerWithIdentifier:@"NearPeopleTVC"];
                nearTVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nearTVC animated:YES];
            }
                break;
            case 3:
            {
                NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
                BmobChatUser *user = (BmobChatUser *)[_friendListArray objectAtIndex:indexPath.row];
                [infoDic setObject:user.objectId forKey:@"uid"];
                [infoDic setObject:user.username forKey:@"name"];
                if (user.avatar) {
                    [infoDic setObject:user.avatar forKey:@"avatar"];
                }
                if (user.nick) {
                    [infoDic setObject:user.nick forKey:@"nick"];
                }
                ChatViewController *cvc = [[ChatViewController alloc] initWithUserDictionary:infoDic];
                cvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cvc animated:YES];
                
            }
                
            default:
                break;
        }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
    
}

- (IBAction)addNewfriends:(id)sender {
    
    
    SearchFriendTVC *searchTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchFriendTVC"];
    
    searchTVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:searchTVC animated:YES];
    
    
    
}
@end
