//
//  PersonInfoSettingTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PersonInfoSettingTVC.h"
#import "RowTextCell.h"
#import "PortraitCell.h"

@interface PersonInfoSettingTVC ()

@end

@implementation PersonInfoSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息设置";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    
    return 4;
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 60;
        }
    }
    return 40;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *portraitCellId = @"PortraitCell";
            PortraitCell *portraitCell = [tableView dequeueReusableCellWithIdentifier:portraitCellId];
            if (portraitCell == nil) {
                portraitCell = [[NSBundle mainBundle]loadNibNamed:@"PortraitCell" owner:self options:nil][0];
            }
            portraitCell.selectionStyle = UITableViewCellSelectionStyleNone;
            portraitCell.backgroundColor = kContentColor;
            //头像
            portraitCell.image.image = [UIImage imageNamed:@"setting"];
            return portraitCell;
            
        }
    }else{
        static NSString *cellId = @"RowTextCell";
        RowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"RowTextCell" owner:self options:nil][0];
        }
        cell.extraText.hidden = YES;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.extraText.hidden = NO;
                cell.extraText.textColor = kBlueColor;
                cell.text.text = @"自我描述";
                cell.extraText.text = @"主人很懒，什么都没留下";
            }else if (indexPath.section == 1) {
                if (indexPath.row == 1) {
                    cell.extraText.hidden = NO;
                    cell.extraText.textColor = kBlueColor;
                    cell.text.text = @"自我描述";
                    cell.extraText.text = @"主人很懒，什么都没留下";
                }
            
            cell.text.text = @"账户管理";
        }else if(indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.text.text = @"隐私";
            }else if(indexPath.row == 1){
                cell.text.text = @"新消息通知";
            }else if(indexPath.row == 2){
                cell.text.text = @"通用";
            }
        }
        
        return cell;
    }
    
    
}*/

@end
