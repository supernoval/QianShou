//
//  NickNameViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/7.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "NickNameViewController.h"

@interface NickNameViewController ()

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更改昵称";
    self.view.backgroundColor = kBackgroundColor;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 4.0;
    self.confirmBtn.layer.borderWidth = 1.0;
    self.confirmBtn.layer.borderColor = kYellowColor.CGColor;
    self.introTextView.delegate = self;
    
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.introTextView becomeFirstResponder];
    
}

//确认提交
- (IBAction)commitAction:(UIButton *)sender {
}




//统计textView输入的字数
-(void)textViewDidChange:(UITextView *)textView{
    
    NSString  *nsTextContent=textView.text;
    NSInteger existTextNum=[nsTextContent length];
    NSString *remain =[ NSString  stringWithFormat:  @"%li/24" , (long)existTextNum];
    if (textView.text.length== 0) {
        self.numLabel.text = @"0/24";
    }
    else{
        self.numLabel.text = remain;
    }
    
    
    
}

#pragma mark - UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length>23)
    {
        
        
        NSString *oneHundrutext = [textView.text substringToIndex:24];
        
        textView.text = oneHundrutext;
        
        [textView resignFirstResponder];
    }
    
    NSInteger existTextNum=[textView.text length];
    //    NSInteger remainTextNum = 100 - existTextNum;
    NSString *remain =[ NSString  stringWithFormat:  @"%li/24" , (long)existTextNum];
    if (textView.text.length== 0) {
        self.numLabel.text = @"0/24";
    }
    else{
        self.numLabel.text = remain;
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"] || textView.text.length > 23)
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    
    return YES;
}


@end
