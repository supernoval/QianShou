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
    return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    
        
        static NSString *cellId = @"IntroCell";
        IntroCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"IntroCell" owner:self options:nil][0];
        }
        cell.backgroundColor = kContentColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        {
            cell.introText.text = @"我去发送你哦啊放假哦啊见";
            cell.image_1.image = [UIImage imageNamed:@"head_default_0"];
            cell.image_2.image = [UIImage imageNamed:@"head_default_0"];
        }
            break;
            
        case 1:
        {
            cell.introText.text = @"我去发送你哦啊放假哦啊见";
            cell.image_1.image = [UIImage imageNamed:@"head_default_0"];
            cell.image_2.image = [UIImage imageNamed:@"head_default_0"];
        }
            break;
            
        case 2:
        {
            cell.introText.text = @"我去发送你哦啊放假哦啊见";
            cell.image_1.image = [UIImage imageNamed:@"head_default_0"];
            cell.image_2.image = [UIImage imageNamed:@"head_default_0"];
        }
            break;
            
        case 3:
        {
            cell.introText.text = @"我去发送你哦啊放假哦啊见";
            cell.image_1.image = [UIImage imageNamed:@"head_default_0"];
            cell.image_2.image = [UIImage imageNamed:@"head_default_0"];
        }
            break;
            
        case 4:
        {
            cell.introText.text = @"我去发送你哦啊放假哦啊见";
            cell.image_1.image = [UIImage imageNamed:@"head_default_0"];
            cell.image_2.image = [UIImage imageNamed:@"head_default_0"];
        }
            break;
            
        case 5:
        {
            cell.introText.text = @"我去发送你哦啊放假哦啊见";
            cell.image_1.image = [UIImage imageNamed:@"head_default_0"];
            cell.image_2.image = [UIImage imageNamed:@"head_default_0"];
        }
            break;
            
        case 6:
        {
            cell.introText.text = @"我去发送你哦啊放假哦啊见";
            cell.image_1.image = [UIImage imageNamed:@"head_default_0"];
            cell.image_2.image = [UIImage imageNamed:@"head_default_0"];
        }
            break;
            
            
        default:
            break;
    }
    
    
    
        return cell;
    
}


@end
