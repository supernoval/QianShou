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
#import "RecentChatListTVC.h"
#import "UserDetailTVC.h"
#import "NSString+FirstLetter.h"

@interface ContactTVC ()<UIAlertViewDelegate>
{
    NSMutableArray *_friendListArray;
    UIAlertView *_deleteContactAlert;
    
    
    
    
}
@property(strong,nonatomic)UISearchBar *headSearchBar;

@end

@implementation ContactTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人";
    
    _friendListArray = [[NSMutableArray alloc]init];
    
    
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.tableHeaderView = [self tableHeadView];
    
    _deleteContactAlert = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除该联系人?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
   
    
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
//        if (chatUserArray) {
//            
//             [self sortedFriendsWithArray:chatUserArray];
//        }
//        
//  
//        
//    
//    
//    
//    }];
    
    
    NSArray *array = [[BmobDB currentDatabase] contaclList];
    
    if (array)
    {
       
        [self sortedFriendsWithArray:array];
        
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
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
  return  [[NSMutableArray arrayWithObjects: UITableViewIndexSearch,nil] arrayByAddingObjectsFromArray :[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    
    return index;
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
   
    if (section < [[UILocalizedIndexedCollation currentCollation] sectionTitles].count) {
      
        NSArray *bmobArray = [_friendListArray objectAtIndex:section-1];
        BmobChatUser *user = [bmobArray firstObject];
        
        NSString *shortchar = user.nick;
        NSString *firstLetter = [shortchar firstLetter];
        
        return firstLetter;
        
//        const char *objectChar = [shortchar UTF8String];
//        return [[NSString alloc]initWithFormat:@"%c",objectChar[0]];
        
   
//   return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
        
        
        }
    return nil;
    
    
   
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
      return 3;
    }
    
    if (_friendListArray.count > section-1) {
        
        NSArray *oneSectionFriends = [_friendListArray objectAtIndex:section-1];
        
        return oneSectionFriends.count;
    }
   
    return 0;
    
    
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _friendListArray.count + 1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    if (section < 3)
//    {
//        
//        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//        headView.backgroundColor = [UIColor clearColor];
//        return headView;
//    }
//    
//    
//    
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    headView.backgroundColor = [UIColor clearColor];
//    return headView;
//   
//    
//    
//  
//    
//}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        
        return 0;
        
    }
    
    if (section-1 < _friendListArray.count) {
        
        NSArray *oneSectionFriends = [_friendListArray objectAtIndex:section -1];
        
        if (oneSectionFriends.count > 0) {
            
            return 20;
        }
        else
        {
            return 0;
        }
       
    }
    
    return 0;
    
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
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
            switch (indexPath.row) {
                case 0:
                {
                    cell.image.image = [UIImage imageNamed:@"chat_message"];
                    cell.text.text = @"聊天消息";
                }
                    break;
                case 1:
                {
                    cell.image.image = [UIImage imageNamed:@"new_friend"];
                    cell.text.text = @"新朋友";
                }
                    break;
                case 2:
                {
                    cell.image.image = [UIImage imageNamed:@"near_by"];
                    cell.text.text = @"附近人";
                }
                    break;
                    
                    
                default:
                    break;
            }
          
            break;
            

            
        default:
        {
            if (_friendListArray.count > indexPath.section -1) {
                
                

            NSArray *oneSectionFriends = [_friendListArray objectAtIndex:indexPath.section -1];
            
            BmobChatUser *chatUser = [oneSectionFriends objectAtIndex:indexPath.row];
            
//                NSString *avatar = [chatUser objectForKey:@"avatar"];
            
            if (chatUser.avatar)
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   [cell.image sd_setImageWithURL: [NSURL URLWithString:chatUser.avatar] placeholderImage:[UIImage imageNamed:@"default_loading"]];
                });
               
                
            }
            else
            {
                
                NSInteger i = indexPath.row%11;
                
                cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"head_default_%ld",(long)i]];
                
                
                
            }
            
            if (chatUser.nick) {
                
                cell.text.text = chatUser.nick;
            }
                
                  }
            
        }
            break;
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                RecentChatListTVC *recentChat = [[RecentChatListTVC alloc]initWithStyle:UITableViewStyleGrouped];
                
                recentChat.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:recentChat animated:YES];
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
                
                
            default:
                break;
        }
    }
    
    else
    {
        
        NSArray *friends = [_friendListArray objectAtIndex:indexPath.section -1];
        
       
        
        
        NSInteger i = indexPath.row%11;
        
        NSString *headString = [NSString stringWithFormat:@"head_default_%ld",(long)i];
        
        
        BmobUser *user = [friends objectAtIndex:indexPath.row];
        
        UserDetailTVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetailTVC"];
        
        detailVC.fromType = FromTypeFriendList;
        
        detailVC.user = user;
        
        
        NSString *avatar = [user objectForKey:@"avatar"];
        
        if (!avatar) {
            
            NSInteger i = indexPath.row%11;
            
            avatar =  [NSString stringWithFormat:@"head_default_%ld",(long)i];
        }
      
        
    
            
            detailVC.headImageString = avatar;
        
        
        
        
        detailVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
  
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 删除联系人
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 2) {
        
        return YES;
    }
    
    return NO;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 2) {
        
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showdeleteAlertView:indexPath];
}

-(void)showdeleteAlertView:(NSIndexPath*)indexPath
{
    _deleteContactAlert.tag = indexPath.row;
    
    [_deleteContactAlert show];
}

-(void)deleteFriendWithindexRow:(NSInteger)tag
{
    BmobChatUser *_user = [_friendListArray objectAtIndex:tag];
    

    
    [MyProgressHUD showProgress];
    
    [[BmobUserManager currentUserManager] deleteContactWithUid:_user.objectId block:^(BOOL isSuccessful, NSError *error) {
        
        [MyProgressHUD dismiss];
        
        if (isSuccessful)
        {
            
            if (_friendListArray.count > 0)
            {
                [_friendListArray removeObject:_user];
                
                [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:tag inSection:3]] withRowAnimation:UITableViewRowAnimationFade];
                
            }
            else
            {
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
                
                
            }
        }
        else
        {
            [MyProgressHUD showError:@"删除失败"];
            
        }
        
    }];
    

    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _deleteContactAlert ) {
        
        if (buttonIndex == 0) {
            
            [self.tableView setEditing:NO animated:YES];
            
        }
        else
        {
            [self deleteFriendWithindexRow:alertView.tag];
            
        }
        
    }
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


-(void)sortedFriendsWithArray:(NSArray*)array
{
    
    //将所有城市排序
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *unsortedSections = [[NSMutableArray alloc] initWithCapacity:[[collation sectionTitles] count]];
    for (NSUInteger i = 0; i < [[collation sectionTitles] count]; i++)
    {
        
        [unsortedSections addObject:[NSMutableArray array]];
    }
    
    for ( int i = 0; i<array.count ; i++)
    {
      
        BmobChatUser *chatUser = [array objectAtIndex:i];
        
        NSString *citynamepinyin = chatUser.nick;
        
        NSInteger index = [collation sectionForObject:citynamepinyin collationStringSelector:@selector(description)];
        
        [[unsortedSections objectAtIndex:index] addObject:chatUser];
    }
    
    
    
    NSMutableArray *sortedSections = [[NSMutableArray alloc] initWithCapacity:unsortedSections.count];
    for (NSMutableArray *section in unsortedSections)
    {
        [sortedSections addObject: [collation sortedArrayFromArray:section collationStringSelector:@selector(description)]];
    }
    
    NSMutableArray *temMuArray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < sortedSections.count; i ++) {
        
        NSArray *array = [sortedSections objectAtIndex:i];
        
        if (array.count > 0) {
            
            [temMuArray addObject:array];
            
        }
    }
    
    [_friendListArray setArray:temMuArray];
    
    
    
    [self.tableView reloadData];
    
    
}
@end
