//
//  CompletedOrderCell.h
//  QianShouBang
//
//  Created by ucan on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIButton *completeBtn;
@property (strong, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *addressButton;


@end
