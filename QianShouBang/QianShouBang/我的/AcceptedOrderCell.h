//
//  AcceptedOrderCell.h
//  QianShouBang
//
//  Created by ucan on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoGroup.h"

@interface AcceptedOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *remainTime;
@property (strong, nonatomic) IBOutlet UILabel *people_send;
@property (strong, nonatomic) IBOutlet UIImageView *vip;

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *addressButton;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *name_width;

@property (weak, nonatomic) IBOutlet SDPhotoGroup *photosView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraints;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeightContrains;

@end
