//
//  GeneralTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/13.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "GeneralTVC.h"
#import "RowTextCell.h"

@interface GeneralTVC ()

@end

@implementation GeneralTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通用";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    headView.backgroundColor = [UIColor clearColor];
    
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"RowTextCell";
    RowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RowTextCell" owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.extraText.hidden = YES;
    if (indexPath.section == 0) {
        cell.text.text = @"清理牵手邦存储空间";
    }else if(indexPath.section == 1){
        
            cell.text.text = @"清空聊天记录";
    }
       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIAlertView *alert_1 = [[UIAlertView alloc]initWithTitle:@"是否清除牵手邦存储空间" message:@"点击确认将清除所有缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert_1.tag = 100;
        [alert_1 show];
        
    }else if (indexPath.section == 1){
        UIAlertView *alert_2 = [[UIAlertView alloc]initWithTitle:@"是否清除聊天记录" message:@"点击确认将清除所有关于您的聊天记录信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert_2.tag = 101;
        [alert_2 show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            //清除存储空间
            [[SDImageCache sharedImageCache]cleanDisk];
            [[SDImageCache sharedImageCache]clearMemory];
            [CommonMethods showDefaultErrorString:@"牵手邦存储空间清理成功"];
        }
    }else if (alertView.tag == 101){
        if (buttonIndex == 1) {
            //清除聊天记录
            [[BmobDB currentDatabase]deleteAllRecent];
            [CommonMethods showDefaultErrorString:@"聊天记录清理成功"];
            
        }
        
    }
}
@end
