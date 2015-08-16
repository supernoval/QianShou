//
//  PublishYellViewController.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface PublishYellViewController : BaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTextViewSpace;

@property (weak, nonatomic) IBOutlet UIView *hidePersonView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIButton *hideInfoButton;

- (IBAction)hideInfoAction:(id)sender;


@end
