//
//  MineTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MineTableViewController.h"
#import "SendNeedTableViewController.h"

@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"订单管理";
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0: //发布需求
                {
                    SendNeedTableViewController *sendTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SendNeedTableViewController"];
                    
                    [self.navigationController pushViewController:sendTVC animated:YES];
                    
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

@end
