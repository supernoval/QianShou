//
//  SendNeedTableViewController.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface SendNeedTableViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;

- (IBAction)publishAction:(id)sender;


@end
