//
//  OrderProgressViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "OrderProgressViewController.h"
#import "ChatViewController.h"
#import "MZTimerLabel.h"

@interface OrderProgressViewController ()<MZTimerLabelDelegate>

@end

@implementation OrderProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 650);
    
    self.publisherHeadImageView.clipsToBounds = YES;
    self.publisherHeadImageView.layer.cornerRadius = 30.0;
    
    self.catchHeadImage.clipsToBounds = YES;
    self.catchHeadImage.layer.cornerRadius = 30.0;
    
    self.secPublishHeadImageView.clipsToBounds = YES;
    self.secPublishHeadImageView.layer.cornerRadius = 30.0;
    
    
    [self setupSubViews];
    
    
    
    
}


-(void)setupSubViews
{
    
    BmobUser *pushlisher = [self.orderObject objectForKey:@"user"];
    BmobUser *user = [BmobUser getCurrentUser];
    
    NSString *createdAt = [CommonMethods getYYYYMMddFromDefaultDateStr:self.orderObject.createdAt];
    
    NSString *startTime = [CommonMethods getHHmmssFromDefaultDateStr:self.orderObject.createdAt];
    
    NSString *publisherAvatar = [pushlisher objectForKey:@"avatar"];
    
    self.publishDateLabel.text = createdAt;
    self.publishTimeLabel.text = startTime;
    
    [self.publisherHeadImageView sd_setImageWithURL:[NSURL URLWithString:publisherAvatar] placeholderImage:[UIImage imageNamed:@"head_default"]];
    [self.secPublishHeadImageView sd_setImageWithURL:[NSURL URLWithString:publisherAvatar] placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    
    NSLog(@"order_start_time:%@",[self.orderObject objectForKey:@"order_start_time"]);
    
    NSString *catchTime = [CommonMethods getHHmmssStr:[self.orderObject objectForKey:@"order_start_time"]];
    NSString *catchAvatar = [user objectForKey:@"avatar"];
    
    [self.catchHeadImage sd_setImageWithURL:[NSURL URLWithString:catchAvatar] placeholderImage:[UIImage imageNamed:@"head_default"]];
    self.catchTimeLabel.text = catchTime;
    
    
    NSString *description =[NSString stringWithFormat:@"订单详情:%@",[self.orderObject objectForKey:@"order_description"]];
    
    NSString *address = [NSString stringWithFormat:@"送货地址:%@",[self.orderObject objectForKey:@"order_address"]];
    
    
    NSString *benjin =[NSString stringWithFormat:@"本金:%.2f",[[self.orderObject objectForKey:@"order_benjin"]floatValue]];
    
    NSString *commission = [NSString stringWithFormat:@"佣金:%.2f",[[self.orderObject objectForKey:@"order_commission"]floatValue]];
    
    NSString *jiangli = [NSString stringWithFormat:@"系统奖励:%.2f(牵手币)",[[self.orderObject objectForKey:@"jiangli_money"]floatValue]];
    
    
    CGFloat desHeight = [StringHeight heightWithText:description font:FONT_17 constrainedToWidth:200];
    
    CGFloat addressHeght = [StringHeight heightWithText:address font:FONT_17 constrainedToWidth: 200];
    
    if (desHeight < 20) {
        
        desHeight = 20;
    }
    
    if (addressHeght < 20) {
        addressHeght = 20;
        
    }
    self.orderDetailLabel.text = description;
    self.detailHeightContraint.constant = desHeight;
    
    self.addressLabel.text = address;
    self.addressHeightConstraint.constant = addressHeght;
    
    
    
    self.benjinLabel.text = benjin;
    self.commisionLabel.text = commission;
    self.bonusLabel.text = jiangli;
    
    
    
    [self.phoneCallButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    
    [self.messageButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (_isFisnish) {
        
        _redLIneIImageView.image = nil;
        _redLIneIImageView.backgroundColor = kBlueColor;
        
        _dotImageView.image = nil;
        _dotImageView.backgroundColor = kBlueColor;
        
        
        _confirmTimeLabel.text = [CommonMethods getHHmmssFromDefaultDateStr:self.orderObject.updatedAt];
        
        _confirmLabel.text = @"确认订单成功";
        _confirmLabel.textColor = [UIColor redColor];
        
        
        
    }
    else
    {
        
    }
    
    
    //倒计时
    
    MZTimerLabel *_timerLabel = [[MZTimerLabel alloc] initWithLabel:self.countDownLabel andTimerType:MZTimerLabelTypeTimer];
    
    double lefttime= [CommonMethods timeLeft:[_orderObject objectForKey:@"order_start_time"] ];
    
    
    [_timerLabel setCountDownTime:lefttime];
    _timerLabel.delegate = self;
    [_timerLabel start];
    

    
    
    
}


-(void)callPhone
{
      BmobUser *pushlisher = [self.orderObject objectForKey:@"user"];
    
    NSString *phoneNum = pushlisher.username;
    
    [CommonMethods callPhoneWithSuperView:self.view phoneNum:phoneNum];
    
}

-(void)sendMessage
{
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    BmobUser *pushlisher = [self.orderObject objectForKey:@"user"];
    BmobChatUser *user = (BmobChatUser *)pushlisher;
    NSString *publisherAvatar = [pushlisher objectForKey:@"avatar"];
    NSString *nick = [pushlisher objectForKey:@"nick"];
    
    [infoDic setObject:user.objectId forKey:@"uid"];
    [infoDic setObject:user.username forKey:@"name"];
    
    if (publisherAvatar) {
        [infoDic setObject:publisherAvatar forKey:@"avatar"];
    }
    if (nick) {
        [infoDic setObject:nick forKey:@"nick"];
    }
    ChatViewController *cvc = [[ChatViewController alloc] initWithUserDictionary:infoDic];
    cvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cvc animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
