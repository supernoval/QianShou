//
//  CatchOrderPeoPleListTVC.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/22.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "CatchOrderPeoPleListTVC.h"
#import "CatchPeopleCell.h"

static NSString *cellid = @"catchPeopleCell";


@interface CatchOrderPeoPleListTVC ()<UIAlertViewDelegate>
{
    NSMutableArray *_peopleArray;
    NSInteger pageNum;
    NSInteger pageSize;
    
    UIAlertView *_acceptAlert;
    
}
@end

@implementation CatchOrderPeoPleListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"抢单记录";
    
    _peopleArray = [[NSMutableArray alloc]init];
    
    pageSize = 10;
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
    [self.tableView.header beginRefreshing];
    
    
    
}

-(void)headerRefresh
{
    pageNum = 0;
    
    [self getData];
    
}

-(void)footerRefresh
{
    pageNum ++;
    
    [self getData];
    
}

-(void)getData
{
    
    
    BmobQuery *query = [[BmobQuery alloc]initWithClassName:kOrder];
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    [query whereKey:@"user" equalTo:user];
    
    [query whereKey:@"order_state" equalTo:@(OrderStatePayedUnAccepted)];
    
    [query whereKeySExists:@[@"receive_user"]];
     
    
    [query includeKey:@"receive_user"];
    
    query.limit = pageSize;
    query.skip = pageSize *pageNum;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
        [self endHeaderRefresh ];
        [self endFooterRefresh];
        
        if (pageNum == 0) {
            
            [_peopleArray removeAllObjects];
            
        }
        
        
        if (array.count > 0)
        {
            
            
          
            [_peopleArray addObjectsFromArray:array];

          
            
        }
        
          [self.tableView reloadData];
        
        
        
        
    }];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    
    blankView.backgroundColor = [UIColor clearColor];

    
    return blankView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_peopleArray.count == 0) {
        
        return 1;
        
    }
    
    return _peopleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_peopleArray.count == 0) {
        
        return 44;
        
        }
    BmobObject *object = [_peopleArray objectAtIndex:indexPath.section];
    
    BmobUser *receiveUser = [object objectForKey:@"receive_user"];
    
  
    NSString *descrip = [receiveUser objectForKey:@"user_individuality_signature"];
    
    
    
    CGFloat desHeight = [StringHeight heightWithText:descrip font:FONT_16 constrainedToWidth:ScreenWidth - 100];
    
    
    if (desHeight < 30) {
        
        desHeight = 30;
        
    }
    
    return desHeight + 74;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_peopleArray.count == 0) {
        
        UITableViewCell *blankCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
        
        blankCell.textLabel.text = @"暂无记录";
        
        blankCell.textLabel.textColor = kDarkTintColor;
        blankCell.textLabel.textAlignment = NSTextAlignmentCenter;
        blankCell.textLabel.font = FONT_15;
        
        blankCell.userInteractionEnabled = NO;
        
        return blankCell;
    }
    
    CatchPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    if (indexPath.section < _peopleArray.count) {
        
        BmobObject *object = [_peopleArray objectAtIndex:indexPath.section];
        
        BmobUser *receiveUser = [object objectForKey:@"receive_user"];
        
        NSString *avatar = [receiveUser objectForKey:@"avatar"];
        NSString *nick = [receiveUser objectForKey:@"nick"];
        NSString *descrip = [receiveUser objectForKey:@"user_individuality_signature"];
        
        BmobGeoPoint *point = [receiveUser objectForKey:@"location"];
        
        NSString *distance = [CommonMethods distanceStringWithLatitude:point.latitude longitude:point.longitude];
        
        cell.distanceLabel.text = [NSString stringWithFormat:@"距离:%@",distance];
        
        int i = arc4random()%10;
        
        NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:headString]];
        
        cell.nameLabel.text =nick;
        cell.descriCell.text = [NSString stringWithFormat:@"个人描述:%@",descrip];
        
        CGFloat desHeight = [StringHeight heightWithText:descrip font:FONT_16 constrainedToWidth:ScreenWidth - 100];
        
        if (desHeight < 30) {
            
            desHeight = 30;
            
        }
        cell.desHeightContraints.constant = desHeight;
        
        [cell.accepButton addTarget:self action:@selector(acceptPeople:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
    
    
}

-(void)acceptPeople:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    
    _acceptAlert = [[UIAlertView alloc]initWithTitle:nil message:@"确定接受该抢单人?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"接受", nil];
    _acceptAlert.tag = cell.tag;
    
    [_acceptAlert show];
    
    
    
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView == _acceptAlert && buttonIndex == 1  ) {
        
        BmobObject *orderObject = [_peopleArray objectAtIndex:alertView.tag];
        
         BmobUser *receiveUser = [orderObject objectForKey:@"receive_user"];
        
        [orderObject setObject:@(OrderStateAccepted) forKey:@"order_state"];
        
        [orderObject setObject:receiveUser forKey:@"receive_user"];
        
        
        [orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
          
            
            if (isSuccessful) {
                
                [self.tableView.header beginRefreshing];
                
                [CommonMethods showDefaultErrorString:@"接受成功"];
                
                [CommonMethods sendOrderWithReceiver:receiveUser orderObject:orderObject message:@"您抢的订单已被确认" orderstate:OrderStateAccepted];
                
                
            }
            else
            {
                
                NSLog(@"%@",error);
                
                [CommonMethods showDefaultErrorString:@"接受失败,请重试"];
                
                
            }
            
        }];
        
        
    }
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
