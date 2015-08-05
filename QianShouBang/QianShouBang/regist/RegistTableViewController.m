//
//  RegistTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RegistTableViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"
#import "QSUser.h"
#import "BmobDataListName.h"


@interface RegistTableViewController ()<UIAlertViewDelegate>
{
    NSString *dviceToken;
    
    UIAlertView *_noneAlertView;
    
    UIAlertView *_dviceHadRegist;
    
    
    
}
@end

@implementation RegistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    dviceToken = [[NSUserDefaults standardUserDefaults ] objectForKey:kDeviceTokenKey];
    
    if (dviceToken.length == 0) {
        
        _noneAlertView  = [[UIAlertView alloc]initWithTitle:nil message:@"无法获取您手机的设备编号，请在 设置-通知 里允许《牵手邦》给你推送通知" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [_noneAlertView show];
        
        
        
    }
    else
    {
        [self checkMobileHadRegist];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
}


- (IBAction)sendCodeAction:(id)sender {
    
    if ([CommonMethods checkTel:_phoneTF.text])
    {
        
  
        [self checkPhonehadRegist];
        
        
    }
    else
    {
        [MyProgressHUD showError:@"手机号码不正确"];
        
    }
    
}
- (IBAction)registAction:(id)sender {
    
    if (![CommonMethods checkTel:_phoneTF.text]) {
        
        [MyProgressHUD showError:@"请输入正确的手机号码"];
        
        return;
        
    }
    
    if (_SMSCodeTF.text.length == 0) {
        
        [MyProgressHUD showError:@"请输入验证码"];
        
        
        return;
        
        
    }
    
    if (_codeTF.text.length > 16 || _codeTF.text.length == 0) {
        
        [MyProgressHUD showError:@"请输入小于16位的密码"];
        
        return;
        
        
    }
    
    if (![_codeTF.text isEqualToString:_checkCodeTF.text]) {
        
        
        [MyProgressHUD showError:@"两次输入的密码不一致"];
        
        return;
    }
    
    if (_recommendPhone.text.length > 0 && ![CommonMethods checkTel:_recommendPhone.text]) {
        
        [MyProgressHUD showError:@"推荐人手机号码不正确"];
        
        return;
        
        
    }
    
    
    [self checkSMSCode:_SMSCodeTF.text];
    
    
    
}

#pragma mark -  校验验证码
-(void)checkSMSCode:(NSString *)SMSCode
{
    
    [MyProgressHUD showProgress];
    
    [SMS_SDK commitVerifyCode:SMSCode result:^(enum SMS_ResponseState state) {
    
         [MyProgressHUD dismiss];
        
        if (state == 1)
        {
            
            [self summitRegist];
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"验证码不正确"];
            
            
        }
    }];
    
}

#pragma mark - 提交注册
-(void)summitRegist
{
    QSUser *user = [[QSUser alloc]init];
    
    user.username = _phoneTF.text;
    user.password = _codeTF.text;
    user.ANDROID_ID = dviceToken;
    [user setObject:dviceToken forKey:@"ANDROID_ID"];
    
    user.mobilePhoneNumber = _phoneTF.text;
    
    [user setObject:_phoneTF.text forKey:@"mobilePhoneNumber"];
    
    
    user.agent_user = 0;
    [user setObject:@0 forKey:@"agent_user"];
    
    user.user_sex = 1;
    [user setObject:@1 forKey:@"user_sex"];
    
    user.user_individuality_signature = @"主人很懒，什么都没留下";
    [user setObject:@"主人很懒，什么都没留下" forKey:@"user_individuality_signature"];
    
    user.user_phone = _phoneTF.text;
    [user setObject:_phoneTF.text forKey:@"user_phone"];
    
    
    BmobGeoPoint *point = [[BmobGeoPoint alloc]initWithLongitude:0.0 WithLatitude:0.0];
    [user setObject:point forKey:@"geoPoint"];
    
    user.geoPoint = point;
    user.nick = @"邦果";
    [user setObject:@"帮果" forKey:@"nick"];
    
    
    user.balance = 0;
    [user setObject:@0 forKey:@"balance"];
    
    user.user_level = @"0";
    [user setObject:@"0" forKey:@"user_level"];
    
    user.deviceType = @"ios";
    [user setObject:@"ios" forKey:@"deviceType"];
    
    user.recommendUser = _recommendPhone.text;
    
    if (_recommendPhone.text.length > 0)
    {
        
        [user setObject:_recommendPhone.text forKey:@"recommendUser"];
        
    }
    
    
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
            
            NSLog(@"注册成功");
            
            [MyProgressHUD showError:@"注册成功"];
            
            [self login:_phoneTF.text code:_codeTF.text];
            
            
            
        }
        else
        {
            NSLog(@"注册失败:%@",error);
            
        }
    }];
    
    
    
}

- (IBAction)showPrivacy:(id)sender {
}


#pragma mark - 倒计时
-(void)getAutoCodeTime{
    __block int timeout=30;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal] ;
                _sendCodeButton.enabled = YES;
                
            });
        }else{
            int seconds = timeout % 31;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"____%@",strTime);
                
                [_sendCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal] ;
                _sendCodeButton.enabled = YES;
                
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 查询手机号码是否注册过
-(void)checkPhonehadRegist
{

    BmobQuery *bquery =[[BmobQuery alloc]initWithClassName:kUserClassName];
    
    [bquery whereKey:@"username" equalTo:_phoneTF.text];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count > 0)
        {
            
            NSLog(@"hadRegist:%@",array);
            
            [CommonMethods showDefaultErrorString:@"该手机号码已经注册,不能重复注册"];
            
        
            
            
            
            
        }
        else
        {
            
            NSLog(@"phone num None Regist!");
          
            
            _sendCodeButton.enabled = NO;
            [MyProgressHUD showProgress];
            [SMS_SDK getVerificationCodeBySMSWithPhone:_phoneTF.text zone:@"86" result:^(SMS_SDKError *error) {
                
                [MyProgressHUD dismiss];
                
                if (!error)
                {
                    
                    [self getAutoCodeTime];
                    
                }
                else
                {
                    _sendCodeButton.userInteractionEnabled = YES;
                    [MyProgressHUD showError:error.errorDescription];
                    
                }
                
            }];
            
            
            
        }
    }];
    
}

#pragma mark - 查询设备是否注册过
-(void)checkMobileHadRegist
{
    BmobQuery *bquery =[[BmobQuery alloc]initWithClassName:kUserClassName];
    
    [bquery whereKey:@"ANDROID_ID" equalTo:dviceToken];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count > 0)
        {
            
            NSLog(@"hadRegist:%@",array);
            
            _dviceHadRegist = [[UIAlertView alloc]initWithTitle:nil message:@"您的手机设备编号已经注册过,不能再次用该手机注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [_dviceHadRegist show];
            
        
            
        }
        else
        {
            
            NSLog(@"None Regist!");
            
            
        
        }
    }];
    
    

}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _noneAlertView)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    if (alertView == _dviceHadRegist) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
        
    }
}

#pragma mar - 自动登录
-(void)login:(NSString*)phone  code:(NSString*)code
{
    
    [MyProgressHUD showProgress];
    
     [QSUser loginInbackgroundWithAccount:phone andPassword:code block:^(BmobUser *user, NSError *error) {
        
         [MyProgressHUD dismiss];
         
         if (!error) {
             
             [[NSUserDefaults standardUserDefaults ] setObject:@1 forKey:kHadLogin];
             [[NSUserDefaults standardUserDefaults ] synchronize];
             
             [self.navigationController dismissViewControllerAnimated:YES completion:nil];
             
             
         }
         else
         {
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
     }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
