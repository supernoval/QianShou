//
//  NearPeopleTVC.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "NearPeopleTVC.h"
#import "NearPeopleCell.h"

@interface NearPeopleTVC ()

@end

@implementation NearPeopleTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"附近人";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
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
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"NearPeopleCell";
    NearPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"NearPeopleCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    
//    CGRect titleF = cell.nameBtn.titleLabel.frame;
//    CGRect imageF = cell.nameBtn.imageView.frame;
//    
//    titleF.origin.x = imageF.origin.x;
//    cell.nameBtn.titleLabel.frame = titleF;
//    imageF.origin.x = CGRectGetMaxX(titleF);
//    cell.nameBtn.imageView.frame = imageF;
    
    cell.image.image = [UIImage imageNamed:@"setting"];
    [cell.nameBtn setTitle:@"超人不会飞" forState:UIControlStateNormal];
    [cell.nameBtn setImage:[UIImage imageNamed:@"male"] forState:UIControlStateNormal];
    cell.distance.text = @"距离800Km";
    cell.portrait.text = @"谁说超人不会飞，我就飞你麻痹";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //section
    
}

@end
