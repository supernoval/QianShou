//
//  ApplyVipTVC.h
//  QianShouBang
//
//  Created by ucan on 15/8/20.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ApplyVipTVC : BaseTableViewController
@property (strong, nonatomic) IBOutlet UIButton *applyBtn;

- (IBAction)applyVipAction:(UIButton *)sender;
@end
