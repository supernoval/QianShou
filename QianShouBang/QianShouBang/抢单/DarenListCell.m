//
//  DarenListCell.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/26.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "DarenListCell.h"

@implementation DarenListCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 25.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
