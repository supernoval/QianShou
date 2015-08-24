//
//  MyOrdersTableViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/8.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MyOrdersTableViewController.h"
#import "MyOderCell.h"
#import "OrderDetailTableViewController.h"


static NSString *myOrderCell = @"myOrderCell";

static NSInteger pageSize = 10;


@interface MyOrdersTableViewController ()
{
    NSInteger index;
    
    NSMutableArray *ordersArray ;
    
    
}
@end

@implementation MyOrdersTableViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    ordersArray = [[NSMutableArray alloc]init];
    
    [self addHeaderRefresh];
    
    [self addFooterRefresh];
    
    index = 0;
    
//    [self getOrders];
    
    [self.tableView.header beginRefreshing];
    
    
    
}

-(void)headerRefresh
{
    index = 0;
    [self getOrders];
}

-(void)footerRefresh
{
    index ++;
    [self getOrders];
    
}


-(void)getOrders
{
    BmobQuery *query = [[BmobQuery alloc]initWithClassName:kOrder];
    
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser].objectId];
    
    [query orderByDescending:@"updatedAt"];
    
    query.limit = pageSize;
    query.skip = pageSize *index;

   
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
       
        
        if (index == 0) {
            
            [ordersArray removeAllObjects];
            
            
            
        }
        
        for (int i = 0; i < array.count; i ++) {
            
            BmobObject *orderObject = [array objectAtIndex:i];
            
            YellModel *model = [[YellModel alloc]init];
            
            model.yellObject = orderObject;
            
            [ordersArray addObject:model];
            
            
        }
        
        
           [self getPhotos];
        
   
    
        
        
    }];
    
    
}


-(void)getPhotos
{
    
    __block NSInteger count = 0;
    
    for (int i = 0; i < ordersArray.count; i ++) {
        
        YellModel *oneModel = ordersArray[i];
        
        if (!oneModel.photos)
        {
            BmobQuery *query = [[BmobQuery alloc]initWithClassName:kAttachItem];
            
            [query whereKey:@"order" equalTo:oneModel.yellObject];
            
//            NSLog(@"yellobjectid:%@",oneModel.yellObject.objectId);
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                count ++;
                
                if (array)
                {
                    
                    NSMutableArray *urls = [[NSMutableArray alloc]init];
                    
                    for (int d =0; d < array.count; d++) {
                        
                        BmobObject *attachObject = array[d];
                        
                        SDPhotoItem *it = [[SDPhotoItem alloc]init];
                        it.thumbnail_pic =[attachObject objectForKey:@"attach_url"];
                        
                        [urls addObject:it];
                        
                        
                        
                        
                    }
                    
//                    NSLog(@"photos:%@",array);
                    
                    oneModel.photos = urls;
                    
                    
                    
                }
                
                if (count == ordersArray.count)
                {
                    [self endHeaderRefresh];
                    [self endFooterRefresh];
                    
                    [self.tableView reloadData];
                    
                }
            }];
            
            
            
        }
        else
        {
            count ++;
        }
        
    }
}
#pragma mark - UITabelViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyOderCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCell];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
   
    
    UILabel *timeLabel = (UILabel*)[cell viewWithTag:100];
    UILabel *titlelabel = (UILabel*)[cell viewWithTag:101];
    UILabel *contentlabel = (UILabel*)[cell viewWithTag:102];
    UILabel *benjinLabel = (UILabel *)[cell viewWithTag:103];
    UILabel *tipLabel = (UILabel*)[cell viewWithTag:104];
    UIButton*statusButton = (UIButton *)[cell viewWithTag:105];
    
    
    statusButton.clipsToBounds = YES;
    statusButton.layer.cornerRadius = 15.0;
    
    
    if (indexPath.section < ordersArray.count) {
        
        YellModel *model = [ordersArray objectAtIndex:indexPath.section];
        
        BmobObject *oneObject = model.yellObject;
        
        timeLabel.text = [CommonMethods getYYYYMMddhhmmDateStr:oneObject.createdAt];
        
        
        titlelabel.text = [oneObject objectForKey:@"order_title"];
        
        contentlabel.text = [oneObject objectForKey:@"order_description"];
        
        benjinLabel.text = [NSString stringWithFormat:@"%.2f元",[[oneObject objectForKey:@"order_benjin"]floatValue]];
        
        tipLabel.text = [NSString stringWithFormat:@"%.2f元",[[oneObject objectForKey:@"order_commission"]floatValue]];
        
        
        statusButton.enabled = NO;
        
        cell.contentView.tag = indexPath.section;
        
        [statusButton removeTarget:self
                            action:@selector(payOrder:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        switch ([[oneObject objectForKey:@"order_state"]integerValue]) {
            case OrderStateAcceperCancel:
            {
                [statusButton setTitle:@"已取消" forState:UIControlStateNormal];
                statusButton.backgroundColor = kLightTintColor;
            }
                break;
            case OrderStateAccepted:
            {
                 [statusButton setTitle:@"已接单" forState:UIControlStateNormal];
               statusButton.backgroundColor = kLightTintColor;
                
            }
                break;
            case OrderStateDelete:
            {
                [statusButton setTitle:@"已删除" forState:UIControlStateNormal];
                statusButton.backgroundColor = kLightTintColor;
            }
                break;
            case OrderStateDone:
            {
                 [statusButton setTitle:@"已完成" forState:UIControlStateNormal];
                 statusButton.backgroundColor = kLightTintColor;
            }
                break;
            case OrderStatePayedUnAccepted:
            {
                 [statusButton setTitle:@"待接单" forState:UIControlStateNormal];
                statusButton.backgroundColor = kLightTintColor;
                
            }
                break;
            case OrderStatePublishCancel:
            {
                 [statusButton setTitle:@"已取消" forState:UIControlStateNormal];
                statusButton.backgroundColor = kLightTintColor;
            }
                break;
            case OrderStateUnPay:
            {
                [statusButton setTitle:@"待支付" forState:UIControlStateNormal];
                 statusButton.backgroundColor = kBlueColor;
                
                [statusButton addTarget:self
                                 action:@selector(payOrder:)
                       forControlEvents:UIControlEventTouchUpInside];
                
                
                statusButton.enabled =YES;
                
            }
                break;
                
            default:
            {
                
            }
                break;
         }
        
        
        
        //图片
        if (model.photos) {
            
            cell.photoView.photoItemArray = model.photos;
            
            CGFloat photoViewHeight = 0;
            
            
            YellModel *weiboModel = [ordersArray objectAtIndex:indexPath.section];
            NSArray *imgs = weiboModel.photos;
            
            long imageCount = imgs.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF);
            
            photoViewHeight = 95 * totalRowCount;
            
            cell.photoViewHeightContraint.constant = photoViewHeight;
            
        }
        else
        {
            cell.photoViewHeightContraint.constant = 0;
            
        }
        
        
        
        //内容
        
        double textHeight = 20;
        
        NSString *text = [model.yellObject objectForKey:@"content"];
        
        textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth];
        
        if (textHeight < 20) {
            
            textHeight = 20;
            
        }
        cell.descripHeightConstraint.constant = textHeight;
        
        
        
    }
    
         });
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat photoViewHeight = 0;
    
    CGFloat textHeight = 0;
    
    if (ordersArray.count > 0) {
        
        YellModel *weiboModel = [ordersArray objectAtIndex:indexPath.section];
        NSArray *imgs = weiboModel.photos;
        
        long imageCount = imgs.count;
        int perRowImageCount = ((imageCount == 4) ? 2 : 3);
        CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
        int totalRowCount = ceil(imageCount / perRowImageCountF);
        
        photoViewHeight = 95 * totalRowCount;
        
        
        
        NSString *text = [weiboModel.yellObject objectForKey:@"content"];
        
        textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth];
        
        if (textHeight < 20)
        {
            
            textHeight = 20;
            
            
        }
    }
    
    
    
    return 120 + photoViewHeight + textHeight;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ordersArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    
    blankView.backgroundColor = [UIColor clearColor];
    
    
    return blankView;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    OrderDetailTableViewController *detatilTVC = [sb instantiateViewControllerWithIdentifier:@"OrderDetailTableViewController"];
    
    detatilTVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detatilTVC animated:YES];
    
    
  
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)payOrder:(UIButton*)sender
{
    
    //先获取明细
    MyOderCell *cell = (MyOderCell*)[sender superview];
    
    YellModel *oneModel = [ordersArray objectAtIndex:cell.tag];
    
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    
    [query whereKey:@"order" equalTo:oneModel.yellObject];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
      
        if (array.count ==1) {
            
            BmobObject *detailObject = [array firstObject];
            
            [self payOrder:oneModel.yellObject detailObject:detailObject];
            
        }
        
        
    }];
    
}

#pragma mark - 支付
-(void)payOrder:(BmobObject*)orderObject detailObject:(BmobObject*)detailObject
{
    
    
    /*生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc]init];
    
    order.partner = kAliPayPartnerID;
    order.seller = kAliPaySellerID;
    
    
    order.tradeNO = [NSString stringWithFormat:@"%@/%@",orderObject.objectId,detailObject.objectId]; //订单ID（由商家自行制定）
    
    order.productName = [orderObject objectForKey:@"order_title"]; //商品标题
    
    order.productDescription = [orderObject objectForKey:@"order_title"];; //商品描述
    
    order.amount = [NSString stringWithFormat:@"%.2f",[[orderObject objectForKey:@"order_commission"]floatValue] + [[orderObject objectForKey:@"order_benjin"]floatValue] ]; //商品价格
    
    order.notifyURL =  kAliPaySellerID; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = kURLSheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(kAliPayPrivateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"%s,reslut = %@",__func__,resultDic);
            
            
            
            NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"]integerValue];
            if (resultStatus == 9000) {
                
                
                [orderObject setObject:@(OrderStatePayedUnAccepted) forKey:@"order_state"];
                [orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    
                    [MyProgressHUD dismiss];
                    
                    if (isSuccessful)
                    {
                        
                        [self headerRefresh];
                        
                      UIAlertView *  _sucessPayAlert = [[UIAlertView alloc]initWithTitle:nil message:@"支付成功，订单发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
                        
                        [_sucessPayAlert show];
                        
                    }
                    else
                    {
                        
                    }
                    
                }];
                
                
                
                
                
                
            }
            else
            {
                
                [MyProgressHUD dismiss];
                
                NSString *memo = [resultDic objectForKey:@"memo"];
                if (memo.length == 0) {
                    
                    memo = @"支付失败";
                }
                
                
               UIAlertView* _failPayAlert = [[UIAlertView alloc]initWithTitle:nil message:memo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [_failPayAlert show];
                
                
                
                
                //
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
