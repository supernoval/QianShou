//
//  MallCell.m
//  QianShouBang
//
//  Created by ucan on 15/8/7.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MallCell.h"

@implementation MallCell

- (void)awakeFromNib {
    self.exchangeBtn.layer.masksToBounds = YES;
    self.exchangeBtn.layer.cornerRadius = 4.0;
    self.exchangeBtn.layer.borderWidth = 1.0;
    self.exchangeBtn.layer.borderColor =  [UIColor colorWithRed:253 green:159 blue:8 alpha:1.0].CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
