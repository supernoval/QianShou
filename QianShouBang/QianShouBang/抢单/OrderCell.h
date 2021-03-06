//
//  OrderCell.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/19.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoItem.h"
#import "SDPhotoGroup.h"

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nicknameLabelWithConstraint;


@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descripContraints;

@property (weak, nonatomic) IBOutlet UIButton *locationButton;


@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *accepteButton;

- (IBAction)acceptAction:(id)sender;

@property (weak, nonatomic) IBOutlet SDPhotoGroup *photoView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeightContraint;

@end
