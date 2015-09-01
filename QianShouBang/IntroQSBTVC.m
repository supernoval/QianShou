//
//  IntroQSBTVC.m
//  QianShouBang
//
//  Created by Leo on 15/8/29.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "IntroQSBTVC.h"
#import "IntroCell.h"

@interface IntroQSBTVC ()

@end

@implementation IntroQSBTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能介绍";
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70+(ScreenWidth-16-50)/2*167/210;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    
        
        static NSString *cellId = @"IntroCell";
        IntroCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"IntroCell" owner:self options:nil][0];
        }
        cell.backgroundColor = kContentColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageWidth_1.constant = (ScreenWidth-16-50)/2;
        cell.imageHeight_1.constant = (ScreenWidth-16-50)/2*167/210;
        cell.imageWidth_2.constant = (ScreenWidth-16-50)/2;
        cell.imageHeight_2.constant = (ScreenWidth-16-50)/2*167/210;
    switch (indexPath.row) {
        case 0:
        {
            cell.introText.text = @"写下您的需求发布出去，就有人抢单帮您完成";
            cell.image_1.image = [UIImage imageNamed:@"about_1"];
            cell.image_2.image = [UIImage imageNamed:@"about_2"];
           
        }
            break;
            
        case 1:
        {
            cell.introText.text = @"点击右上角就可写上您的各种心情，交友宣言，呐喊吧";
            cell.image_1.image = [UIImage imageNamed:@"about_3"];
            cell.image_2.image = [UIImage imageNamed:@"about_4"];
           
        }
            break;
            
        
            
        case 2:
        {
            cell.introText.text = @"点击右上角加号就可输入对方手机号码搜索好友了";
            cell.image_1.image = [UIImage imageNamed:@"about_5"];
            cell.image_2.image = [UIImage imageNamed:@"about_6"];
            
        }
            break;
            
        case 3:
        {
            cell.introText.text = @"写下您擅长的技能，例如特别能喝酒，可以帮忙代酒，发布出去，就会有人预约您了";
            cell.image_1.image = [UIImage imageNamed:@"about_7"];
            cell.image_2.image = [UIImage imageNamed:@"about_8"];
        }
            break;
            
        case 4:
        {
            cell.introText.text = @"点击右上角图标就可以选择距离进行筛选了";
            cell.image_1.image = [UIImage imageNamed:@"about_9"];
            cell.image_2.hidden = YES;
        }
            break;
            
        case 5:
        {
            cell.introText.text = @"点击附近的人就可以搜索到附近的朋友了";
            cell.image_1.image = [UIImage imageNamed:@"about_10"];
            cell.image_2.hidden = YES;
        }
            break;
            
        case 6:
        {
            cell.introText.text = @"点击下方我的就可以发布需求，查看我的订单和已接订单、完成后的订单和抢单人";
            cell.image_1.image = [UIImage imageNamed:@"about_11"];
            cell.image_2.hidden = YES;
        }
            break;
            
            
        case 7:
        {
            cell.introText.text = @"点击下方个人中心就可以查看余额和牵手币、系统消息，还可以提现，进行系统设置和个人信息设置";
            cell.image_1.image = [UIImage imageNamed:@"about_12"];
            cell.image_2.hidden = YES;
        }
            break;
            
            
            
        default:
            break;
    }
    
    
    
        return cell;
    
}


@end
