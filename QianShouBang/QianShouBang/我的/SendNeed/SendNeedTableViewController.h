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
@property (weak, nonatomic) IBOutlet UITableViewCell *imagesViewCell;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;

- (IBAction)publishAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *needTF;

@property (weak, nonatomic) IBOutlet UIImageView *imgOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgThree;
@property (weak, nonatomic) IBOutlet UIImageView *imgFour;

@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonFour;

@property (weak, nonatomic) IBOutlet UIButton *minusOne;
@property (weak, nonatomic) IBOutlet UIButton *minusTwo;
@property (weak, nonatomic) IBOutlet UIButton *minusThree;
@property (weak, nonatomic) IBOutlet UIButton *minusFour;


@property (weak, nonatomic) IBOutlet UITextField *benjinTF;

@property (weak, nonatomic) IBOutlet UITextField *xiaofeiTF;

- (IBAction)pickPhoto:(id)sender;


@end
