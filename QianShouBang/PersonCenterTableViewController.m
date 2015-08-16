//
//  PersonCenterTableViewController.m
//  QianShouBang
//
//  Created by Leo on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PersonCenterTableViewController.h"
#import "InfoCell.h"
#import "RowCell.h"
#import "MyPurseTableViewController.h"
#import "RankTVC.h"
#import "SettingTVC.h"
#import "PersonInfoSettingTVC.h"
#import "MallTableViewController.h"
#import "MessageTableViewController.h"
#import "QSUser.h"


@interface PersonCenterTableViewController ()
@property (nonatomic, strong)QSUser *userInfo;
@property (nonatomic, strong)BmobUser *currentUser;

@end

@implementation PersonCenterTableViewController
@synthesize userInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    userInfo = [[QSUser alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.currentUser = [BmobUser getCurrentUser];
    [self getCurrentUserInfo];
}
#pragma -mark获取当前用户信息
- (void)getCurrentUserInfo{
    
    userInfo.username = [self.currentUser objectForKey:kusername];
    userInfo.user_sex = [[self.currentUser objectForKey:kuser_sex]integerValue];
    userInfo.nick = [self.currentUser objectForKey:knick];
    userInfo.user_phone = [self.currentUser objectForKey:kuser_phone];
    userInfo.avatar = [self.currentUser objectForKey:kavatar];
    userInfo.user_individuality_signature = [self.currentUser objectForKey:kuser_individuality_signature];

    NSLog(@"8%@ 9%@ 10%@",userInfo.username,userInfo.user_phone,userInfo.nick);
    [self.tableView reloadData];
    
    
}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *infoCellId = @"InfoCell";
    InfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:infoCellId];
    if (infoCell == nil) {
        infoCell = [[NSBundle mainBundle]loadNibNamed:@"InfoCell" owner:self options:nil][0];
    }
    infoCell.backgroundColor = kContentColor;
    infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    static NSString *cellId = @"RowCell";
    
    RowCell *singleCell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (singleCell == nil) {
        
        singleCell = [[NSBundle mainBundle]loadNibNamed:@"RowCell" owner:self options:nil][0];
    }
    
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    infoCell.backgroundColor = kContentColor;
                    infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //头像
                    if (userInfo.avatar.length != 0) {
                        [infoCell.image sd_setImageWithURL:[NSURL URLWithString:userInfo.avatar]];
                    }else{//未设置头像时的处理
                        infoCell.image.image = [UIImage imageNamed:@"head_default"];
                    }
                    //姓名
//                    infoCell.name.text = userInfo.nick;
                    //电话
                    infoCell.phone.text = userInfo.username;
                    //性别
                    if (userInfo.user_sex == 1) {
                        infoCell.name.text = [NSString stringWithFormat:@"%@ (男)",userInfo.nick];
                    }else{
                        infoCell.name.text = [NSString stringWithFormat:@"%@ (女)",userInfo.nick];
                    }
                    
                    return infoCell;
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0://兑换牵手币
                {
                    singleCell.extraText.hidden = YES;
                    singleCell.image.image = [UIImage imageNamed:@"money"];
                    singleCell.text.text = @"兑换牵手币";
                    return singleCell;
                    
                }
                    break;
                    
                case 1://我的钱包
                {
                    singleCell.extraText.hidden = NO;
                    singleCell.image.image = [UIImage imageNamed:@"purse"];
                    singleCell.text.text = @"我的钱包";
                    return singleCell;
                    
                }
                    break;
                    
                case 2://牵手币商城
                {
                    singleCell.extraText.hidden = YES;
                    singleCell.image.image = [UIImage imageNamed:@"mall"];
                    singleCell.text.text = @"牵手币商城";
                    return singleCell;
                    
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0://消息中心
                {
                    singleCell.extraText.hidden = YES;
                    singleCell.image.image = [UIImage imageNamed:@"message_center"];
                    singleCell.text.text = @"消息中心";
                    return singleCell;
                    
                }
                    break;
                    
                case 1://排行榜
                {
                    singleCell.extraText.hidden = YES;
                    singleCell.image.image = [UIImage imageNamed:@"rank"];
                    singleCell.text.text = @"排行榜";
                    return singleCell;
                    
                }
                    break;
                    
                case 2://设置
                {
                    singleCell.extraText.hidden = YES;
                    singleCell.image.image = [UIImage imageNamed:@"setting"];
                    singleCell.text.text = @"设置";
                    return singleCell;
                    
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }
    return nil;
 
    
 
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    PersonInfoSettingTVC *personSettingTVC = [sb instantiateViewControllerWithIdentifier:@"PersonInfoSettingTVC"];

                    [self.navigationController pushViewController:personSettingTVC animated:YES];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0://兑换牵手币
                {
                    
                }
                    break;
                    
                case 1://我的钱包
                {
                    MyPurseTableViewController *purseTVC = [sb instantiateViewControllerWithIdentifier:@"MyPurseTableViewController"];
                    [self.navigationController pushViewController:purseTVC animated:YES];
                    
                }
                    break;
                    
                case 2://牵手币商城
                {
                    MallTableViewController *mallTVC = [sb instantiateViewControllerWithIdentifier:@"MallTableViewController"];
                    [self.navigationController pushViewController:mallTVC animated:YES];
                    
                    
                }
                    break;

                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0://消息中心
                {
                    MessageTableViewController *messageTVC = [sb instantiateViewControllerWithIdentifier:@"MessageTableViewController"];
                    [self.navigationController pushViewController:messageTVC animated:YES];
                    
                }
                    break;
                    
                case 1://排行榜
                {
                    RankTVC *rankTVC = [sb instantiateViewControllerWithIdentifier:@"RankTVC"];
                    [self.navigationController pushViewController:rankTVC animated:YES];
                    
                }
                    break;
                    
                case 2://设置
                {
                    SettingTVC *SettingTVC = [sb instantiateViewControllerWithIdentifier:@"SettingTVC"];
                    [self.navigationController pushViewController:SettingTVC animated:YES];
                    
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}







@end
