//
//  PrivacyTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PrivacyTVC.h"
#import "RowTextCell.h"

@interface PrivacyTVC ()
@property (strong, nonatomic)UISwitch *addSwitch;

@end

@implementation PrivacyTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.title = @"隐私";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    
        return 1;
    
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
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"RowTextCell";
    RowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RowTextCell" owner:self options:nil][0];
    }
    cell.extraText.hidden = YES;
    
    UITableViewCell *noAddCell = [[NSBundle mainBundle]loadNibNamed:@"NoAddCell" owner:self options:nil][0];
    noAddCell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            cell.text.text = @"通信录黑名单";
            return cell;
        }
        
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            
            ;
            
            _addSwitch = (UISwitch *)[noAddCell viewWithTag:100];
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:kNoAddFriends]integerValue]==1) {
                _addSwitch.on = YES;
            }else{
                _addSwitch.on = NO;
            }
            [_addSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            return noAddCell;
        }
    }
    return nil;
}
- (void)switchAction:(UISwitch *)switchBtn{
    BmobUser *user = [BmobUser getCurrentUser];
    BOOL isButtonOn = _addSwitch.on;
    if (isButtonOn) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kNoAddFriends];
        //禁止添加为好友
        [MyProgressHUD showProgress];
        [user setObject:@YES forKey:kwheather_allow_add];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
            if (isSuccessful) {
                [MyProgressHUD dismiss];
                
                [CommonMethods showAlertString:@"设置成功!" delegate:self tag:11];
            }else if(error){
                [MyProgressHUD dismiss];
                [CommonMethods showAlertString:@"设置失败!" delegate:self tag:12];
            }
        }];
        
        
    }else{
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kNoAddFriends];
        [MyProgressHUD showProgress];
        [user setObject:@NO forKey:kwheather_allow_add];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
            if (isSuccessful) {
                [MyProgressHUD dismiss];
                
                [CommonMethods showAlertString:@"设置成功!" delegate:self tag:11];
            }else if(error){
                [MyProgressHUD dismiss];
                [CommonMethods showAlertString:@"设置失败!" delegate:self tag:12];
            }
        }];
    }
    NSLog(@"&&&&&:%@",[[NSUserDefaults standardUserDefaults]objectForKey:kNoAddFriends]);
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//通信录黑名单
            
        }
    }
}



@end
