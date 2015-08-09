//
//  BindPhoneViewController.h
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface BindPhoneViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;

@property (strong, nonatomic) IBOutlet UIButton *commitBtn;
- (IBAction)commitAction:(UIButton *)sender;
@end
