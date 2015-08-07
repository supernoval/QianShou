//
//  IntroduceYourselfViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/7.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "IntroduceYourselfViewController.h"

@interface IntroduceYourselfViewController ()

@end

@implementation IntroduceYourselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写自我描述";
    self.view.backgroundColor = kBackgroundColor;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 4.0;
    self.confirmBtn.layer.borderWidth = 1.0;
    self.confirmBtn.layer.borderColor = kYellowColor.CGColor;
    self.introTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSString *remain =[ NSString  stringWithFormat:  @"%li/30" , (long)existTextNum];
        if (textView.text.length== 0) {
            self.numLabel.text = @"0/30";
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
    
    if (textView.text.length>29)
    {
        
        
        NSString *oneHundrutext = [textView.text substringToIndex:30];
        
        textView.text = oneHundrutext;
        
        [textView resignFirstResponder];
    }
    
    NSInteger existTextNum=[textView.text length];
    //    NSInteger remainTextNum = 100 - existTextNum;
    NSString *remain =[ NSString  stringWithFormat:  @"%li/30" , (long)existTextNum];
    if (textView.text.length== 0) {
        self.numLabel.text = @"0/30";
    }
    else{
        self.numLabel.text = remain;
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
        if ([text isEqualToString:@"\n"] || textView.text.length > 29)
        {
            [textView resignFirstResponder];
            return NO;
        }
    
    
    return YES;
}

@end
