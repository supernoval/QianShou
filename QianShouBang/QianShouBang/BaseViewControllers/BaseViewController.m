//
//  BaseViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UITapGestureRecognizer *_tapResign;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    self.view.backgroundColor = kBackgroundColor;
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
//    
//    self.navigationItem.leftBarButtonItem = leftButton;
    
     _tapResign = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
    
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarddidShow) name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyboarddidShow
{
    [self.view addGestureRecognizer:_tapResign];
    
    
}
-(void)hideKeyboard
{
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:_tapResign];
    
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
