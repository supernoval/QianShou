//
//  FeedBackViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/13.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写自我描述";
    self.view.backgroundColor = kBackgroundColor;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 4.0;
    self.confirmBtn.layer.borderWidth = 1.0;
    self.confirmBtn.layer.borderColor = kYellowColor.CGColor;
    self.introTextView.delegate = self;
    
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    // Do any additional setup after loading the view.
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


//统计textView输入的字数
-(void)textViewDidChange:(UITextView *)textView{
    
    NSString  *nsTextContent=textView.text;
    NSInteger existTextNum=[nsTextContent length];
    NSString *remain =[ NSString  stringWithFormat:  @"%li/500" , (long)existTextNum];
    if (textView.text.length== 0) {
        self.numLabel.text = @"0/500";
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
    NSInteger existTextNum=[textView.text length];
    //    NSInteger remainTextNum = 100 - existTextNum;
    NSString *remain =[ NSString  stringWithFormat:  @"%li/500" , (long)existTextNum];
    if (textView.text.length== 0) {
        self.numLabel.text = @"0/500";
    }
    else{
        self.numLabel.text = remain;
    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length>499)
    {
        
        
        NSString *oneHundrutext = [textView.text substringToIndex:500];
        
        textView.text = oneHundrutext;
        
        [textView resignFirstResponder];
    }
    
    NSInteger existTextNum=[textView.text length];
    //    NSInteger remainTextNum = 100 - existTextNum;
    NSString *remain =[ NSString  stringWithFormat:  @"%li/500" , (long)existTextNum];
    if (textView.text.length== 0) {
        self.numLabel.text = @"0/500";
    }
    else{
        self.numLabel.text = remain;
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"] || textView.text.length > 499)
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    
    return YES;
}


#pragma -mark AlertviewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 11) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)CommitSuggestion:(UIButton *)sender {
    BmobUser *user = [BmobUser getCurrentUser];
    
    BmobObject *obj = [BmobObject objectWithClassName:@"FeedBackBean"];
    
    
    
    if (self.introTextView.text.length == 0) {
        [CommonMethods showAlertString:@"请填写反馈内容。" delegate:self tag:10];
    }else{
        [obj setObject:user forKey:@"user"];
        [obj setObject:self.introTextView.text forKey:@"feedback_contect"];
        
        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error){
            if (isSuccessful) {
                [CommonMethods showAlertString:@"反馈成功！" delegate:self tag:11];
            }else if(error){
                [CommonMethods showAlertString:@"反馈失败！" delegate:self tag:12];
            }
        }];
        
        
    }
}
@end
