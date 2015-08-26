//
//  LoginViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "LoginViewController.h"
#import "QSUser.h"
#import "CommonMethods.h"
#import "RegistTableViewController.h"
#import "ForgetCodeTVC.h"
#import "MyProgressHUD.h"
#import "Location.h"
#import "UserService.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    _loginButton.clipsToBounds = YES;
    _loginButton.layer.cornerRadius = 20;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginAction:(id)sender {
    
    NSString *phone = _phoneTF.text;
    
    NSString *code = _codeTF.text;
    
    if (phone.length == 0 ||  code.length == 0)
    {
        
        [MyProgressHUD showError:@"请输入用户名和密码"];
        
        return;
        
        
    }
    
       
        [QSUser loginInbackgroundWithAccount:phone andPassword:code block:^(BmobUser *user, NSError *error) {
            
            if (!error)
            {
            
           QSUser *qsuser  = [[QSUser alloc]initFromBmobOjbect:user];
           
            NSString *deviceToken = [[NSUserDefaults standardUserDefaults ] objectForKey:kDeviceTokenKey];
            
//            if (deviceToken)
            {
//                if ([deviceToken isEqualToString:qsuser.ANDROID_ID])
                {
                    
                    NSData *deviceData = [[NSUserDefaults standardUserDefaults ] dataForKey:kDeviceTokenData];
                    
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:kHadLogin];
                    [[NSUserDefaults standardUserDefaults ] synchronize];
                    
                    
                    CLLocationDegrees longitude     = [[Location shareInstance] currentLocation].longitude;
                    CLLocationDegrees latitude      = [[Location shareInstance] currentLocation].latitude;
                    
                    //结束定位
                    [[Location shareInstance] stopUpateLoaction];
                    
                    //百度坐标
                  
                    BmobGeoPoint *location          = [[BmobGeoPoint alloc] initWithLongitude:longitude WithLatitude:latitude];
                    
                    
                    BmobUser *user = [BmobUser getCurrentUser];
                    
                    [user setObject:location forKey:@"location"];
                    
                    NSString *install = [user objectForKey:@"installId"];
                    if (install.length == 0 && deviceData && deviceToken.length > 0) {
                        
                         [user setObject:deviceToken forKey:@"installId"];
                        
                        [[BmobUserManager currentUserManager] checkAndBindDeviceToken:deviceData];
                        
                      
                    }
                   
                    
                    
                   
                    [user updateInBackground];
                    
                    
                    //登录成功 保存好友列表
                    [UserService saveFriendsList];
                    
                     
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                }
//                else
//                {
//                    
//                    [QSUser logout];
//                    
//                    [CommonMethods showDefaultErrorString:@"抱歉,不能在其它手机上登录"];
//                    
//  
//                }
             }
            
//              else
//                {
//                    
//
//                     [CommonMethods showDefaultErrorString:@"无法获取您的设备编号,请在 设置-通知 里面打开对《牵手邦》的通知许可"];
//                }
//            
            }
            else
            {
                NSLog(@"Error:%@",error);
                
                
                if (error.code  == 101)
                {
                    
                    [MyProgressHUD showError:@"用户名或者密码错误"];
                    
                }
                else
                {
                    [MyProgressHUD showError:@"登录失败"];
                }
                
                
                
                
            }
            
            
        }];
            
            
        
    
    
    
}

- (IBAction)registAction:(id)sender {
    
    
    
    RegistTableViewController *registTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistTableViewController"];
    
    [self.navigationController pushViewController:registTVC animated:YES];
    
    
    
    
}

- (IBAction)forgetCodeAction:(id)sender {
    
    ForgetCodeTVC *fTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetCodeTVC"];
    
    [self.navigationController pushViewController:fTVC animated:YES];
    
}
@end
