//
//  YellCell.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/15.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YellCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWithConstrain;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;

@end
