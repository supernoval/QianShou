//
//  ForgetCodeTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ForgetCodeTVC.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"
#import "QSUser.h"
#import "BmobDataListName.h"
#import "ChangeCodeTVC.h"


@interface ForgetCodeTVC ()

@end

@implementation ForgetCodeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    _summitButton.clipsToBounds = YES;
    _summitButton.layer.cornerRadius = 20.0;
    
    
}


#pragma mark - 查询手机号码是否注册过
-(void)checkPhonehadRegist
{
    
    BmobQuery *bquery =[[BmobQuery alloc]initWithClassName:kUserClassName];
    
    [bquery whereKey:@"username" equalTo:_phoneNum.text];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count > 0)
        {
            
            NSLog(@"hadRegist:%@",array);
            
            
            
            _sendCodeButton.enabled = NO;
            [MyProgressHUD showProgress];
            [SMS_SDK getVerificationCodeBySMSWithPhone:_phoneNum.text zone:@"86" result:^(SMS_SDKError *error) {
                
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
        else
        {
            
            [CommonMethods showDefaultErrorString:@"该手机号码未注册,请先注册"];
        
               NSLog(@"phone num None Regist!");
            
            
        }
    }];
    
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
                _sendCodeButton.enabled = NO;
                
                
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)sendCodeAction:(id)sender {
    
    if ([CommonMethods checkTel:_phoneNum.text]) {
        
        
        [self checkPhonehadRegist];
        
        
    }
    else
    {
        [CommonMethods showDefaultErrorString:@"手机号码不正确"];
        
        
    }
    
    
}

- (IBAction)summitAction:(id)sender {
    
    if ([CommonMethods checkTel:_phoneNum.text] && _codeTF.text.length > 0)
    {
        
        [self checkSMSCode:_codeTF.text];
        
        
    }
    
    
}

#pragma mark -  校验验证码
-(void)checkSMSCode:(NSString *)SMSCode
{
    
    [MyProgressHUD showProgress];
    
    [SMS_SDK commitVerifyCode:SMSCode result:^(enum SMS_ResponseState state) {
        
        [MyProgressHUD dismiss];
        
        if (state == 1)
        {
            
            
            
            ChangeCodeTVC *changeCodeTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeCodeTVC"];
            
            changeCodeTVC.phoneNum = _phoneNum.text;
            
            
            [self.navigationController pushViewController:changeCodeTVC animated:YES];
            
            
            
        
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"验证码不正确"];
            
            
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
