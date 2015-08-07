//
//  MyPurseTableViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MyPurseTableViewController.h"
#import "RowTextCell.h"

@interface MyPurseTableViewController ()

@end

@implementation MyPurseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人账户";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"RowTextCell";
    RowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RowTextCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    switch (indexPath.row) {
        case 0:
            cell.extraText.hidden = NO;
            cell.text.text = @"钱包余额";
            cell.extraText.text = @"1元";
            break;
            
        case 1:
            cell.extraText.hidden = NO;
            cell.text.text = @"牵手币";
            cell.extraText.text = @"1牵手币";
            break;
            
        case 2:
            cell.extraText.hidden = YES;
            cell.text.text = @"余额转出(提现)";
            break;
            
        default:
            break;
    }
    return cell;
}


@end
