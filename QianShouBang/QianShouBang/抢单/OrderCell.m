//
//  OrderCell.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/19.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    
    
    self.accepteButton.clipsToBounds=YES;
    self.accepteButton.layer.cornerRadius = 15;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)acceptAction:(id)sender {
    
    
    
    
    
}
@end
