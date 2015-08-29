//
//  AboutQianShouBangTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/13.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "AboutQianShouBangTVC.h"
#import "RowTextCell.h"
#import "MessageTableViewController.h"
#import "FeedBackViewController.h"
#import "IntroQSBTVC.h"

@interface AboutQianShouBangTVC ()

@end

@implementation AboutQianShouBangTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于牵手邦";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 版本
    self.appVersionLabel.text = [NSString stringWithFormat:@"牵手邦%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
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
    
    return 4;
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
    if (indexPath.row == 0) {
        
        cell.text.text = @"去评分";
        
    }else if(indexPath.row == 1){
        
        cell.text.text = @"功能介绍";
        
    }else if(indexPath.row == 2){
        
        cell.text.text = @"系统通知";
        
    }else if (indexPath.row == 3){
        
        cell.text.text = @"帮助与反馈";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];

    switch (indexPath.row) {
        case 0://评分
        {
            NSString *urlStr = [NSString stringWithFormat:
                                @"http://itunes.apple.com/app/id646300912"];
            NSURL *url =[NSURL URLWithString:urlStr];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
            
        case 1://功能介绍
        {
            IntroQSBTVC *intro = [sb instantiateViewControllerWithIdentifier:@"IntroQSBTVC"];
            [self.navigationController pushViewController:intro animated:YES];
        }
            break;
            
        case 2://系统通知
        {
            MessageTableViewController *mesageTVC = [sb instantiateViewControllerWithIdentifier:@"MessageTableViewController"];
            [self.navigationController pushViewController:mesageTVC animated:YES];
        }
            break;
            
        case 3://帮助反馈
        {
            FeedBackViewController *feedbackVC = [sb instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
