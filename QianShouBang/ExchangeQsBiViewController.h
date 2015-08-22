//
//  ExchangeQsBiViewController.h
//  QianShouBang
//
//  Created by Leo on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseViewController.h"

@interface ExchangeQsBiViewController : BaseViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeigh;

@property (strong, nonatomic) IBOutlet UIButton *button_1;
- (IBAction)button_1Action:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *button_2;

- (IBAction)button_2Action:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UIButton *button_3;


- (IBAction)button_3Action:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UIButton *button_4;

- (IBAction)button_4Action:(UIButton *)sender;

- (void)showAlertWithMessage:(NSString *)message tag:(NSInteger)tag;

@end
