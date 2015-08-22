//
//  CatchPeopleCell.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "CatchPeopleCell.h"

@implementation CatchPeopleCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 30.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
