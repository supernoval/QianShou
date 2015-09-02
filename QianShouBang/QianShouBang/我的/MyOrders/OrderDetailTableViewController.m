//
//  OrderDetailTableViewController.m
//  QianShouBang
//
//  Created by 123456 on 15/8/24.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "OrderDetailTableViewController.h"
#import "OrderDetailCel.h"
#import "LocationViewController.h"
static NSString *cellID = @"contentCell";


@interface OrderDetailTableViewController ()<UIAlertViewDelegate>
{
    
    UIAlertView *doneAlert;
    
    UIAlertView *cancelAlert;
    
}
@end

@implementation OrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"任务进行中";
    
    
    NSInteger order_state = [[_orderObject objectForKey:@"order_state"]integerValue];
    
    if (order_state == OrderStateDone)
    {
        
        self.title = @"已完成";
        
        _stateLabel.text = @"已完成";
        
    }
    
    if (order_state == OrderStatePublishCancel || order_state == OrderStateAcceperCancel) {
        
        self.title = @"已取消";
    }
    
    [self setUpSubViews];
    
}

-(void)setUpSubViews
{
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 139);
    
    _footerView.frame = CGRectMake(0, 0, ScreenWidth, 269);
    
//    BmobUser *publisher = [_orderObject objectForKey:@"user"];
    BmobUser *publisher =[BmobUser getCurrentUser];
    
    NSString *avatar = [publisher objectForKey:@"avatar"];
    
    NSString *nick = [publisher objectForKey:@"nick"];
    
    BmobGeoPoint *frompoint = [publisher objectForKey:@"location"];
    CLLocationCoordinate2D coordOne = CLLocationCoordinate2DMake(frompoint.latitude, frompoint.longitude);
    
    
    BmobUser *accepUser = [_orderObject objectForKey:@"receive_user"];
    
    NSString *receive_avatar = [accepUser objectForKey:@"avatar"];
    NSString *receive_nick = [accepUser objectForKey:@"nick"];
    BmobGeoPoint *receive_location = [accepUser objectForKey:@"location"];
    CLLocationCoordinate2D coordTwo = CLLocationCoordinate2DMake(receive_location.latitude, receive_location.longitude);
    
    _publisherHeadImage.clipsToBounds = YES;
    _publisherHeadImage.layer.cornerRadius = 30.0;
    
    [_publisherHeadImage sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"head_default_1"]];
    
    [_catchPeopleHeadImage sd_setImageWithURL:[NSURL URLWithString:receive_avatar] placeholderImage: [UIImage imageNamed:@"head_default_2"]];
    _catchPeopleHeadImage.clipsToBounds = YES;
    _catchPeopleHeadImage.layer.cornerRadius = 30.0;
    
    _publishNick.text = nick;
    
    _catchPeopleNick.text = receive_nick;
    
    
    
    double dis = [CommonMethods distanceBetweenLocation:coordOne andLocation:coordTwo];
    
    
    if (dis < 1000) {
        
        _distanceLabel.text = [NSString stringWithFormat:@"距离:%.0fm",dis];
    }
    else
    {
        _distanceLabel.text = [NSString stringWithFormat:@"距离:%.2fKM",dis/1000.0];
        
    }
    
    
    NSInteger order_state = [[_orderObject objectForKey:@"order_state"]integerValue];
    
    if (order_state != 2)
    {
        
        _footerView.hidden = YES;
        
        _cancelButton.hidden = YES;
        _doneButton.hidden = YES;
        
        
    }
    else
    {
        _showLocationButton.clipsToBounds = YES;
        _showLocationButton.layer.cornerRadius = 5.0;
        
        _doneButton.clipsToBounds = YES;
        _doneButton.layer.cornerRadius = 5.0;
        
        _cancelButton.clipsToBounds = YES;
        _cancelButton.layer.cornerRadius = 5.0;
        
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = nil;
    
    switch (indexPath.row) {
        case 0:
        {
          
            
            content = [_orderObject objectForKey:@"order_title"];
            
            
            
        }
            break;
        case 1:
        {
           
            
            content =  [_orderObject objectForKey:@"order_description"];
          
            
        }
            break;
        case 2:
        {
         
            
            content   = [_orderObject objectForKey:@"order_address"];
            
         
            
        }
            break;
        case 3:
        {
          
            
            CGFloat tip = [[_orderObject objectForKey:@"order_commission"]floatValue];
            
            content = [NSString stringWithFormat:@"%.1f元",tip];
            
          
            
        }
            break;
        case 4:
        {
           
            CGFloat benjin = [[_orderObject objectForKey:@"order_benjin"]floatValue];
            
            content = [NSString stringWithFormat:@"%.1f元",benjin];
            
     
            
        }
            break;
        case 5:
        {
         
            CGFloat jiangli_money = [[_orderObject objectForKey:@"jiangli_money"]floatValue];
            
            content =  [NSString stringWithFormat:@"%.2f牵手币",jiangli_money];
            
         
            
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    CGFloat height = [StringHeight heightWithText:content font:FONT_16 constrainedToWidth:ScreenWidth - 150];
    
    if (height < 44) {
        
        height = 44;
    }
    
    return height;
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
        
    return 6;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailCel *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.userInteractionEnabled = NO;
    
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"订单标题";
            cell.titleWithContraints.constant = 80;

            cell.contentLabel.text = [_orderObject objectForKey:@"order_title"];
            
            cell.contentLabel.textColor = [UIColor darkGrayColor];

        }
            break;
        case 1:
        {
            cell.titleLabel.text =@"订单内容";
            cell.titleWithContraints.constant = 80;

            cell.contentLabel.text = [_orderObject objectForKey:@"order_description"];
            cell.contentLabel.textColor = [UIColor darkGrayColor];

        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"送货地址";
            cell.titleWithContraints.constant = 80;

            cell.contentLabel.text = [_orderObject objectForKey:@"order_address"];
            
            cell.contentLabel.textColor = [UIColor darkGrayColor];

        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"服务小费";
            cell.titleWithContraints.constant = 80;

            CGFloat tip = [[_orderObject objectForKey:@"order_commission"]floatValue];
            
            cell.contentLabel.text = [NSString stringWithFormat:@"%.1f元",tip];
            
            cell.contentLabel.textColor = [UIColor darkGrayColor];

        }
            break;
        case 4:
        {
            cell.titleLabel.text = @"服务本金";
            cell.titleWithContraints.constant = 80;
            CGFloat benjin = [[_orderObject objectForKey:@"order_benjin"]floatValue];
            
            cell.contentLabel.text = [NSString stringWithFormat:@"%.1f元",benjin];
            
            cell.contentLabel.textColor = [UIColor darkGrayColor];
            
        }
            break;
        case 5:
        {
            cell.titleLabel.text = @"系统奖励给您(发单)";
            cell.titleWithContraints.constant = 150;
            CGFloat jiangli_money = [[_orderObject objectForKey:@"jiangli_money"]floatValue];
            
            cell.contentLabel.text = [NSString stringWithFormat:@"%.2f牵手币",jiangli_money];
            
            cell.contentLabel.textColor = [UIColor redColor];
            
            
            
        }
            break;
            
            
        default:
            break;
    }
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
    
     BmobUser *accepUser = [_orderObject objectForKey:@"receive_user"];
    
    NSString *phone = accepUser.username;
    
    [CommonMethods callPhoneWithSuperView:self.view phoneNum:phone];
    
}

- (IBAction)sendMessage:(id)sender {
    
    BmobUser *accepUser = [_orderObject objectForKey:@"receive_user"];
    
    NSString *phone = accepUser.username;
    
    [CommonMethods sendMessageWithSuperView:self.view phoneNum:phone];
}

- (IBAction)showLocation:(id)sender {
    
  
    BmobGeoPoint *point = [_orderObject objectForKey:@"location"];
    
    LocationViewController *locVC = [[LocationViewController alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
    locVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:locVC animated:YES];
    
}

- (IBAction)doneAction:(id)sender {
    
    
    doneAlert = [[UIAlertView alloc]initWithTitle:nil message:@"确定完成服务吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [doneAlert show];
    
    
    
}



- (IBAction)cancelAction:(id)sender {
    
    cancelAlert = [[UIAlertView alloc]initWithTitle:nil message:@"确定取消订单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [cancelAlert show];
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView == doneAlert && buttonIndex == 1) {
        
        [self updateOrderWithState:OrderStateDone];
        
        
    }
    
    if (alertView == cancelAlert && buttonIndex == 1) {
        
        [self updateOrderWithState:OrderStatePublishCancel];
        
    }
    
}

-(void)updateOrderWithState:(OrderState)state
{
    BmobUser *user = [BmobUser getCurrentUser];
     BmobUser *accepUser = [_orderObject objectForKey:@"receive_user"];
    [_orderObject setObject:user forKey:@"user"];
    [_orderObject setObject:accepUser forKey:@"receive_user"];
    
    [_orderObject setObject:@(state) forKey:@"order_state"];
    
    [MyProgressHUD showProgress];
    
    [_orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
    
        if (isSuccessful)
        {
            
            //发送推送
            
            if (state == OrderStateDone) {
                
               [CommonMethods sendOrderWithReceiver:accepUser orderObject:_orderObject message:@"您抢的订单已完成" orderstate:OrderStateDone];
            }
            else
            {
                [CommonMethods sendOrderWithReceiver:accepUser orderObject:_orderObject message:@"您抢的订单已被取消" orderstate:OrderStateDone];
            }
           
            
            //更新明细表
            [self updateDetailAccountWithOrderState:OrderStateDone];
            
        }
        else
        {
            NSLog(@"error:%@",error);
            
            [CommonMethods showDefaultErrorString:@"确实失败，请重试"];
            
            [MyProgressHUD dismiss];
            
        }
        
    }];
}

-(void)updateDetailAccountWithOrderState:(OrderState)state
{
    
    CGFloat benjin = [[_orderObject objectForKey:@"order_benjin"]floatValue];
    
    CGFloat commission = [[_orderObject objectForKey:@"order_commission"]floatValue];
    

    //先获取明细
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    
    [query orderByDescending:@"updatedAt"];

    
   [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
       CGFloat tIntegral = 0;
       
       CGFloat tMoney = 0;
       
       CGFloat tJiangli = 0;
       
       if (array.count > 0) {
           
        BmobObject *firstDetail = [array firstObject];
           
        tIntegral = [[firstDetail objectForKey:@"tIntegralCount"]floatValue];
        tMoney = [[firstDetail objectForKey:@"tMoneyCount"]floatValue];
        tJiangli = [[firstDetail objectForKey:@"tJiangli"]floatValue];
        
        
           
       }
       
       if (state == OrderStatePublishCancel) {
           
           tIntegral += commission;
           
           tMoney += benjin;
           
       }
       
       
       
       
   }];
    
    
    [MyProgressHUD dismiss];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
