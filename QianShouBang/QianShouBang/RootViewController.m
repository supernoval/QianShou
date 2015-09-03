//
//  RootViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/9/3.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RootViewController.h"
#import "Constants.h"
#import "GuideViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    //引导页设置
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"FirstLaunch"])
    {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
        
        GuideViewController *guideVC = [sb instantiateViewControllerWithIdentifier:@"GuideViewController"];
        
        [self presentViewController:guideVC animated:NO completion:nil];
        
        
    }
    else
    {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        UITabBarController *tabbarVC = [ main instantiateViewControllerWithIdentifier:@"RootTabbarController"];
        
        [self presentViewController:tabbarVC animated:NO completion:nil];
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
 
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
