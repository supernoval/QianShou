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
    self.image.layer.cornerRadius = 4.0;
    self.image.layer.borderWidth = 1.0;
    self.image.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.intro.layer.masksToBounds = YES;
    self.intro.layer.cornerRadius = 4.0;
    self.intro.layer.borderWidth = 1.0;
    self.intro.layer.borderColor = [UIColor whiteColor].CGColor;
   
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
