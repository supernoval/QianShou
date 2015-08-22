//
//  WithDrawCashViewController.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "WithDrawCashViewController.h"
#import "DrawCashDetailTVC.h"
#import "QSUser.h"

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


- (IBAction)commitAction:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    BmobUser *user = [BmobUser getCurrentUser];
   
    if (self.codeTextField.text.length == 0) {
        [CommonMethods showAlertString:@"请输入您的牵手邦密码" delegate:self tag:20];
    }else{
        [QSUser loginInbackgroundWithAccount:[user objectForKey:@"username"] andPassword:self.codeTextField.text block:^(BmobUser *user, NSError *error){
            if (!error) {
                DrawCashDetailTVC *detail = [sb instantiateViewControllerWithIdentifier:@"DrawCashDetailTVC"];
                [self.navigationController pushViewController:detail animated:YES];
            }
        }];
        
    }
}
@end
