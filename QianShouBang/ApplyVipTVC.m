//
//  ApplyVipTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/20.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ApplyVipTVC.h"

@interface ApplyVipTVC ()

@end

@implementation ApplyVipTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册VIP会员（金邦果）";
    self.view.backgroundColor = [UIColor whiteColor];
    self.applyBtn.layer.masksToBounds = YES;
    self.applyBtn.layer.cornerRadius = 4;
    self.applyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.applyBtn.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)applyVipAction:(UIButton *)sender {
}
@end
