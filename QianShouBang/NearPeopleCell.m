//
//  NearPeopleCell.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "NearPeopleCell.h"
#import "Constants.h"

@implementation NearPeopleCell

- (void)awakeFromNib {
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = self.image.frame.size.width/2;
    self.image.layer.borderWidth = 1.0;
    self.image.layer.borderColor = [UIColor clearColor].CGColor;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
