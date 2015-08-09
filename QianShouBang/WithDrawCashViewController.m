//
//  WithDrawCashViewController.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "WithDrawCashViewController.h"

@interface WithDrawCashViewController ()

@end

@implementation WithDrawCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.title = @"提现";
    self.commitBtn.layer.masksToBounds = YES;
    self.commitBtn.layer.cornerRadius = 4.0;
    self.commitBtn.layer.borderWidth = 1.0;
    self.commitBtn.layer.borderColor = kYellowColor.CGColor;
    self.codeTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)commitAction:(UIButton *)sender {
}
@end
