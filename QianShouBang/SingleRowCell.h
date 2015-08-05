//
//  SingleRowCell.h
//  QianShouBang
//
//  Created by Leo on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleRowCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *text;

@property (strong, nonatomic) IBOutlet UILabel *extraText;
@end
