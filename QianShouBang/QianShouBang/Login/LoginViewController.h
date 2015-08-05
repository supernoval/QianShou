//
//  LoginViewController.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
- (IBAction)loginAction:(id)sender;
- (IBAction)registAction:(id)sender;
- (IBAction)forgetCodeAction:(id)sender;

@end
