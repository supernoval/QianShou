//
//  UserDetailTVC.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/19.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//


#import "BaseTableViewController.h"


typedef NS_ENUM(NSInteger, FromType)
{
    FromTypeNear,
    FromTypeFriendList,
    FromTypeNewFriendInvite,
    
};

@interface UserDetailTVC : BaseTableViewController


@property (nonatomic) BmobUser *user;

@property (nonatomic) FromType fromType;

@property (nonatomic) NSString *headImageString;


@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@property (weak, nonatomic) IBOutlet UIButton *headButton;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;


@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIButton *sendMesButton;

@property (weak, nonatomic) IBOutlet UIButton *phoneCallButton;

- (IBAction)sendAction:(id)sender;

- (IBAction)phoneCallAction:(id)sender;

- (IBAction)showRightAction:(id)sender;

- (IBAction)showHeadView:(id)sender;

@end
