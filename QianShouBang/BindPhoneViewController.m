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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)commitAction:(UIButton *)sender {
}
@end
