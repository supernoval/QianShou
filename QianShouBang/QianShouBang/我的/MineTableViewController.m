//
//  MineTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MineTableViewController.h"
#import "SendNeedTableViewController.h"
#import "DarenTableViewController.h"
#import "MyOrdersTableViewController.h"
#import "TheCompletedOrderTVC.h"
#import "TheAcceptedOrderTVC.h"
#import "CatchOrderPeoPleListTVC.h"


@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单管理";
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0: //发布需求
                {
                    SendNeedTableViewController *sendTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SendNeedTableViewController"];
                    sendTVC.hidesBottomBarWhenPushed =YES;
                    
                    [self.navigationController pushViewController:sendTVC animated:YES];
                    
                }
                    break;
                case 1:  //发布达人
                {
                    DarenTableViewController *darenTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DarenTableViewController"];
                    darenTVC.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:darenTVC animated:YES];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0: //我的订单
                {
                    MyOrdersTableViewController *myOrderTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyOrdersTableViewController"];
                    myOrderTVC.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:myOrderTVC animated:YES];
                    
                }
                    break;
                case 1:  //我的达人
                {
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0: //已接订单
                {
                    TheAcceptedOrderTVC *theAcceptOrder = [sb instantiateViewControllerWithIdentifier:@"TheAcceptedOrderTVC"];
                    theAcceptOrder.hidesBottomBarWhenPushed =YES;
                    
                    [self.navigationController pushViewController:theAcceptOrder animated:YES];
                    
                    
                    
                }
                    break;
                case 1:  //已完成订单
                {
                    TheCompletedOrderTVC *theCompletedOrder = [sb instantiateViewControllerWithIdentifier:@"TheCompletedOrderTVC"];
                    theCompletedOrder.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:theCompletedOrder animated:YES];
                    
                }
                    break;
                    
                case 2:  //抢单人列表
                {
                    CatchOrderPeoPleListTVC *_catchPeople = [self.storyboard instantiateViewControllerWithIdentifier:@"CatchOrderPeoPleListTVC"];
                    
                    _catchPeople.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:_catchPeople animated:YES];
                    
                }
                    break;
                    
                    
                default:
                    break;
            }

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



@end
