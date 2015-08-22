//
//  CatchPeopleCell.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatchPeopleCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@property (weak, nonatomic) IBOutlet UIButton *accepButton;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desHeightContraints;

@property (weak, nonatomic) IBOutlet UILabel *descriCell;

@end
