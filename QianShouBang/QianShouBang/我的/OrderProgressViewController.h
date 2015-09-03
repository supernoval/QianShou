//
//  OrderProgressViewController.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OrderProgressViewController : BaseViewController

@property (nonatomic) BmobObject *orderObject;
@property (nonatomic) NSString *headImageName;

@property (nonatomic) BOOL isFisnish;  

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *publisherHeadImageView;

@property (weak, nonatomic) IBOutlet UIButton *phoneCallButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@property (weak, nonatomic) IBOutlet UILabel *catchTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *catchHeadImage;

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderDetailLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeightContraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dotLineHeightContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLineHeightContraint;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressHeightConstraint;



@property (weak, nonatomic) IBOutlet UILabel *benjinLabel;

@property (weak, nonatomic) IBOutlet UILabel *commisionLabel;


@property (weak, nonatomic) IBOutlet UILabel *bonusLabel;

@property (weak, nonatomic) IBOutlet UIImageView *secPublishHeadImageView;

@property (weak, nonatomic) IBOutlet UIImageView *redLIneIImageView;

@property (weak, nonatomic) IBOutlet UIImageView *dotImageView;


@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;

@property (weak, nonatomic) IBOutlet UILabel *confirmTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderStatelabel;


@end
