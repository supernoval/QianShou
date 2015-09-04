//
//  WaitingForAccepViewController.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/9/3.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//


#import "BaseTableViewController.h"


#define kCancelOrderNotification   @"CancelOrderNotification"

@interface WaitingForAccepViewController : BaseTableViewController


@property (nonatomic) BmobObject *orderObject;
@property (nonatomic) BmobUser *user;




@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UILabel *publishDatelabel;

@property (weak, nonatomic) IBOutlet UIImageView *publishHeadimageView;

@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;


@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderDetailLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderDetailHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *benjinLabel;

@property (weak, nonatomic) IBOutlet UILabel *jiangliLabel;

@property (weak, nonatomic) IBOutlet UILabel *yongjinLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dotLIneHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLineHeight;

- (IBAction)cancelAction:(id)sender;



@end
