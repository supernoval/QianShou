//
//  FeedBackViewController.h
//  QianShouBang
//
//  Created by ucan on 15/8/13.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedBackViewController : BaseViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *introTextView;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;

- (IBAction)CommitSuggestion:(UIButton *)sender;

@end
