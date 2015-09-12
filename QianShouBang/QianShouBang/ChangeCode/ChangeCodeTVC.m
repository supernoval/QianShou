//
//  ChangeCodeTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ChangeCodeTVC.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"
#import "QSUser.h"


@interface ChangeCodeTVC ()<UIAlertViewDelegate>
{
     
}
@end

@implementation ChangeCodeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
    _changeCodeButton.clipsToBounds = YES;
    _changeCodeButton.layer.cornerRadius = 10.0;
    
    
}


- (IBAction)changeCodeAction:(id)sender {
    
    if (_newpwdTF.text.length == 0)
    {
        
        [MyProgressHUD showError:@"密码不能为空"];
        
     
        return;
    }
    
    if (_newpwdTF.text.length > 16) {
        
        [MyProgressHUD showError:@"密码必须小于16位"];
        
        
        return;
    }
    
    if (![_newpwdTF.text isEqualToString:_againpwdTF.text]) {
        
        [MyProgressHUD showError:@"两次输入的密码不一致"];
        
        
        return;
    }
    
    NSDictionary *param = @{@"phone":_phoneNum,@"password":_newpwdTF.text};
    
    NSLog(@"param:%@",param);
    
    [BmobCloud callFunctionInBackground:@"updatePwd" withParameters:param block:^(id object, NSError *error) {
        
        if (!error) {
            
            
            [CommonMethods showAlertString:@"修改成功" delegate:self tag:999];
            
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"修改失败"];
            
        }
        
    } ];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 999) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
