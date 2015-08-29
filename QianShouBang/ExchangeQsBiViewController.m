//
//  ExchangeQsBiViewController.m
//  QianShouBang
//
//  Created by Leo on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ExchangeQsBiViewController.h"

@interface ExchangeQsBiViewController ()
@property (nonatomic)CGFloat tCount;
@property (nonatomic)NSInteger integralCount;

@end

@implementation ExchangeQsBiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setAppearance];
    [self getMoneyCountData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 判断是不是每月的第一次提现

- (BOOL)isFirstByMonth{
    __block BOOL isYes = NO;

    
    NSString  *timeString = [Bmob getServerTimestamp];
    //时间戳转化成时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString intValue]];
    
    NSString *dateStr = [CommonMethods getYYYYMMddFromDefaultDateStr:date];
    
    NSDate * serviceDate = [CommonMethods  getYYYMMddFromString:dateStr];

    
    
    __block BmobObject *obj;
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    query.limit = 1;
    [query orderByDescending:@"updatedAt"];
    [query whereKey:kIntergral_exchange equalTo:@YES];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {

        if (error) {
            NSLog(@"%@",error);
        }else{
            if (array.count == 0) {
                isYes = YES;
            }else{
                obj = [array firstObject];
                
                NSString *creatTime = [CommonMethods getYYYYMMddFromDefaultDateStr:obj.createdAt];
                
                NSDate *createDate = [CommonMethods getYYYMMddFromString:creatTime];

                if ([serviceDate isEqualToDate:createDate]) {
                    isYes = NO;
                }else{
                    isYes = YES;
                }
                
            }
        }
        
        
    }];

  
    return isYes;

}




- (void)setAppearance{

    
    self.button_1.layer.masksToBounds = YES;
    self.button_1.layer.cornerRadius = 4.0;
    
    self.button_2.layer.masksToBounds = YES;
    self.button_2.layer.cornerRadius = 4.0;
    
    self.button_3.layer.masksToBounds = YES;
    self.button_3.layer.cornerRadius = 4.0;
    
    self.button_4.layer.masksToBounds = YES;
    self.button_4.layer.cornerRadius = 4.0;
}

- (void)getMoneyCountData{
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"账户%li",(unsigned long)array.count);
            if (array.count != 0) {
                BmobObject *obj = [array firstObject];
                self.integralCount = [[obj objectForKey:ktIntegralCount]integerValue];
                self.tCount = [[obj objectForKey:ktMoneyCount]floatValue];
                self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                
            }else{
                self.integralCount = 0;
                self.tCount = 0;
                self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                
            }
        }
    }];
}

- (IBAction)button_1Action:(UIButton *)sender {
    
    
    BmobUser *user = [BmobUser getCurrentUser];
    BmobQuery *query = [BmobQuery queryWithClassName:kExchangeMoneyBean];
    query.limit = 1;
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            BmobObject *firstObj = [array firstObject];
            if (firstObj == nil) {//可以兑换
                if (self.tCount < 10.0) {
                    [CommonMethods showAlertString:@"首次兑换账户余额不能低于10元" delegate:self tag:11];
                }else{
                    [self showAlertWithMessage:@"余额兑换牵手币后，相应地余额将在一月后才能体现，是否愿意继续兑换？" tag:100];
                }
            }else{
                [CommonMethods showAlertString:@"您已不是首次兑换" delegate:self tag:10];
            }
            
        }
        
        
    }];
  
}
- (IBAction)button_2Action:(UIButton *)sender {
    if ([self isFirstByMonth]) {
        
        BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
        [query orderByDescending:@"updatedAt"];
        [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
            if (error) {
                NSLog(@"%@",error);
            }else{
                NSLog(@"账户%li",(unsigned long)array.count);
                if (array.count != 0) {
                    BmobObject *obj = [array firstObject];
                    self.integralCount = [[obj objectForKey:ktIntegralCount]floatValue];
                    NSLog(@"获取牵手币：%ld",(long)self.integralCount);
                    self.tCount = [[obj objectForKey:ktMoneyCount]floatValue];
                    self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                    
                }else{
                    self.integralCount = 0;
                    self.tCount = 0;
                    self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                    
                }
                
                
                if (self.tCount < 500.0) {
                    [CommonMethods showAlertString:@"账户余额不足" delegate:self tag:15];
                }else{
                    [self showAlertWithMessage:@"余额兑换牵手币后，相应地余额将在一月后才能体现，是否愿意继续兑换？" tag:101];
                }
                
                
            }
        }];

        
    }else{
        [CommonMethods showDefaultErrorString:@"每月只能提现一次"];
    }
    
 
   
}
- (IBAction)button_3Action:(UIButton *)sender {
    
    if ([self isFirstByMonth]) {
        BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
        [query orderByDescending:@"updatedAt"];
        [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
            if (error) {
                NSLog(@"%@",error);
            }else{
                NSLog(@"账户%li",(unsigned long)array.count);
                if (array.count != 0) {
                    BmobObject *obj = [array firstObject];
                    self.integralCount = [[obj objectForKey:ktIntegralCount]floatValue];
                    NSLog(@"获取牵手币：%ld",(long)self.integralCount);
                    self.tCount = [[obj objectForKey:ktMoneyCount]floatValue];
                    self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                    
                }else{
                    self.integralCount = 0;
                    self.tCount = 0;
                    self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                    
                }
                
                
                if (self.tCount < 2000.0) {
                    [CommonMethods showAlertString:@"账户余额不足" delegate:self tag:16];
                }else{
                    [self showAlertWithMessage:@"余额兑换牵手币后，相应地余额将在一月后才能体现，是否愿意继续兑换？" tag:102];
                }
                
                
            }
        }];

        
    }else{
         [CommonMethods showDefaultErrorString:@"每月只能提现一次"];
    }
    
    
    
    
    
}

- (IBAction)button_4Action:(UIButton *)sender {
    
    if ([self isFirstByMonth]) {
        
        BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
        [query orderByDescending:@"updatedAt"];
        [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
            if (error) {
                NSLog(@"%@",error);
            }else{
                NSLog(@"账户%li",(unsigned long)array.count);
                if (array.count != 0) {
                    BmobObject *obj = [array firstObject];
                    self.integralCount = [[obj objectForKey:ktIntegralCount]floatValue];
                    NSLog(@"获取牵手币：%li",(long)self.integralCount);
                    self.tCount = [[obj objectForKey:ktMoneyCount]floatValue];
                    self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                    
                }else{
                    self.integralCount = 0;
                    self.tCount = 0;
                    self.title = [NSString stringWithFormat:@"当前余额%.1f",self.tCount];
                    
                }
                
                
                if (self.tCount < 5000.0) {
                    [CommonMethods showAlertString:@"账户余额不足" delegate:self tag:17];
                }else{
                    [self showAlertWithMessage:@"余额兑换牵手币后，相应地余额将在一月后才能体现，是否愿意继续兑换？" tag:103];
                }
                
            }
        }];
        
        
    }else{
        [CommonMethods showDefaultErrorString:@"每月只能提现一次"];
    }
    
    
}

- (void)showAlertWithMessage:(NSString *)message tag:(NSInteger)tag{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {//确定（首次兑换）
            [MyProgressHUD showProgress];
            NSInteger qsBi;
            NSInteger exchangeMoney;
            if (self.tCount > 5000) {
                qsBi = 500;
                exchangeMoney = 5000;
            }else{
                qsBi = self.tCount/10;
                exchangeMoney = self.tCount/10;
            }
            
            
            BmobUser *user = [BmobUser getCurrentUser];
            BmobObject *exchangeObj = [BmobObject objectWithClassName:kExchangeMoneyBean];
            [exchangeObj setObject:[NSNumber numberWithInteger:qsBi] forKey:kexchange_integrl_num];
            [exchangeObj setObject:[NSNumber numberWithInteger:qsBi] forKey:kuse_money_value];
            [exchangeObj setObject:user forKey:@"user"];
            [exchangeObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                if (isSuccessful) {
                    BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                    [detailObj setObject:@YES forKey:kisQsMoneyType];
                    [detailObj setObject:@YES forKey:kIntergral_exchange];
                    [detailObj setObject:[NSNumber numberWithInteger:qsBi] forKey:ktIntegral];
                    [detailObj setObject:[NSNumber numberWithInteger:exchangeMoney] forKey:ktMoney];
                    [detailObj setObject:[NSNumber numberWithInteger:(self.integralCount+qsBi)] forKey:ktIntegralCount];
                    [detailObj setObject:[NSNumber numberWithFloat:self.tCount] forKey:ktMoneyCount];
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
    }else if (alertView.tag == 101) {
        if (buttonIndex == 1) {//确定（500元兑换）
            [MyProgressHUD showProgress];
            BmobUser *user = [BmobUser getCurrentUser];
            BmobObject *exchangeObj = [BmobObject objectWithClassName:kExchangeMoneyBean];
            NSInteger qsBi = 35;
            NSInteger exchangeMoney = 500;
            [exchangeObj setObject:[NSNumber numberWithInteger:qsBi] forKey:kexchange_integrl_num];
            [exchangeObj setObject:[NSNumber numberWithInteger:exchangeMoney] forKey:kuse_money_value];
            [exchangeObj setObject:user forKey:@"user"];
            [exchangeObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                if (isSuccessful) {
                    BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                    [detailObj setObject:@YES forKey:kisQsMoneyType];
                    [detailObj setObject:@YES forKey:kIntergral_exchange];
                    [detailObj setObject:[NSNumber numberWithInteger:qsBi] forKey:ktIntegral];
                    [detailObj setObject:[NSNumber numberWithInteger:exchangeMoney] forKey:ktMoney];
                    [detailObj setObject:[NSNumber numberWithInteger:(self.integralCount+qsBi)] forKey:ktIntegralCount];
                    [detailObj setObject:[NSNumber numberWithFloat:self.tCount] forKey:ktMoneyCount];
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
    }else if (alertView.tag == 102) {
        if (buttonIndex == 1) {//确定（2000元兑换）
            [MyProgressHUD showProgress];
            BmobUser *user = [BmobUser getCurrentUser];
            BmobObject *exchangeObj = [BmobObject objectWithClassName:kExchangeMoneyBean];
            NSInteger qsBi = 150;
            NSInteger exchangeMoney = 2000;
            [exchangeObj setObject:[NSNumber numberWithInteger:qsBi] forKey:kexchange_integrl_num];
            [exchangeObj setObject:[NSNumber numberWithInteger:exchangeMoney] forKey:kuse_money_value];
            [exchangeObj setObject:user forKey:@"user"];
            [exchangeObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                if (isSuccessful) {
                    BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                    [detailObj setObject:@YES forKey:kisQsMoneyType];
                    [detailObj setObject:@YES forKey:kIntergral_exchange];
                    [detailObj setObject:[NSNumber numberWithInteger:qsBi] forKey:ktIntegral];
                    [detailObj setObject:[NSNumber numberWithInteger:exchangeMoney] forKey:ktMoney];
                    [detailObj setObject:[NSNumber numberWithInteger:(self.integralCount+qsBi)] forKey:ktIntegralCount];
                    [detailObj setObject:[NSNumber numberWithFloat:self.tCount] forKey:ktMoneyCount];
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
    }else if (alertView.tag == 103) {
        if (buttonIndex == 1) {//确定（5000元兑换）
            [MyProgressHUD showProgress];
            BmobUser *user = [BmobUser getCurrentUser];
            BmobObject *exchangeObj = [BmobObject objectWithClassName:kExchangeMoneyBean];
            NSInteger qsBi = 350;
            NSInteger exchangeMoney = 5000;
            [exchangeObj setObject:[NSNumber numberWithInteger:qsBi] forKey:kexchange_integrl_num];
            [exchangeObj setObject:[NSNumber numberWithInteger:exchangeMoney] forKey:kuse_money_value];
            [exchangeObj setObject:user forKey:@"user"];
            [exchangeObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                if (isSuccessful) {
                    BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
                    [detailObj setObject:@YES forKey:kisQsMoneyType];
                    [detailObj setObject:@YES forKey:kIntergral_exchange];
                    [detailObj setObject:[NSNumber numberWithInteger:qsBi] forKey:ktIntegral];
                    [detailObj setObject:[NSNumber numberWithInteger:exchangeMoney] forKey:ktMoney];
                    [detailObj setObject:[NSNumber numberWithInteger:(self.integralCount+qsBi)] forKey:ktIntegralCount];
                    [detailObj setObject:user forKey:@"user"];
                    NSLog(@"当前牵手币：%ld 交易后：%ld",(long)self.integralCount, self.integralCount+qsBi);
                    [detailObj setObject:[NSNumber numberWithFloat:self.tCount] forKey:ktMoneyCount];
                    
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
@end
