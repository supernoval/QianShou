//
//  ExchangeQsBiViewController.m
//  QianShouBang
//
//  Created by Leo on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ExchangeQsBiViewController.h"

@interface ExchangeQsBiViewController ()

@end

@implementation ExchangeQsBiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setAppearance];
    [self getMoneyCountData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAppearance{

    
    self.button_1.layer.masksToBounds = YES;
    self.button_1.layer.cornerRadius = 4.0;
    
    self.button_2.layer.masksToBounds = YES;
    self.button_2.layer.cornerRadius = 4.0;
    
    self.button_3.layer.masksToBounds = YES;
    self.button_3.layer.cornerRadius = 4.0;
    
    self.button_4.layer.masksToBounds = YES;
    self.button_4.layer.cornerRadius = 4.0;
}

- (void)getMoneyCountData{
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    [query orderByDescending:@"updatedAt"];
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query whereKey:kisAccountAmountType equalTo:@YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"账户%li",(unsigned long)array.count);
            if (array.count != 0) {
                BmobObject *obj = [array firstObject];
                CGFloat t = [[obj objectForKey:ktMoneyCount]floatValue];
                self.title = [NSString stringWithFormat:@"当前余额%.1f",t];
                
            }
        }
    }];
}

- (IBAction)button_1Action:(UIButton *)sender {
}
- (IBAction)button_2Action:(UIButton *)sender {
}
- (IBAction)button_3Action:(UIButton *)sender {
}

- (IBAction)button_4Action:(UIButton *)sender {
}

- (void)showAlertWithMessage:(NSString *)message tag:(NSInteger)tag{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag == ) {
//        if (buttonIndex == 1) {//确定
//            <#statements#>
//        }
//    }
}
@end
