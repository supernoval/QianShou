//
//  WaitingForAccepViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/9/3.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "WaitingForAccepViewController.h"

@interface WaitingForAccepViewController ()

@end

@implementation WaitingForAccepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"等待接单";
    
    _scrollView.contentSize = CGSizeMake(ScreenWidth, 603);
    
    _cancelButton.clipsToBounds = YES;
    _cancelButton.layer.cornerRadius = 22.0;
    
    _user = [BmobUser getCurrentUser];
    
    
    
    
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

- (IBAction)cancelAction:(id)sender {
}
@end
