//
//  IntroduceYourselfViewController.h
//  QianShouBang
//
//  Created by ucan on 15/8/7.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface IntroduceYourselfViewController : BaseViewController<UITextViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *introTextView;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)commitAction:(UIButton *)sender;

@end
