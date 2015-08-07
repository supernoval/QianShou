//
//  RankCell.h
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *intro_text;
@property (strong, nonatomic) IBOutlet UIImageView *vip;
@property (strong, nonatomic) IBOutlet UILabel *money;

@end
