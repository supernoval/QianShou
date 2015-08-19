//
//  SearchFriendTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "SearchFriendTVC.h"

@interface SearchFriendTVC ()
{
    NSArray *_friendsArray;
    
}
@end

@implementation SearchFriendTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    self.title = @"新增好友";
    
    
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 52);
    
    _searchBar.delegate =self;
    
    
    
    
    
    
}

#pragma mark - UITableViewDataSource
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell"];
      cell.tag = indexPath.section;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    UILabel *contactLabel = (UILabel*)[cell viewWithTag:100];
    
    UIButton *addButton = (UIButton*)[cell viewWithTag:101];
    
    [addButton addTarget:self action:@selector(addNewFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (indexPath.section < _friendsArray.count) {
        
        BmobUser *user = [_friendsArray objectAtIndex:indexPath.section];
        
        contactLabel.text = user.username;
        
        
    }
       
    });
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return _friendsArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    footerView.backgroundColor = [UIColor clearColor];
    
    
    return footerView;
    
}

-(void)addNewFriend:(UIButton*)sender
{
    UITableViewCell *cell =  (UITableViewCell*)[sender superview];
    
    BmobUser *user = [_friendsArray objectAtIndex:cell.tag];
    
    [self sendNewFriendRequest:user];
    
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    
    if (searchBar.text.length > 0) {
        
        [self searchFriendsWithUsername:searchBar.text];
        
    }
}

-(void)searchFriendsWithUsername:(NSString*)username
{
    [MyProgressHUD showProgress];
    
    [[BmobUserManager currentUserManager] queryUserByName:username block:^(NSArray *array, NSError *error) {
        
        [MyProgressHUD dismiss];
        
        if (array.count > 0 ) {
            
            _friendsArray = array;
            NSLog(@"friends:%@",_friendsArray);
            
            [self.tableView reloadData];
            
           
        }
        else
        {
            [MyProgressHUD showError:@"未找到匹配结果"];
            
        }
    }];
}

-(void)sendNewFriendRequest:(BmobUser*)user
{
  
    [MyProgressHUD showProgress];
    
    [[BmobChatManager currentInstance] sendMessageWithTag:TAG_ADD_CONTACT targetId:user.objectId block:^(BOOL isSuccessful, NSError *error) {
        
        [MyProgressHUD dismiss];
        
        
        if (isSuccessful) {
            NSLog(@"send requst success!");
            
            [CommonMethods showDefaultErrorString:@"好友请求发送成功"];
            
        }else{
            
            [CommonMethods showDefaultErrorString:@"好友请求发送失败"];
            NSLog(@"send requst fail:%@!",error);
            
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
