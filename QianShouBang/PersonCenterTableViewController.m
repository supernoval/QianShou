//
//  PersonCenterTableViewController.m
//  QianShouBang
//
//  Created by Leo on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PersonCenterTableViewController.h"
#import "InfoCell.h"
#import "SingleRowCell.h"

@interface PersonCenterTableViewController ()

@end

@implementation PersonCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    headView.backgroundColor = [UIColor clearColor];
    if (section == 0 || section == 1 || section == 4) {
        return headView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1 || section == 4) {
        return 15;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *infoCellId = @"InfoCell";
        InfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:infoCellId];
        if (infoCell == nil) {
            infoCell = [[[NSBundle mainBundle]loadNibNamed:@"InfoCell" owner:self options:nil]lastObject];
        }
        infoCell.backgroundColor = kContentColor;
        //头像
        infoCell.image.image = [UIImage imageNamed:@"setting"];
        //姓名
        infoCell.name.text = @"我的姓名";
        //电话
        infoCell.phone.text = @"1522222222";
        //性别
        infoCell.sex_image.image = [UIImage imageNamed:@"male"];
        return infoCell;
        
    }else{
        
        static NSString *singelCellId = @"SingleRowCell";
        
         NSLog(@"1111111");
                
        SingleRowCell *singleCell = [tableView dequeueReusableCellWithIdentifier:singelCellId ];
        if (singleCell == nil) {
            
             NSLog(@"1111112");
            singleCell = [[[NSBundle mainBundle]loadNibNamed:@"SingleRowCell" owner:self options:nil]lastObject];
        }
        
        NSLog(@"1111113");
        
        
        switch (indexPath.section) {
            case 1:
                singleCell.extraText.hidden = YES;
                singleCell.image.image = [UIImage imageNamed:@"money"];
                singleCell.text.text = @"兑换牵手币";
                break;
                
            case 2:
                singleCell.extraText.hidden = NO;
                singleCell.image.image = [UIImage imageNamed:@"purse"];
                singleCell.text.text = @"我的钱包";
                break;
                
            case 3:
                singleCell.extraText.hidden = YES;
                singleCell.image.image = [UIImage imageNamed:@"mall"];
                singleCell.text.text = @"牵手币商城";
                break;
                
            case 4:
                singleCell.extraText.hidden = YES;
                singleCell.image.image = [UIImage imageNamed:@"message_center"];
                singleCell.text.text = @"消息中心";
                break;
                
            case 5:
                singleCell.extraText.hidden = YES;
                singleCell.image.image = [UIImage imageNamed:@"rank"];
                singleCell.text.text = @"排行榜";
                break;
                
            case 6:
                singleCell.extraText.hidden = YES;
                singleCell.image.image = [UIImage imageNamed:@"setting"];
                singleCell.text.text = @"设置";
                break;
                
           
            default:
                break;
        }
        return singleCell;
    }
}










@end
