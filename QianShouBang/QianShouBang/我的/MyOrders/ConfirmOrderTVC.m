//
//  ConfirmOrderTVC.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/9/4.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ConfirmOrderTVC.h"
#import "MZTimerLabel.h"

@interface ConfirmOrderTVC ()<MZTimerLabelDelegate,UIAlertViewDelegate>
{
    
}
@end

@implementation ConfirmOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"已接单";
    
    _headView.frame = CGRectMake(0, 0, ScreenWidth, 789);
    _cancelButton.clipsToBounds = YES;
    _cancelButton.layer.cornerRadius = 22.0;
    
    _doneButton.clipsToBounds = YES;
    _doneButton.layer.cornerRadius = 22.0;
    
    
    [self setUpSubViews];
    
}
-(void)setUpSubViews
{
    
    BmobUser *user = [self.orderObject objectForKey:@"receive_user"];
    
    
    BmobUser *pushlisher = [BmobUser getCurrentUser];
    
    NSString *createdAt = [CommonMethods getYYYYMMddFromDefaultDateStr:self.orderObject.createdAt];
    
    NSString *startTime = [CommonMethods getHHmmssFromDefaultDateStr:self.orderObject.createdAt];
    
    NSString *publisherAvatar = [pushlisher objectForKey:@"avatar"];
    
    self.publishDateLabel.text = createdAt;
    self.publishTimeLabel.text = startTime;
    
    
    
    self.publisherHeadImage.clipsToBounds = YES;
    self.publisherHeadImage.layer.cornerRadius = 30.0;
    
    self.secPublisherHeadimageView.clipsToBounds = YES;
    self.secPublisherHeadimageView.layer.cornerRadius = 30.0;
    
    self.catchHeadImage.clipsToBounds = YES;
    self.catchHeadImage.layer.cornerRadius = 30.0;
    
    [self.publisherHeadImage sd_setImageWithURL:[NSURL URLWithString:publisherAvatar] placeholderImage:[UIImage imageNamed:@"waiteHead"]];
    [self.secPublisherHeadimageView sd_setImageWithURL:[NSURL URLWithString:publisherAvatar] placeholderImage:[UIImage imageNamed:@"waiteHead"]];
    
    
    
    
    NSString *catchTime = [CommonMethods getHHmmssStr:[self.orderObject objectForKey:@"order_start_time"]];
    NSString *catchAvatar = [user objectForKey:@"avatar"];
    
    
    [self.catchHeadImage sd_setImageWithURL:[NSURL URLWithString:catchAvatar] placeholderImage:[UIImage imageNamed:_headImageName]];
    self.catchTimelabel.text = catchTime;
    
    
    NSString *description =[NSString stringWithFormat:@"订单详情:%@",[self.orderObject objectForKey:@"order_description"]];
    
    NSString *address = [NSString stringWithFormat:@"送货地址:%@",[self.orderObject objectForKey:@"order_address"]];
    
    
    NSString *benjin =[NSString stringWithFormat:@"本金:%.2f元",[[self.orderObject objectForKey:@"order_benjin"]floatValue]];
    
    NSString *commission = [NSString stringWithFormat:@"佣金:%.2f元",[[self.orderObject objectForKey:@"order_commission"]floatValue]];
    
    NSString *jiangli = [NSString stringWithFormat:@"系统奖励:%.2f(牵手币)",[[self.orderObject objectForKey:@"jiangli_money"]floatValue]];
    
    
    CGFloat desHeight = [StringHeight heightWithText:description font:FONT_17 constrainedToWidth:150];
    
    CGFloat addressHeght = [StringHeight heightWithText:address font:FONT_17 constrainedToWidth: 150];
    
    if (desHeight < 20) {
        
        desHeight = 20;
    }
    
    if (addressHeght < 20) {
        addressHeght = 20;
        
    }
    self.orderDetailLabel.text = description;
    self.orderDetailHeightConstraint.constant = desHeight;
    
    self.orderAddressLabel.text = address;
    self.addressHeightConstraint.constant = addressHeght;
    
    self.redLineHighConstraint.constant = addressHeght + desHeight + 145;
    self.dotLineHighConstraint.constant = addressHeght + desHeight + 145;
    
    self.headView.frame = CGRectMake(0, 0, ScreenWidth, 749 + addressHeght + desHeight);
    
    
    self.benjinLabel.text = benjin;
    self.yongjinLabel.text = commission;
    self.jiangliLabel.text = jiangli;
    
    
    
  
    
    
//    NSInteger state = [[_orderObject objectForKey:@"order_state"]integerValue];

    
    
    //倒计时
    self.countDownLabel.frame = CGRectMake(0, 0, 68, 21);
    
    MZTimerLabel *_timerLabel = [[MZTimerLabel alloc] initWithLabel:self.countDownLabel andTimerType:MZTimerLabelTypeTimer];
    
    double lefttime= [CommonMethods timeLeft:[_orderObject objectForKey:@"order_start_time"] ];
    
    
    [_timerLabel setCountDownTime:lefttime];
    _timerLabel.delegate = self;
    [_timerLabel start];
    
    
    
}


#pragma mark- MZTimerLabelDelegate
- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    int second = (int)time  % 60;
    int minute = ((int)time / 60) % 60;
    int hours = ((int)(time / 3600))%24;
    //    int days = (int)(time/3600/24);
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minute,second];
    //    return [NSString stringWithFormat:@"剩余%1d天 %02d:%02d:%02d",days,hours,minute,second];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)callPhone:(id)sender {
    
     BmobUser *user = [self.orderObject objectForKey:@"receive_user"];
    
    NSString *phone = user.username;
    
    [CommonMethods callPhoneWithSuperView:self.view phoneNum:phone];
    
    
    
}

- (IBAction)sendSMS:(id)sender {
    
    BmobUser *user = [self.orderObject objectForKey:@"receive_user"];
    
    NSString *phone = user.username;
    
    [CommonMethods sendMessageWithSuperView:self.view phoneNum:phone];
    
}
- (IBAction)doneAction:(id)sender {
    
    
    UIAlertView *doneAlert =[ [UIAlertView alloc]initWithTitle:nil message:@"确定完成订单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    doneAlert.tag = 99;
    
    [doneAlert show];
    
    
}
- (IBAction)cancelAction:(id)sender {
    
    UIAlertView *cancelAlert = [[UIAlertView alloc]initWithTitle:nil message:@"是否取消订单?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    cancelAlert.tag = 100;
    
    [cancelAlert show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99 && buttonIndex == 1) {
        

        BmobUser *receive_user = [self.orderObject objectForKey:@"receive_user"];
        
        [_orderObject setObject:@(OrderStateDone) forKey:@"order_state"];
        [_orderObject setObject:[BmobUser getCurrentUser] forKey:@"user"];
        [_orderObject setObject:receive_user forKey:@"receive_user"];
        
        [MyProgressHUD showProgress];
        
        [_orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            if (isSuccessful) {
                
              __block  NSInteger num = 0;
                
                //更新明细
                
                //发单明细
                [CommonMethods updateDetailAccountWithType:DetailAccountTypeRelease_order_jl Order:self.orderObject User:[BmobUser getCurrentUser] money:0 qianshoubi:0 withResultBlock:^(BOOL success, BmobObject *detailObject) {
                    
                    
                    num ++;
                    
                    if (num ==2) {
                        
                        [MyProgressHUD dismiss];
                        
                        [self sucessPop];
                        
                    }
                    
                    
                }];
                
                //抢单明细
    
                [CommonMethods updateDetailAccountWithType:DetailAccountTypeIncome Order:self.orderObject User:receive_user money:0 qianshoubi:0 withResultBlock:^(BOOL success, BmobObject *detailObject) {
                    
                    num ++;
                    
                    if (num ==2) {
                        
                        [MyProgressHUD dismiss];
                        
                             [self sucessPop];
                        
                    }
                }];
                
                // 发送通知
                [CommonMethods sendOrderWithReceiver:receive_user orderObject:self.orderObject message:@"您抢的订单已完成" orderstate:OrderStatePublishCancel];
                
            }
            else
            {
                [MyProgressHUD dismiss];
                
                [CommonMethods showDefaultErrorString:@"操作失败，请重试"];
                
            }
        

            
            
        }];
        
    }
    
    if (alertView.tag == 100 && buttonIndex == 1) {
       
        
        BmobUser *receive_user = [self.orderObject objectForKey:@"receive_user"];
        
        [_orderObject setObject:@(OrderStatePublishCancel) forKey:@"order_state"];
        [_orderObject setObject:[BmobUser getCurrentUser] forKey:@"user"];
        [_orderObject setObject:receive_user forKey:@"receive_user"];
        
        
        [MyProgressHUD showProgress];
        
        [_orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            if (isSuccessful) {
                
                

                //更新明细
                
                //发单明细
                [CommonMethods updateDetailAccountWithType:DetailAccountTypeReturn_money Order:self.orderObject User:[BmobUser getCurrentUser] money:0 qianshoubi:0 withResultBlock:^(BOOL success, BmobObject *detailObject) {
                    
                    
                 
 
                        [MyProgressHUD dismiss];
                        
                        [self sucessPop];
            
                    
                    
                }];
                
                // 发送通知
                [CommonMethods sendOrderWithReceiver:receive_user orderObject:self.orderObject message:@"您抢的订单已被取消" orderstate:OrderStatePublishCancel];
                
                
             
            }
            else
            {
                [MyProgressHUD dismiss];
                
                [CommonMethods showDefaultErrorString:@"操作失败，请重试"];
                
                NSLog(@"error:%@",error);
                
                
            }
            
            
            
            
        }];
        

        
    }
}

-(void)sucessPop
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kConfirmedOrderNotification object:self.orderObject];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)cancelPop
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCancelOrderNotification object:self.orderObject];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
