//
//  GoodsDescripCell.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "GoodsDescripCell.h"

@implementation GoodsDescripCell

- (void)awakeFromNib {
    [self.descrip setEditable:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
