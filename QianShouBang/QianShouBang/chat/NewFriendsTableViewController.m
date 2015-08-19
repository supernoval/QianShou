//
//  NewFriendsTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "NewFriendsTableViewController.h"

@interface NewFriendsTableViewController ()
{
    NSMutableArray *_newFriendsArray;
}
@end

@implementation NewFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新的朋友";
    _newFriendsArray = [[NSMutableArray alloc]init];
    
    [self search];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return  _newFriendsArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newFriendCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
    
    UILabel *usernameLabel = (UILabel*)[cell viewWithTag:100];
    
    UIButton *agreeButton = (UIButton*)[cell viewWithTag:101];
    
    
    cell.contentView.tag = indexPath.section;
    
    
    if (_newFriendsArray.count > indexPath.section) {
        
       BmobInvitation *tmpInvitation = [_newFriendsArray objectAtIndex:indexPath.section];
        
        
        usernameLabel.text = tmpInvitation.fromname;
        
        
        if (tmpInvitation.statue == STATUS_ADD_NO_VALIDATION) {
            
            [agreeButton setTitle:@"同意" forState:UIControlStateNormal];
            [agreeButton addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        else
        {
              [agreeButton setTitle:@"已同意" forState:UIControlStateNormal];
            
               agreeButton.enabled = NO;
            
        }
        
        
        
    }
        
          });
    
    return cell;
    
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self deleteInviteMessage:indexPath];
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)search{
    
    NSArray *array = [[BmobDB currentDatabase] queryBmobInviteList];
    
    if (array) {
       
        [_newFriendsArray setArray:array];
        
    }
    
    
    
    
}

#pragma mark - 删除好友邀请信息
-(void)deleteInviteMessage:(NSIndexPath*)index
{
     BmobInvitation *tmpInvitation = [_newFriendsArray objectAtIndex:index.section];
    [[BmobDB currentDatabase] deleteInviteMsgWithUid:tmpInvitation.fromId time:[NSString stringWithFormat:@"%ld",(long)tmpInvitation.time]];
    
    [_newFriendsArray removeObjectAtIndex:index.section];
    
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index.section] withRowAnimation:UITableViewRowAnimationFade];
    
    
    
    
}

#pragma mark agree

-(void)agree:(UIButton*)sender{
    

    
    BmobInvitation *tmpInvitation = (BmobInvitation *)[_newFriendsArray objectAtIndex:sender.superview.tag];

    
    [[BmobUserManager currentUserManager] agreeAddContactWithInvitation:tmpInvitation block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
           
            [[BmobDB currentDatabase] updateAgreeMessage:tmpInvitation.fromname];
            tmpInvitation.statue = STATUS_ADD_AGREE;
            
            NSLog(@"已同意");
            
            [self.tableView reloadData];
            
       
        }else{
          
            
   
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
