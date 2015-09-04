//
//  WaitingForAccepViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/9/3.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "WaitingForAccepViewController.h"
#import "MZTimerLabel.h"



@interface WaitingForAccepViewController ()<MZTimerLabelDelegate,UIAlertViewDelegate>
{
    UIAlertView *_cancelAlert;
    
}
@end

@implementation WaitingForAccepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"等待接单";
    
    _headView.frame = CGRectMake(0, 0, ScreenWidth, 541);


    
    _cancelButton.clipsToBounds = YES;
    _cancelButton.layer.cornerRadius = 22.0;
    
    _user = [BmobUser getCurrentUser];
    
    
    [self setupSubViews];
    
    
}


-(void)setupSubViews
{
   
    BmobUser *pushlisher = [self.orderObject objectForKey:@"user"];
    
    NSString *createdAt = [CommonMethods getYYYYMMddFromDefaultDateStr:self.orderObject.createdAt];
    
    NSString *startTime = [CommonMethods getHHmmssFromDefaultDateStr:self.orderObject.createdAt];
    
    NSString *publisherAvatar = [pushlisher objectForKey:@"avatar"];
    
    self.publishDatelabel.text = createdAt;
    self.publishTimeLabel.text = startTime;
    
    
    [self.publishHeadimageView sd_setImageWithURL:[NSURL URLWithString:publisherAvatar] placeholderImage:[UIImage imageNamed:@"waiteHead"]];
    

    
    
    

    
    
    
    NSString *description =[NSString stringWithFormat:@"订单详情:%@",[self.orderObject objectForKey:@"order_description"]];
    
    NSString *address = [NSString stringWithFormat:@"送货地址:%@",[self.orderObject objectForKey:@"order_address"]];
    
    
    NSString *benjin =[NSString stringWithFormat:@"本金:%.2f元",[[self.orderObject objectForKey:@"order_benjin"]floatValue]];
    
    NSString *commission = [NSString stringWithFormat:@"佣金:%.2f元",[[self.orderObject objectForKey:@"order_commission"]floatValue]];
    
    NSString *jiangli = [NSString stringWithFormat:@"系统奖励:%.2f(牵手币)",[[self.orderObject objectForKey:@"jiangli_money"]floatValue]];
    
     self.addressLabel.text = address;
    self.addressLabel.numberOfLines = 0;
     self.orderDetailLabel.text = description;
    
    CGFloat desHeight = [StringHeight heightWithText:description font:FONT_17 constrainedToWidth:ScreenWidth - 180];
    
    CGFloat addressHeght = [StringHeight heightWithText:address font:FONT_17 constrainedToWidth:ScreenWidth - 200];
    
    if (desHeight < 20) {
        
        desHeight = 20;
    }
    
    if (addressHeght < 20) {
        addressHeght = 20;
        
    }
   
     _headView.frame = CGRectMake(0, 0, ScreenWidth, 501 + desHeight + addressHeght);
    
    self.orderDetailHeightConstraint.constant = desHeight;
    
   
    self.addressHeightConstraint.constant = addressHeght;
    
    self.dotLIneHeight.constant = 140 + desHeight + addressHeght;
    self.redLineHeight.constant = 140 + desHeight + addressHeght;
 
    
    self.benjinLabel.text = benjin;
    self.yongjinLabel.text = commission;
    self.jiangliLabel.text = jiangli;
    self.jiangliLabel.adjustsFontSizeToFitWidth = YES;
    
    
  
    
   


    
    //倒计时
    
 
    self.countDownLabel.frame = CGRectMake(0, 0, 100, 21);

    
    MZTimerLabel *_timerLabel = [[MZTimerLabel alloc] initWithLabel:_countDownLabel andTimerType:MZTimerLabelTypeTimer];
   
    NSString *timeStr = [CommonMethods getYYYYMMddHHmmssDateStr:_orderObject.createdAt];
    
    double lefttime= [CommonMethods timeLeft:timeStr];
    
    
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


- (IBAction)cancelAction:(id)sender {
    
    
    _cancelAlert = [[UIAlertView alloc]initWithTitle:nil message:@"确定取消订单?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [_cancelAlert show];
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (alertView == _cancelAlert && buttonIndex == 1)
    {
        
        [MyProgressHUD showProgress];
        
        [_orderObject setObject:@(OrderStatePublishCancel) forKey:@"order_state"];
        
        [_orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
           
            if (isSuccessful) {
                
                //更新明细
                [CommonMethods updateDetailAccountWithType:DetailAccountTypeReturn_money Order:_orderObject User:_user money:0 qianshoubi:0 withResultBlock:^(BOOL success, BmobObject *detailObject) {
                    
                    [MyProgressHUD dismiss];
                    
                    if (success)
                    {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:kCancelOrderNotification object:_orderObject];
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
                    }
                    else
                    {
                        [CommonMethods showDefaultErrorString:@"取消订单失败,请重试"];
                        
                        
                        
                    }
                    
                }];
                
                
            }
            
        }];
        
        
    }
    
}

@end
