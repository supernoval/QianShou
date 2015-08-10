//
//  PortraitCell.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PortraitCell.h"

@implementation PortraitCell

- (void)awakeFromNib {
    CGFloat width = self.image.frame.size.width;
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = width/2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
