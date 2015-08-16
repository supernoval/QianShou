//
//  SettingTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "SettingTVC.h"
#import "RowTextCell.h"
#import "AccountManageTVC.h"
#import "PrivacyTVC.h"
#import "GeneralTVC.h"
#import "AboutQianShouBangTVC.h"
#import "LoginViewController.h"

@interface SettingTVC ()

@end

@implementation SettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self tableFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 2;
    }else{
        return 1;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    headView.backgroundColor = [UIColor clearColor];
    
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
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
    cell.extraText.hidden = YES;
    if (indexPath.section == 0) {
        cell.text.text = @"账户管理";
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.text.text = @"隐私";
        }else if(indexPath.row == 1){
            cell.text.text = @"通用";
        }
    }else if(indexPath.section == 2){
        cell.text.text = @"分享";
    }else if(indexPath.section == 3){
        cell.text.text = @"关于牵手帮";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {//账户管理
                AccountManageTVC *accountTVC = [sb instantiateViewControllerWithIdentifier:@"AccountManageTVC"];
                [self.navigationController pushViewController:accountTVC animated:YES];
            }
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0) {//隐私
                PrivacyTVC *privacyTVC = [sb instantiateViewControllerWithIdentifier:@"PrivacyTVC"];
                [self.navigationController pushViewController:privacyTVC animated:YES];
            }else if (indexPath.row == 1){//通用
                GeneralTVC *generalTVC = [sb instantiateViewControllerWithIdentifier:@"GeneralTVC"];
                [self.navigationController pushViewController:generalTVC animated:YES];
                
                
            }
        }
            break;
            
        case 2:
        {
        }
            break;
            
        case 3:
        {
            AboutQianShouBangTVC *aboutTVC = [sb instantiateViewControllerWithIdentifier:@"AboutQianShouBangTVC"];
            [self.navigationController pushViewController:aboutTVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma 退出登录
- (UIView *)tableFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    footerView.backgroundColor = kBackgroundColor;
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth, 40)];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:kContentColor];
    logoutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    logoutBtn.titleLabel.font = FONT_16;
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logoutBtn];
    return footerView;
}

- (void)logout:(UIButton *)button{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    
    LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
     [BmobUser logout];
}
@end
