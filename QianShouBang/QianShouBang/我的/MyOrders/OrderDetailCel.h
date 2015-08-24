//
//  OrderDetailCel.h
//  QianShouBang
//
//  Created by 123456 on 15/8/24.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCel : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWithContraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightContraints;

@end
