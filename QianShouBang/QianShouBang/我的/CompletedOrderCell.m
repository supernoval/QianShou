//
//  CompletedOrderCell.m
//  QianShouBang
//
//  Created by ucan on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "CompletedOrderCell.h"

@implementation CompletedOrderCell

- (void)awakeFromNib {
    self.completeBtn.layer.masksToBounds = YES;
    self.completeBtn.layer.cornerRadius = 4.0;
    self.completeBtn.layer.borderWidth = 1.0;
    self.completeBtn.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
