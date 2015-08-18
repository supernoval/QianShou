//
//  HtmlTextIntroduceViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/18.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "HtmlTextIntroduceViewController.h"
#import "Constants.h"


@interface HtmlTextIntroduceViewController ()

@end

@implementation HtmlTextIntroduceViewController
@synthesize htmlName;
@synthesize titleFontLabel;
@synthesize title;
- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.rightBarButtonItem = nil;
    myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    myWebView.userInteractionEnabled = YES;
    myWebView.backgroundColor = [UIColor clearColor];
    myWebView.delegate = self;
    myWebView.opaque = NO;
    myWebView.scalesPageToFit = NO;
    [self.view addSubview:myWebView];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:htmlName ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = title;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
