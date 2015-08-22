//
//  MyOderCell.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoGroup.h"

@interface MyOderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descripHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeightContraint;

@property (weak, nonatomic) IBOutlet SDPhotoGroup *photoView;

@end
