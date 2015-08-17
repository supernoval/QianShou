//
//  AcceptedOrderCell.m
//  QianShouBang
//
//  Created by ucan on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "AcceptedOrderCell.h"
#import "Constants.h"

@implementation AcceptedOrderCell

- (void)awakeFromNib {
    self.addressButton.layer.masksToBounds = YES;
    self.addressButton.layer.cornerRadius = 4.0;
    self.addressButton.layer.borderWidth = 1.0;
    self.addressButton.layer.borderColor = kLineColor.CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
