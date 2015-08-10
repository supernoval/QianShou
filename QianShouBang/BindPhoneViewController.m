//
//  BindPhoneViewController.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BindPhoneViewController.h"

@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.title = @"绑定手机号";
    self.commitBtn.layer.masksToBounds = YES;
    self.commitBtn.layer.cornerRadius = 4.0;
    self.commitBtn.layer.borderWidth = 1.0;
    self.commitBtn.layer.borderColor = kYellowColor.CGColor;
    
    BmobUser *user = [BmobUser getCurrentUser];
    NSString *phone = [user objectForKey:kuser_phone];
    self.phoneTextField.text = CheckNil(phone);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)commitAction:(UIButton *)sender {
    BOOL correct;
   correct =  [CommonMethods checkTel:self.phoneTextField.text];
    if (!correct) {
        [CommonMethods showAlertString:@"手机号码格式不正确。" delegate:self tag:10];
    }else{
        BmobUser *user = [BmobUser getCurrentUser];
        [user setObject:self.phoneTextField.text forKey:kuser_phone];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
            if (isSuccessful) {
                [CommonMethods showAlertString:@"绑定手机号成功！" delegate:self tag:11];
            }else if(error){
                [CommonMethods showAlertString:@"绑定手机号失败！" delegate:self tag:12];
            }
        }];
    }
}

#pragma -mark AlertviewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 11) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
