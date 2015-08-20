//
//  BlackListCell.m
//  QianShouBang
//
//  Created by ucan on 15/8/20.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BlackListCell.h"

@implementation BlackListCell

- (void)awakeFromNib {
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = self.image.frame.size.width/2;
    self.image.layer.borderWidth = 1.0;
    self.image.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
