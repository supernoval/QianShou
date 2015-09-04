//
//  YellDetailTableViewController.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/27.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "YellModel.h"

#define kYellObjectChangeNote   @"YellObjectChangeNote"
@interface YellDetailTableViewController : BaseTableViewController

@property (nonatomic) YellModel *yellmodel;
@property (nonatomic) NSString *headImage;

@end
