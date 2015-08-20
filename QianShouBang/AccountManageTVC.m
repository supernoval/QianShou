//
//  AccountManageTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "AccountManageTVC.h"
#import "RowTextCell.h"
#import "ChangeCodeTVC.h"
#import "ApplyVipTVC.h"

@interface AccountManageTVC ()

@end

@implementation AccountManageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户管理";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
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
    
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"RowTextCell";
    RowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RowTextCell" owner:self options:nil][0];
    }
    cell.extraText.hidden = YES;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.text.text = @"更改密码";
        }else if(indexPath.row ==1 ){
            cell.text.text = @"会员申请";
        }
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.text.text = @"抢单权限申请";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ChangeCodeTVC *changeCode = [storyboard instantiateViewControllerWithIdentifier:@"ChangeCodeTVC"];
            [self.navigationController pushViewController:changeCode animated:YES];
        }else if(indexPath.row == 1){//会员申请
            ApplyVipTVC *applyVip = [sb instantiateViewControllerWithIdentifier:@"ApplyVipTVC"];
            [self.navigationController pushViewController:applyVip animated:YES];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {//抢单权限申请
            
        }
    }
}

@end
