//
//  DarenListCell.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/26.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoGroup.h"

@interface DarenListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *benjinLabel;


@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@property (weak, nonatomic) IBOutlet SDPhotoGroup *imagesView;

@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickNameWithContraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descripHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraints;

@end
