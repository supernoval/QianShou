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
    [self getAccountDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- 获取账户余额
- (void)getAccountDetail{
    [MyProgressHUD showProgress];
    BmobUser *user = [BmobUser getCurrentUser];
    //获取账户余额
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            [MyProgressHUD dismiss];
        }else{
            [MyProgressHUD dismiss];
            BmobObject *obj = [array firstObject];
            self.countMoney = [[obj objectForKey:ktMoneyCount]floatValue];
            self.QsMoney = [[obj objectForKey:ktIntegralCount]integerValue];
        }
    }];
}


#pragma mark - 支付
-(void)payOrder:(BmobUser *)user detailObject:(BmobObject*)detailObj
{
    [MyProgressHUD showProgress];
    
    /*生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc]init];
    
    order.partner = kAliPayPartnerID;
    order.seller = kAliPaySellerID;
    
    
    order.tradeNO = [NSString stringWithFormat:@"%@/%@",user.objectId,detailObj.objectId]; //订单ID（由商家自行制定）
    
    order.productName = @"注册会员"; //商品标题
    
    order.productDescription = @"开通VIP会员/年（金邦果）"; //商品描述
    
    order.amount = @"399"; //商品价格
    
    order.notifyURL =  kAliPaySellerID; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = kURLSheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(kAliPayPrivateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"%s,reslut = %@",__func__,resultDic);
            
            
            
            NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"]integerValue];
            if (resultStatus == 9000) {
                
                
                //创建支付明细
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
                
            }
            else
            {//支付失败
                [MyProgressHUD dismiss];
                [CommonMethods showDefaultErrorString:@"支付失败"];
                
            }
        }];
        
    }
}







- (IBAction)applyVipAction:(UIButton *)sender {
    
    BmobUser *user = [BmobUser getCurrentUser];
    if ([[user objectForKey:kuser_level]integerValue] == 2) {
        [CommonMethods showDefaultErrorString:@"您已经是会员了"];
    }else{
        BmobObject *detailObj = [BmobObject objectWithClassName:kDetailAccount];
        [self payOrder:user detailObject:detailObj];
    }
    
    
    
}
@end
