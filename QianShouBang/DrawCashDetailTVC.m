//
//  DrawCashDetailTVC.m
//  QianShouBang
//
//  Created by Leo on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "DrawCashDetailTVC.h"

@interface DrawCashDetailTVC ()
@property (nonatomic, strong)NSString* tCount;
@property (nonatomic,strong)UITextField *textField_0;
@property (nonatomic,strong)UITextField *textField_1;
@property (nonatomic,strong)UITextField *textField_2;
@property (nonatomic,strong)UITextField *textField_3;
@end

@implementation DrawCashDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.tableFooterView = [self tableFooterView];
    [self getMoneyCountData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                CGFloat tvalue = [[obj objectForKey:ktMoneyCount]floatValue];
                self.tCount = [NSString stringWithFormat:@"%.1f",tvalue];
                [self addRightNavItem];
                
            }
        }
    }];
}

- (void)addRightNavItem{
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 18)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 18)];
    title.textColor = [UIColor whiteColor];
    title.font = FONT_13;
    title.textAlignment = NSTextAlignmentRight;
    title.text = [NSString stringWithFormat:@"当前余额%@元",CheckNil(self.tCount)];
     NSLog(@"余额xianshi：%@",self.tCount);
    [view addSubview:title];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"DrawCashCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"DrawCashCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *textLabel = (UILabel *)[cell viewWithTag:100];

    switch (indexPath.row) {
        case 0:
        {
            self.textField_0 = (UITextField *)[cell viewWithTag:101];
            textLabel.text = @"姓名:";
            self.textField_0.placeholder = @"收款支付宝账户姓名";
        
        }
            break;
            
        case 1:
        {
            _textField_1 = (UITextField *)[cell viewWithTag:101];
            textLabel.text = @"账号:";
            _textField_1.placeholder = @"收款支付宝账号";
            
        }
            break;
            
        case 2:
        {
            _textField_2 = (UITextField *)[cell viewWithTag:101];
            textLabel.text = @"确认账号";
            _textField_2.placeholder = @"确认收款支付宝账号";
            
        }
            break;
            
        case 3:
        {
            _textField_3 = (UITextField *)[cell viewWithTag:101];
            textLabel.text = @"提现金额";
            _textField_3.placeholder = @"输入您想要提现的金额";
            
        }
            break;
            
            
        default:
            break;
    }
    return cell;
}

- (UIView *)tableFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    view.backgroundColor = kBackgroundColor;
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    whiteView.backgroundColor = kContentColor;
    [view addSubview:whiteView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor redColor];
    infoLabel.font = FONT_15;
    infoLabel.text = @"已冻结5元，可取290元";
    [whiteView addSubview:infoLabel];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 64, ScreenWidth-16, 30)];
    [confirmBtn setBackgroundColor:kBlueColor];
    [confirmBtn setTitle:@"确认转出" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     confirmBtn.layer.masksToBounds = YES;
     confirmBtn.layer.cornerRadius = 4.0;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:confirmBtn];
     return view;
    
}



- (void)confirmAction{
    if (self.textField_0.text.length == 0) {
        [CommonMethods showAlertString:@"收款支付宝账户姓名不能为空" delegate:self tag:10];
    }else if (self.textField_1.text.length == 0){
        [CommonMethods showAlertString:@"支付宝账号不能为空" delegate:self tag:11];
    }else if (self.textField_2.text.length == 0){
        [CommonMethods showAlertString:@"请再次输入支付宝账号以确认" delegate:self tag:12];
    }else if (![self.textField_1.text isEqualToString:self.textField_2.text]){
        [CommonMethods showAlertString:@"两次输入的收款支付宝账号不一样" delegate:self tag:13];
    }else if (self.textField_3.text.length == 0){
        [CommonMethods showAlertString:@"请输入提现金额" delegate:self tag:14];
    }
}

@end
