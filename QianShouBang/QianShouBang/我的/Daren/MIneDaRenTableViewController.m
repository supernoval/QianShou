//
//  MIneDaRenTableViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/25.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MIneDaRenTableViewController.h"
#import "MineDarenCell.h"

static NSString *const cellid = @"darencell";

@interface MIneDaRenTableViewController ()<UIAlertViewDelegate>
{
    BmobUser *_currentUser;
    
    BmobObject *_darenObject;
    
    UIAlertView *_sureAlertView;
    
    UIAlertView *_sucessAlertView;
    
    
    
}
@end

@implementation MIneDaRenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的达人";
    
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 125);
    _headerView.hidden = YES;
    
    _footerView.frame = CGRectMake(0, 0, ScreenWidth, 122);
    _footerView.hidden = YES;
    
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 30;
    
    _xiajiaButton.clipsToBounds = YES;
    _xiajiaButton.layer.cornerRadius = 23.0;
    
    _currentUser = [BmobUser getCurrentUser];
    
    [self setSubViews];
    
    [self getdata];
    
}

-(void)setSubViews
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_currentUser objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"head_default_0"]];
    
    BOOL isMale = [[_currentUser objectForKey:@"user_sex"]boolValue];
    
    
    if (!isMale) {
        
        _sexImage.image = [UIImage imageNamed:@"female"];
        
    }
    
    NSString *nick = [_currentUser objectForKey:@"nick"];
    
    if (nick) {
     
        _nickNameLabel.text = nick;
        
     
    }
    
    _phoneLabel.text = _currentUser.username;
    
    

    
}

-(void)getdata
{
    
    BmobQuery *query = [BmobQuery queryWithClassName:kOrder];
    
    [query whereKey:@"order_type" equalTo:@(100)];
    [query whereKey:@"user" equalTo:_currentUser];
    [query whereKey:@"order_state" equalTo:@(1)];
    
    [MyProgressHUD showProgress];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        [MyProgressHUD dismiss];
        
        
        if (array.count > 0) {
            
            
            _darenObject = [array firstObject];
            
            _footerView.hidden = NO;
            _headerView.hidden = NO;
            
//            _headerView.frame = CGRectMake(0, 0, ScreenWidth, 125);
            
          
            
            
        }
        
        
        
        [self.tableView reloadData];
        
        
    }];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        
        NSString *content = [_darenObject objectForKey:@"order_description"];
        
        CGFloat textHeight = [StringHeight heightWithText:content font:FONT_16 constrainedToWidth:ScreenWidth - 200];
        if (textHeight < 44) {
          
            textHeight = 44;
            
        }
        return textHeight;
    }
    
    return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_darenObject) {
        
        return 4;
    }
    
    return 1;
    
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_darenObject) {
        
        UITableViewCell *blankCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
        
        blankCell.textLabel.text = @"暂无达人信息";
        
        blankCell.textLabel.textColor = kDarkTintColor;
        
        blankCell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        blankCell.userInteractionEnabled = NO;
        
        
        return blankCell;
        
        
        
    }
    
    
    MineDarenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    NSString *content = nil;
    NSString *title = nil;
    
    UIColor *contentColor = kDarkTintColor;
    
    
    switch (indexPath.row) {
        case 0:
        {
            title = @"发布日期:";
            content = [CommonMethods getYYYYMMddHHmmssDateStr:_darenObject.createdAt];
            contentColor = kDarkTintColor;
        }
            break;
        case 1:
        {
            title = @"职    业:";
            content = [_darenObject objectForKey:@"order_title"];
            contentColor = kDarkTintColor;
        }
            break;
        case 2:
        {
            title = @"内    容:";
            content = [_darenObject objectForKey:@"order_description"];
            contentColor = kDarkTintColor;
            
        }
            break;
        case 3:
        {
            title = @"保证金:";
            CGFloat benjin = [[_darenObject objectForKey:@"order_benjin"]floatValue];
            
            content = [NSString stringWithFormat:@"%.1f元",benjin];
            contentColor = [UIColor redColor];
            
        }
            
        default:
            break;
    }
    
    
    cell.contentLabel.text = content;
    
    cell.dateLabel.text = title;
    
    cell.contentLabel.textColor = contentColor;
    
    
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

- (IBAction)xiajiaAction:(id)sender {
    
    _sureAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定下架达人吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [_sureAlertView show];
    
    
    
}

-(void)cancelDaren
{
    [_darenObject setObject:[BmobUser getCurrentUser] forKey:@"user"];
    [_darenObject setObject:@(OrderStatePublishCancel) forKey:@"order_state"];
    
    [MyProgressHUD showProgress];
    
    [_darenObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
           
            

            [CommonMethods updateDetailAccountWithType:DetailAccountTypeReturn_money Order:_darenObject User:[BmobUser getCurrentUser] money:0 qianshoubi:0 withResultBlock:^(BOOL success, BmobObject *detailObject) {
                
                [MyProgressHUD dismiss];
                
                if (success) {
                    _sucessAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"下架成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [_sucessAlertView show];
                }
                else
                {
                      [MyProgressHUD dismiss];
                      [CommonMethods showDefaultErrorString:@"下架失败"];
                    
                }
                
            }];
            
           
            
            
        }
        else
        {
              [MyProgressHUD dismiss];
            [CommonMethods showDefaultErrorString:@"下架失败"];
            
        }
        
    }];
}


#pragma mark - 保存明细
-(void)saveDetailAccount:(BmobObject*)orderObject
{
    BmobUser *user = [BmobUser getCurrentUser];
    
    double jiangli = [[orderObject objectForKey:@"jiangli_money"]doubleValue];
    double benjin = [[orderObject objectForKey:@"order_benjin"]doubleValue];
    double commision = [[orderObject objectForKey:@"order_commission"]doubleValue];
    
    
    BmobObject *detailObject = [BmobObject objectWithClassName:kDetailAccount];
    
    
    [detailObject setObject:user forKey:@"user"];
    [detailObject setObject:orderObject forKey:@"order"];
    
    [detailObject setObject:@NO forKey:@"expenditure"];
    [detailObject setObject:@NO forKey:@"monthly_bonus_points"];
    [detailObject setObject:@NO forKey:@"open_vip_error"];
    [detailObject setObject:@NO forKey:@"receive_order_jl"];
    [detailObject setObject:@NO forKey:@"recharge"];
    [detailObject setObject:@NO forKey:@"release_order_jl"];
    [detailObject setObject:@NO forKey:@"return_money"];
    [detailObject setObject:@NO forKey:@"cash_error"];
    [detailObject setObject:@NO forKey:@"cash"];
    [detailObject setObject:@NO forKey:@"failure_pay"];
    [detailObject setObject:@NO forKey:@"income"];
    [detailObject setObject:@YES forKey:@"isAccountAmountType"];
    [detailObject setObject:@NO forKey:@"pay_error"];
    [detailObject setObject:@NO forKey:@"return_bzj"];
    [detailObject setObject:@YES forKey:@"is_master_order"];

    [detailObject setObject:@NO forKey:@"OpenMaster"];
    
    
    [detailObject setObject:@(jiangli) forKey:@"tIntegralCount"];
    
    [detailObject setObject:@(benjin) forKey:@"tMoneyCount"];
    
    [detailObject setObject:@NO forKey:@"vip"];
    
    [detailObject setObject:@(commision) forKey:@"tIntegral"];
    
    [detailObject setObject:@(benjin) forKey:@"tMoney"];
    
    [detailObject setObject:@(jiangli) forKey:@"tJiangli"];
    
    
    
    
    [detailObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        
        if (isSuccessful) {
            
        
            
        }
        else
        {
            
            [MyProgressHUD dismiss];
            
            
            NSLog(@"%s,error:%@",__func__,error);
            
            
            
        }
        
    }];
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _sureAlertView && buttonIndex == 1) {
        
        [self cancelDaren];
        
    }
    
    if (alertView == _sucessAlertView) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}

@end
