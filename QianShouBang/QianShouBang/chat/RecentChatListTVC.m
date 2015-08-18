//
//  RecentChatListTVC.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/18.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RecentChatListTVC.h"
#import "RecentTableViewCell.h"
#import "ChatViewController.h"

@interface RecentChatListTVC ()
{
    NSMutableArray      *_chatsArray;
    
    
}
@end

@implementation RecentChatListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.title = @"聊天消息";
    _chatsArray = [[NSMutableArray alloc]init];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewMessage:) name:@"DidRecieveUserMessage" object:nil];
    
    [self search];
}

-(void)search{
    
    NSArray *array = [[BmobDB currentDatabase] queryRecent];
    
    if (array) {
        
        [_chatsArray setArray:array];
        [self.tableView reloadData];
        
        
    }
}
#pragma mark - UITableView Datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"count:%ld",(long)_chatsArray.count);
    
    return [_chatsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    RecentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[RecentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    BmobRecent *recent = (BmobRecent *)[_chatsArray objectAtIndex:indexPath.row];
    
    if (recent.avatar) {
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:recent.avatar] placeholderImage:[UIImage imageNamed:@"head_default"]];
    }
    
    cell.nameLabel.text      = recent.nick;
    cell.messageLabel.text   = recent.message;
//    cell.lineImageView.image = [UIImage imageNamed:@"common_line"];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteChat:indexPath];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self chatWithSB:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)chatWithSB:(NSIndexPath *)indexPath{
    BmobRecent *recent = (BmobRecent *)[_chatsArray objectAtIndex:indexPath.row];
    
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    
    [infoDic setObject:recent.targetId forKey:@"uid"];
    [infoDic setObject:recent.targetName forKey:@"name"];
    
    if (recent.nick) {
        [infoDic setObject:recent.nick forKey:@"nick"];
    }
    
    if (recent.avatar) {
        [infoDic setObject:recent.avatar forKey:@"avatar"];
    }
    
    
    ChatViewController *cvc = [[ChatViewController alloc] initWithUserDictionary:infoDic];
    cvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cvc animated:YES];
    
}


-(void)deleteChat:(NSIndexPath *)indexPath{
    
    BmobRecent *recent = (BmobRecent *)[_chatsArray objectAtIndex:indexPath.row];
    
    [[BmobDB currentDatabase] deleteRecentWithUid:recent.targetId];
    
    [_chatsArray removeObject:recent];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
    
}


//接收到消息
-(void)didReceiveNewMessage:(NSNotification *)noti{
    
  
    [self search];
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
