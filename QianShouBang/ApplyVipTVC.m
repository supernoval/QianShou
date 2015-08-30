//
//  ApplyVipTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/20.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ApplyVipTVC.h"

@interface ApplyVipTVC ()
@property (nonatomic)CGFloat countMoney;
@property (nonatomic)NSInteger QsMoney;

@end

@implementation ApplyVipTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册VIP会员（金邦果）";
    self.view.backgroundColor = [UIColor whiteColor];
    self.applyBtn.layer.masksToBounds = YES;
    self.applyBtn.layer.cornerRadius = 4;
    self.applyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.applyBtn.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)applyVipAction:(UIButton *)sender {
    //付款成功后执行
    /*
    [MyProgressHUD showProgress];
    BmobUser *user = [BmobUser getCurrentUser];
    //获取账户余额
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            [MyProgressHUD dismiss];
            NSLog(@"%@",error);
        }else{
            NSLog(@"账户%li",(unsigned long)array.count);
            if (array.count != 0) {
                BmobObject *obj = [array firstObject];
                self.countMoney = [[obj objectForKey:ktMoneyCount]floatValue];
                self.QsMoney = [[obj objectForKey:ktIntegralCount]integerValue];
               
                
            }else{
                [MyProgressHUD dismiss];
                self.countMoney =0;
                self.QsMoney = 0;
            }
        }
        //创建支付明细
        BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
        [detailObj setObject:@YES forKey:kisAccountAmountType];
        [detailObj setObject:@YES forKey:@"vip"];
        [detailObj setObject:[NSNumber numberWithInteger:0] forKey:ktIntegral];
        [detailObj setObject:@(399) forKey:ktMoney];
        [detailObj setObject:[NSNumber numberWithInteger:self.QsMoney] forKey:ktIntegralCount];
        [detailObj setObject:[NSNumber numberWithFloat:self.countMoney] forKey:ktMoneyCount];
        [detailObj setObject:user forKey:@"user"];
        [detailObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
            if (isSuccessful) {
                //修改会员等级
                [user setObject:@"2" forKey:kuser_level];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
                    if (isSuccessful) {
                        [MyProgressHUD dismiss];
                        [CommonMethods showAlertString:@"开通会员成功" delegate:self tag:11];
                    }else if(error){
                        [MyProgressHUD dismiss];
                        [CommonMethods showDefaultErrorString:@"开通会员失败"];
                    }
                }];

                
            }else{
                [MyProgressHUD dismiss];
                [CommonMethods showDefaultErrorString:@"开通会员失败"];
                
            }
        }];
        
    }];*/
    
}
@end
