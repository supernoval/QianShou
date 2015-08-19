//
//  RankCell.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RankCell.h"

@implementation RankCell

- (void)awakeFromNib {
    self.rankNumber.layer.masksToBounds = YES;
    self.rankNumber.layer.cornerRadius = 4;
    self.rankNumber.layer.borderColor = [UIColor whiteColor].CGColor;
    self.rankNumber.layer.borderWidth = 1.0;
    
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = self.image.frame.size.width/2;
    self.rankNumber.layer.borderColor = [UIColor whiteColor].CGColor;
    self.rankNumber.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
