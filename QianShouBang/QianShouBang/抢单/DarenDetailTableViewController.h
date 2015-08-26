//
//  DarenDetailTableViewController.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/26.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface DarenDetailTableViewController : BaseTableViewController

@property (nonatomic) BmobObject *darenObject;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UIButton *callButton;

@property (weak, nonatomic) IBOutlet UIButton *sendMessageButtno;

@property (weak, nonatomic) IBOutlet UIButton *zixunButton;

- (IBAction)callAction:(id)sender;
- (IBAction)sendMessageAction:(id)sender;
- (IBAction)zixunAction:(id)sender;

@end
