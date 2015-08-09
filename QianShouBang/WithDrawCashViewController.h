//
//  WithDrawCashViewController.h
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface WithDrawCashViewController : BaseViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;

- (IBAction)commitAction:(UIButton *)sender;
@end
