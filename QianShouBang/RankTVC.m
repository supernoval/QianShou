//
//  RankTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RankTVC.h"
#import "RankCell.h"

@interface RankTVC ()

@end

@implementation RankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"财富榜";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"RankCell";
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RankCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    //头像
    cell.image.image = [UIImage imageNamed:@"setting"];
    //姓名
    cell.name.text = @"超人飞";
    
    //简介
    cell.intro_text.text = @"去尼玛的超人不会飞";
    
    //vip
    cell.vip.image = [UIImage imageNamed:@"vip_2"];
    
    cell.money.text = [NSString stringWithFormat:@"¥250.0"];
    return cell;
}


@end
