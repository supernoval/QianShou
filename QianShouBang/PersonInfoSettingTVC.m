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
        cell.arrow.hidden = YES;
        cell.extraText.textColor = kBlueColor;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.extraText.hidden = NO;
                cell.arrow.hidden = NO;
                cell.text.text = @"自我描述";
                cell.extraText.text = @"主人很懒，什么都没留下";
            }else if(indexPath.row == 2){
                cell.extraText.hidden = NO;
                cell.arrow.hidden = YES;
                cell.text.text = @"账号";
                cell.extraText.text = @"15222222222";
            }else if(indexPath.row == 3){
                cell.extraText.hidden = NO;
                cell.arrow.hidden = NO;
                cell.text.text = @"昵称";
                cell.extraText.text = @"牛逼邦果";
            }
        }else if(indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.extraText.hidden = NO;
                cell.arrow.hidden = NO;
                cell.text.text = @"手机号";
                cell.extraText.text = @"15222222222";
            }else if(indexPath.row == 1){
                cell.extraText.hidden = YES;
                cell.arrow.hidden = NO;
                cell.text.text = @"生日";
            }else if(indexPath.row == 2){
                cell.extraText.hidden = YES;
                cell.arrow.hidden = NO;
                cell.text.text = @"地区";
                cell.extraText.text = @"15222222222";
            }else if(indexPath.row == 3){
                cell.extraText.hidden = NO;
                cell.arrow.hidden = NO;
                cell.text.text = @"性别";
                cell.extraText.text = @"性别是啥";
            }
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                //头像
            case 0:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //自我描述
            case 1:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //账号
            case 2:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //昵称
            case 3:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
                //手机号
            case 0:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //生日
            case 1:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //地区
            case 2:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //性别
            case 3:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
            default:
                break;
        }
    }
}
@end
