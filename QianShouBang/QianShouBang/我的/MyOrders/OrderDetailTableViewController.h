//
//  OrderDetailTableViewController.h
//  QianShouBang
//
//  Created by 123456 on 15/8/24.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface OrderDetailTableViewController : BaseTableViewController

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *publisherHeadImage;

@property (weak, nonatomic) IBOutlet UILabel *publishNick;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *catchPeopleHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *catchPeopleNick;

@property (weak, nonatomic) IBOutlet UIView *footerView;

- (IBAction)callPhone:(id)sender;

- (IBAction)sendMessage:(id)sender;

- (IBAction)showLocation:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *doneAction;

- (IBAction)cancelAction:(id)sender;

@end
