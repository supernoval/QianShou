//
//  MessageDetailTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/11.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MessageDetailTVC.h"
#import "StringHeight.h"

@interface MessageDetailTVC ()
@property (strong, nonatomic) IBOutlet UILabel *messageTitle;
@property (strong, nonatomic) IBOutlet UITextView *messageContent;
@property (strong, nonatomic) IBOutlet UILabel *messageTime;

@end

@implementation MessageDetailTVC
@synthesize messageObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.messageContent.selectable = NO;
    self.messageTitle.text = [messageObj objectForKey:ksystem_msg_title];
    self.messageContent.text = [messageObj objectForKey:ksystem_msg_content];
    NSString *time = [NSString stringWithFormat:@"%@",messageObj.updatedAt];
    
    self.messageTime.text = [time substringToIndex:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [StringHeight heightWithText:[messageObj objectForKey:ksystem_msg_title] font:FONT_16 constrainedToWidth:ScreenWidth-16]+20;
    }else if (indexPath.row == 1) {
        return [StringHeight heightWithText:[messageObj objectForKey:ksystem_msg_content] font:FONT_14 constrainedToWidth:ScreenWidth-16]+100;
    }
    return 40;
}

@end
