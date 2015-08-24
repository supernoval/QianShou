//
//  OrderDetailTableViewController.m
//  QianShouBang
//
//  Created by 123456 on 15/8/24.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "OrderDetailTableViewController.h"
#import "OrderDetailCel.h"

static NSString *cellID = @"contentCell";


@interface OrderDetailTableViewController ()

@end

@implementation OrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"任务进行中";
    
    [self setUpSubViews];
    
}

-(void)setUpSubViews
{
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 139);
    
    _footerView.frame = CGRectMake(0, 0, ScreenWidth, 269);
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailCel *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)callPhone:(id)sender {
}

- (IBAction)sendMessage:(id)sender {
}

- (IBAction)showLocation:(id)sender {
}
- (IBAction)cancelAction:(id)sender {
}
@end
