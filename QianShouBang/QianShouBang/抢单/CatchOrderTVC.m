//
//  CatchOrderTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "CatchOrderTVC.h"
#import "LoginViewController.h"

@interface CatchOrderTVC ()

@end

@implementation CatchOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
  
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
 
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kHadLogin])
    {
        UINavigationController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:loginVC animated:NO completion:nil];
        
    }
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

@end
