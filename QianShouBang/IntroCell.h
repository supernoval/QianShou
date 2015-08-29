//
//  IntroCell.h
//  QianShouBang
//
//  Created by Leo on 15/8/29.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *introText;
@property (strong, nonatomic) IBOutlet UIImageView *image_1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageWidth_1;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeight_1;
@property (strong, nonatomic) IBOutlet UIImageView *image_2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageWidth_2;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeight_2;

@end
