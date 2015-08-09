//
//  DarenTableViewController.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/8.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "BaseTableViewController.h"

@interface DarenTableViewController : BaseTableViewController

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITextField *carrierT;
@property (weak, nonatomic) IBOutlet UITableViewCell *photosCell;


@property (weak, nonatomic) IBOutlet UITextField *goodAtTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UIButton *darenButton;

- (IBAction)publishDarenAtion:(id)sender;
@end
