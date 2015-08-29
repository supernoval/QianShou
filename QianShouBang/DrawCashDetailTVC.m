//
//  DrawCashDetailTVC.m
//  QianShouBang
//
//  Created by Leo on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "DrawCashDetailTVC.h"

@interface DrawCashDetailTVC ()
@property (nonatomic,strong)UITextField *textField_0;
@property (nonatomic,strong)UITextField *textField_1;
@property (nonatomic,strong)UITextField *textField_2;
@property (nonatomic,strong)UITextField *textField_3;

@property (nonatomic)CGFloat countMoney;//账户余额
@property (nonatomic)NSInteger QsMoney;
@property (nonatomic)CGFloat frozenMoney;//冻结金钱
@property (nonatomic)CGFloat adviseMoney;//可取金额
@end

@implementation DrawCashDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self getMoneyCountData];
    [self getFrozenMoneyFromExchangeBean];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 获取账户余额

- (void)getMoneyCountData{
    [MyProgressHUD showProgress];
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            [MyProgressHUD dismiss];
            NSLog(@"%@",error);
        }else{
            NSLog(@"账户%li",(unsigned long)array.count);
            if (array.count != 0) {
                [MyProgressHUD dismiss];
                BmobObject *obj = [array firstObject];
                self.countMoney = [[obj objectForKey:ktMoneyCount]floatValue];
                self.QsMoney = [[obj objectForKey:ktIntegralCount]integerValue];
                [self addRightNavItem];
                
            }
        }
        self.tableView.tableFooterView = [self tableFooterView];
    }];
}

#pragma mark- 获取冻结资金

- (void)getFrozenMoneyFromExchangeBean{
    [MyProgressHUD showProgress];
    NSString  *timeString = [Bmob getServerTimestamp];
    //时间戳转化成时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString intValue]];
    
    NSString *dateStr = [CommonMethods getYYYYMMddFromDefaultDateStr:date];
    
    NSDate * serviceDate = [CommonMethods  getYYYYMMFromString:dateStr];
    
    
    BmobQuery *query = [BmobQuery queryWithClassName:kExchangeMoneyBean];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            [MyProgressHUD dismiss];
            NSLog(@"%@",error);
        }else{
            NSLog(@"账户%li",(unsigned long)array.count);
            if (array.count != 0) {
                BmobObject *obj = [array firstObject];
                NSString *creatTime = [CommonMethods getYYYYMMddFromDefaultDateStr:obj.createdAt];
                
                NSDate *createDate = [CommonMethods getYYYYMMFromString:creatTime];
                
                if ([serviceDate isEqualToDate:createDate]) {//相等是冻结资金
                    [MyProgressHUD dismiss];
                    self.frozenMoney = [[obj objectForKey:kuse_money_value]floatValue];
                }else{
                    [MyProgressHUD dismiss];
                    self.frozenMoney = 0;
                }

                
                
            }else{
                [MyProgressHUD dismiss];
                self.frozenMoney = 0;
            }
        }
        self.tableView.tableFooterView = [self tableFooterView];
    }];
}



- (void)addRightNavItem{
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 18)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 18)];
    title.textColor = [UIColor whiteColor];
    title.font = FONT_13;
    title.textAlignment = NSTextAlignmentRight;
    title.text = [NSString stringWithFormat:@"当前余额%.1f元",self.countMoney];
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
    infoLabel.text = [NSString stringWithFormat:@"已冻结%.1f元，可取%.1f元",self.frozenMoney,(self.countMoney-self.frozenMoney)];
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


- (CGFloat)getOneDayAllCashMoney{
    __block CGFloat allMoney = 0;
    
    NSString  *timeString = [Bmob getServerTimestamp];
    //时间戳转化成时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString intValue]];
    
    NSString *dateStr = [CommonMethods getYYYYMMddFromDefaultDateStr:date];
    NSString *fromTime = [dateStr stringByAppendingString:@" 00:00:00"];
    NSString *toTime = [dateStr stringByAppendingString:@" 24:00:00"];
    
    
    NSDictionary *condiction1 = @{@"createdAt":@{@"$gte":@{@"__type": @"Date", @"iso": fromTime}}};
    NSDictionary *condiction2 = @{@"createdAt":@{@"$lt":@{@"__type": @"Date", @"iso": toTime}}};
    NSArray *condictonArray = @[condiction1,condiction2];
   
    
    BmobQuery *query = [BmobQuery queryWithClassName:kCash];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    query.limit = MAXFLOAT;
    [query addTheConstraintByAndOperationWithArray:condictonArray];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            [MyProgressHUD dismiss];
            NSLog(@"%@",error);
        }else{
            if (array.count == 0) {
                allMoney = 0;
            }else{
                for (NSInteger i = 0; i< array.count; i++) {
                    BmobObject *oneObj = [array objectAtIndex:i];
                    allMoney = allMoney + [[oneObj objectForKey:kcash_number]floatValue];
                }
            }
        }
    }];
    return allMoney;
}

- (void)confirmAction{
    BmobUser *user = [BmobUser getCurrentUser];
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
    }else if ([self.textField_3.text floatValue]>(self.countMoney - self.frozenMoney)){
        [CommonMethods showDefaultErrorString:@"要提现的金额大于可提取金额"];
        
    }else{
        [MyProgressHUD showProgress];
        if ([[user objectForKey:kuser_level]integerValue] == 2) {//会员
            if ([self.textField_3.text floatValue]>5000) {
                [MyProgressHUD dismiss];
                [CommonMethods showDefaultErrorString:@"提现金额不能大于5000元"];
            }else{//每天提现总额不能大于5000
                
                
                __block CGFloat allMoney = 0;
                
                NSString  *timeString = [Bmob getServerTimestamp];
                //时间戳转化成时间
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString intValue]];
                
                NSString *dateStr = [CommonMethods getYYYYMMddFromDefaultDateStr:date];
                NSString *fromTime = [dateStr stringByAppendingString:@" 00:00:00"];
                NSString *toTime = [dateStr stringByAppendingString:@" 24:00:00"];
                
                
                NSDictionary *condiction1 = @{@"createdAt":@{@"$gte":@{@"__type": @"Date", @"iso": fromTime}}};
                NSDictionary *condiction2 = @{@"createdAt":@{@"$lt":@{@"__type": @"Date", @"iso": toTime}}};
                NSArray *condictonArray = @[condiction1,condiction2];
                
                
                BmobQuery *query = [BmobQuery queryWithClassName:kCash];
                [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
                query.limit = MAXFLOAT;
                [query addTheConstraintByAndOperationWithArray:condictonArray];
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
                    if (error) {
                        [MyProgressHUD dismiss];
                        [CommonMethods showDefaultErrorString:@"提现失败"];
                        NSLog(@"%@",error);
                    }else{
                        if (array.count == 0) {//提现
                            
                            CGFloat cash_number = [self.textField_3.text floatValue];
                            
                            BmobObject *cashObj = [BmobObject objectWithClassName:kCash];
                            [cashObj setObject:self.textField_1.text forKey:kcash_account];
                            [cashObj setObject:@(cash_number) forKey:kcash_number];
                            [cashObj setObject:@YES forKey:kis_need_cash];
                            [cashObj setObject:self.textField_0.text forKey:kname];
                            [cashObj setObject:user forKey:@"user"];
                            [cashObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful,NSError *error){
                                
                                
                                if (isSuccessful) {
                                    BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                                    [detailObj setObject:@YES forKey:kisAccountAmountType];
                                    [detailObj setObject:@YES forKey:@"cash"];
                                    [detailObj setObject:[NSNumber numberWithInteger:0] forKey:ktIntegral];
                                    [detailObj setObject:[NSNumber numberWithInteger:cash_number] forKey:ktMoney];
                                    [detailObj setObject:[NSNumber numberWithInteger:self.QsMoney] forKey:ktIntegralCount];
                                    [detailObj setObject:[NSNumber numberWithFloat:self.countMoney - cash_number] forKey:ktMoneyCount];
                                    [detailObj setObject:user forKey:@"user"];
                                    [detailObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                                        if (isSuccessful) {
                                            [MyProgressHUD dismiss];
                                            [CommonMethods showDefaultErrorString:@"兑换成功"];
                                        }else{
                                            [MyProgressHUD dismiss];
                                            [CommonMethods showDefaultErrorString:@"兑换失败"];
                                            
                                        }
                                    }];
                                }else{
                                    [MyProgressHUD dismiss];
                                    [CommonMethods showDefaultErrorString:@"兑换失败"];
                                    
                                }

                            }];
                            
                            
                        }else{
                            for (NSInteger i = 0; i< array.count; i++) {
                                BmobObject *oneObj = [array objectAtIndex:i];
                                allMoney = allMoney + [[oneObj objectForKey:kcash_number]floatValue];
                            }
                            if (allMoney>5000) {
                                [MyProgressHUD dismiss];
                                [CommonMethods showDefaultErrorString:@"每天提现总金额不能大于5000"];
                            }else{//提现
                                
                                CGFloat cash_number = [self.textField_3.text floatValue];
                                
                                BmobObject *cashObj = [BmobObject objectWithClassName:kCash];
                                [cashObj setObject:self.textField_1.text forKey:kcash_account];
                                [cashObj setObject:@(cash_number) forKey:kcash_number];
                                [cashObj setObject:@YES forKey:kis_need_cash];
                                [cashObj setObject:self.textField_0.text forKey:kname];
                                [cashObj setObject:user forKey:@"user"];
                                [cashObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful,NSError *error){
                                    
                                    
                                    if (isSuccessful) {
                                        BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                                        [detailObj setObject:@YES forKey:kisAccountAmountType];
                                        [detailObj setObject:@YES forKey:@"cash"];
                                        [detailObj setObject:[NSNumber numberWithInteger:0] forKey:ktIntegral];
                                        [detailObj setObject:[NSNumber numberWithInteger:cash_number] forKey:ktMoney];
                                        [detailObj setObject:[NSNumber numberWithInteger:self.QsMoney] forKey:ktIntegralCount];
                                        [detailObj setObject:[NSNumber numberWithFloat:self.countMoney - cash_number] forKey:ktMoneyCount];
                                        [detailObj setObject:user forKey:@"user"];
                                        [detailObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                                            if (isSuccessful) {
                                                [MyProgressHUD dismiss];
                                                [CommonMethods showDefaultErrorString:@"兑换成功"];
                                            }else{
                                                [MyProgressHUD dismiss];
                                                [CommonMethods showDefaultErrorString:@"兑换失败"];
                                                
                                            }
                                        }];
                                    }else{
                                        [MyProgressHUD dismiss];
                                        [CommonMethods showDefaultErrorString:@"兑换失败"];
                                        
                                    }
                                    
                                }];
                            }
                        }
                    }
                }];

                
            }
            
        }else{//非会员
            if ([self.textField_3.text floatValue]>100) {
                [MyProgressHUD dismiss];
                [CommonMethods showDefaultErrorString:@"非会员每次提现金额不能大于100"];
            }else{//计算每天提现次数是否大于5
                
                BmobQuery *query = [BmobQuery queryWithClassName:kCash];
                [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
                query.limit = 5;
                [query orderByDescending:@"createdAt"];
                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
                    if (error) {
                        [MyProgressHUD dismiss];
                        [CommonMethods showDefaultErrorString:@"提现失败"];
                    }else{
                        if (array.count < 5) {//提现
                            
                            CGFloat cash_number = [self.textField_3.text floatValue];
                            
                            BmobObject *cashObj = [BmobObject objectWithClassName:kCash];
                            [cashObj setObject:self.textField_1.text forKey:kcash_account];
                            [cashObj setObject:@(cash_number) forKey:kcash_number];
                            [cashObj setObject:@YES forKey:kis_need_cash];
                            [cashObj setObject:self.textField_0.text forKey:kname];
                            [cashObj setObject:user forKey:@"user"];
                            [cashObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful,NSError *error){
                                
                                
                                if (isSuccessful) {
                                    BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                                    [detailObj setObject:@YES forKey:kisAccountAmountType];
                                    [detailObj setObject:@YES forKey:@"cash"];
                                    [detailObj setObject:[NSNumber numberWithInteger:0] forKey:ktIntegral];
                                    [detailObj setObject:[NSNumber numberWithInteger:cash_number] forKey:ktMoney];
                                    [detailObj setObject:[NSNumber numberWithInteger:self.QsMoney] forKey:ktIntegralCount];
                                    [detailObj setObject:[NSNumber numberWithFloat:self.countMoney - cash_number] forKey:ktMoneyCount];
                                    [detailObj setObject:user forKey:@"user"];
                                    [detailObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                                        if (isSuccessful) {
                                            [MyProgressHUD dismiss];
                                            [CommonMethods showDefaultErrorString:@"兑换成功"];
                                        }else{
                                            [MyProgressHUD dismiss];
                                            [CommonMethods showDefaultErrorString:@"兑换失败"];
                                            
                                        }
                                    }];
                                }else{
                                    [MyProgressHUD dismiss];
                                    [CommonMethods showDefaultErrorString:@"兑换失败"];
                                    
                                }
                                
                            }];
                            
                        }else{//判断是不是同一天
                            NSInteger oneDayNum = 0;
                            
                            NSString  *timeString = [Bmob getServerTimestamp];
                            //时间戳转化成时间
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString intValue]];
                            
                            NSString *dateStr = [CommonMethods getYYYYMMddFromDefaultDateStr:date];
                            
                            NSDate * serviceDate = [CommonMethods  getYYYMMddFromString:dateStr];
                            
                            
                            BmobObject *oneObj;
                            for (NSInteger i = 0; i<array.count; i++) {
                                oneObj = [array objectAtIndex:i];
                                NSString *creatTime = [CommonMethods getYYYYMMddFromDefaultDateStr:oneObj.createdAt];
                                
                                NSDate *createDate = [CommonMethods getYYYYMMFromString:creatTime];
                                if (![createDate isEqualToDate:serviceDate]) {
                                    oneDayNum ++;
                                }

                                
                            }
                            
                            if (oneDayNum > 0) {//提现
                                
                                CGFloat cash_number = [self.textField_3.text floatValue];
                                
                                BmobObject *cashObj = [BmobObject objectWithClassName:kCash];
                                [cashObj setObject:self.textField_1.text forKey:kcash_account];
                                [cashObj setObject:@(cash_number) forKey:kcash_number];
                                [cashObj setObject:@YES forKey:kis_need_cash];
                                [cashObj setObject:self.textField_0.text forKey:kname];
                                [cashObj setObject:user forKey:@"user"];
                                [cashObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful,NSError *error){
                                    
                                    
                                    if (isSuccessful) {
                                        BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                                        [detailObj setObject:@YES forKey:kisAccountAmountType];
                                        [detailObj setObject:@YES forKey:@"cash"];
                                        [detailObj setObject:[NSNumber numberWithInteger:0] forKey:ktIntegral];
                                        [detailObj setObject:[NSNumber numberWithInteger:cash_number] forKey:ktMoney];
                                        [detailObj setObject:[NSNumber numberWithInteger:self.QsMoney] forKey:ktIntegralCount];
                                        [detailObj setObject:[NSNumber numberWithFloat:self.countMoney - cash_number] forKey:ktMoneyCount];
                                        [detailObj setObject:user forKey:@"user"];
                                        [detailObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                                            if (isSuccessful) {
                                                [MyProgressHUD dismiss];
                                                [CommonMethods showDefaultErrorString:@"兑换成功"];
                                            }else{
                                                [MyProgressHUD dismiss];
                                                [CommonMethods showDefaultErrorString:@"兑换失败"];
                                                
                                            }
                                        }];
                                    }else{
                                        [MyProgressHUD dismiss];
                                        [CommonMethods showDefaultErrorString:@"兑换失败"];
                                        
                                    }
                                    
                                }];
                                
                            }else{
                                [MyProgressHUD dismiss];
                                [CommonMethods showDefaultErrorString:@"非会员每天最多提现5次"];
                            }
                            
                        }
                        
                    }
                }];
                
            }
        }
    }
}

@end
