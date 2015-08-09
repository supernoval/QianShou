//
//  NearPeopleCell.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "NearPeopleCell.h"

@implementation NearPeopleCell

- (void)awakeFromNib {
    // Initialization code
    self.nameBtn.selected = NO;
//    self.nameBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    self.nameBtn.imageView.contentMode = UIViewContentModeBottomRight;
    [self.nameBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
    
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGRect titleF = self.nameBtn.titleLabel.frame;
//    CGRect imageF = self.nameBtn.imageView.frame;
//    
//    titleF.origin.x = imageF.origin.x;
//    self.nameBtn.titleLabel.frame = titleF;
//    imageF.origin.x = CGRectGetMaxX(titleF);
//    self.nameBtn.imageView.frame = imageF;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
