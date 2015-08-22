//
//  MyPurseTableViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MyPurseTableViewController.h"
#import "RowTextCell.h"
#import "WithDrawCashViewController.h"
#import "AccountDetailViewController.h"

@interface MyPurseTableViewController ()
@property (nonatomic, strong)NSString *tCount;
@property (nonatomic, strong)NSString *tQsCount;

@end

@implementation MyPurseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人账户";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self getMoneyCountData];
    [self getQsCountData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)getMoneyCountData{
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query whereKey:kisAccountAmountType equalTo:@YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"账户%li",(unsigned long)array.count);
            if (array.count != 0) {
                BmobObject *obj = [array firstObject];
                CGFloat t = [[obj objectForKey:ktMoneyCount]floatValue];
                NSLog(@"余额：%f",t );
                self.tCount = [NSString stringWithFormat:@"%.1f",t];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)getQsCountData{
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query whereKey:kisQsMoneyType equalTo:@YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"牵手%li",(unsigned long)array.count);
            if (array.count != 0) {
                BmobObject *obj = [array firstObject];
                CGFloat t = [[obj objectForKey:ktIntegralCount]floatValue];
                self.tQsCount = [NSString stringWithFormat:@"%.1f",t];
                [self.tableView reloadData];
                
            }
        }
    }];
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
            if (self.tCount == nil) {
                cell.extraText.text = @"";
            }else{
            cell.extraText.text = [NSString stringWithFormat:@"%@元",self.tCount];
            }
            break;
            
        case 1:
            cell.extraText.hidden = NO;
            cell.text.text = @"牵手币";
            if (self.tQsCount == nil) {
                cell.extraText.text = @"";
            }else{
            cell.extraText.text = [NSString stringWithFormat:@"%@牵手币",self.tQsCount];
            }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    switch (indexPath.row) {
        case 0://钱包余额
        {
            AccountDetailViewController *accountVC = [sb instantiateViewControllerWithIdentifier:@"AccountDetailViewController"];
            accountVC.from = 1;
            [self.navigationController pushViewController:accountVC animated:YES];
        }
            break;
            
        case 1://牵手币
        {
            AccountDetailViewController *accountVC = [sb instantiateViewControllerWithIdentifier:@"AccountDetailViewController"];
            accountVC.from = 2;
            [self.navigationController pushViewController:accountVC animated:YES];
        }
            break;
            
        case 2://余额转出（提现）
        {
            WithDrawCashViewController *cashVC = [sb instantiateViewControllerWithIdentifier:@"WithDrawCashViewController"];
            [self.navigationController pushViewController:cashVC animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}
@end
