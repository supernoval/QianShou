//
//  ConfirmOrderTVC.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/9/4.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"


#define kConfirmedOrderNotification @"ConfirmedOrderNotification"

#define kCancelOrderNotification   @"CancelOrderNotification"


@interface ConfirmOrderTVC : BaseTableViewController


@property (nonatomic) BmobObject *orderObject;

@property (nonatomic) NSString *headImageName;


@property (weak, nonatomic) IBOutlet UIView *headView;


@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *catchTimelabel;

@property (weak, nonatomic) IBOutlet UIImageView *publisherHeadImage;

@property (weak, nonatomic) IBOutlet UIImageView *catchHeadImage;
- (IBAction)callPhone:(id)sender;

- (IBAction)sendSMS:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;


@property (weak, nonatomic) IBOutlet UILabel *orderDetailLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderDetailHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *orderAddressLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *benjinLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *benjinHeight;


@property (weak, nonatomic) IBOutlet UILabel *yongjinLabel;


@property (weak, nonatomic) IBOutlet UILabel *jiangliLabel;

@property (weak, nonatomic) IBOutlet UIImageView *secPublisherHeadimageView;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)cancelAction:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLineHighConstraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dotLineHighConstraint;


@end
