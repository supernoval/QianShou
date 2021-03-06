//
//  SendNeedTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "SendNeedTableViewController.h"
#import "RewardLimitationModel.h"
#import <BmobSDK/BmobProFile.h>
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


static NSString *needCell = @"needCell";
static NSString *imagesCell = @"imagesCell";
static NSString *benjinCell = @"benjinCell";
static NSString *tipsCell = @"tipsCell";

static CGFloat imagesCellHeight = 70.0;



@interface SendNeedTableViewController ()<UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    RewardLimitationModel *rewardModel;
    
    
    UIActionSheet *_pickPhotoActionSheet;
    
    NSMutableArray *_PhotosArray;
    
    UIView *imagesView; //用于放图片
    
    Order *_order; //支付model
    
    NSString *_address;
    
    double _latitude;
    double _longitude;
    
    UIAlertView *_sucessPayAlert;
    
    UIAlertView *_failPayAlert;
    
    
    
}
@end

@implementation SendNeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _PhotosArray  = [[NSMutableArray alloc]init];
    
    _footerView.frame = CGRectMake(0, 0, ScreenWidth, 150);
    _publishButton.clipsToBounds = YES;
    _publishButton.layer.cornerRadius = 10;
    
    [self getRewardLimitation];
    
    
    
    _pickPhotoActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"相册图片描述"];
    [_pickPhotoActionSheet addButtonWithTitle:@"手机拍照描述"];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"取消"];
    
    _pickPhotoActionSheet.cancelButtonIndex = 2;
    
    
    [self initImagesView];
    
    _address = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAddress];
    _longitude = [[NSUserDefaults standardUserDefaults ] floatForKey:kGPSLoactionLongitude];
    _latitude = [[NSUserDefaults standardUserDefaults ] floatForKey:kGPSLocationLatitude];
    
    
  

    
    
    
    
}

-(void)initImagesView
{
    imagesView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, imagesCellHeight)];
    [_imagesViewCell.contentView addSubview:imagesView];
    
    [self setPhotos];
    
    
    
    
}

#pragma mark - UITableViewDataSource
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    switch (indexPath.section) {
//        case 0:
//        {
//            if (indexPath.row == 0) {
//
//                return 81;
//            }
//
//            if (indexPath.row == 1) {
//
//                return 70;
//            }
//        }
//            break;
//        case 1:
//        {
//            return 99;
//        }
//            break;
//        case 2:
//        {
//            return 99;
//        }
//
//            break;
//
//        default:
//        {
//            return 44;
//
//        }
//            break;
//    }
//
//    return 44
//    ;
//
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 3;
//
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//        {
//            return 2;
//        }
//            break;
//
//        default:
//        {
//            return 1;
//
//        }
//            break;
//    }
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell;
//
//    switch (indexPath.section) {
//        case 0:
//        {
//            if (indexPath.row == 0)
//            {
//
//                SendNeedCell * needcell = [tableView dequeueReusableCellWithIdentifier:needCell];
//
//                needcell.needTF.delegate = self;
//
//
//                return needcell;
//
//
//            }
//            if (indexPath.row == 1) {
//
//                cell = [tableView dequeueReusableCellWithIdentifier:imagesCell];
//
//            }
//        }
//            break;
//        case 1:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:benjinCell];
//
//            UITextField *tf = (UITextField*)[cell viewWithTag:100];
//
//            tf.text = @"atagag";
//
//        }
//            break;
//        case 2:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:tipsCell];
//
//        }
//            break;
//
//
//        default:
//            break;
//    }
//
//    return cell;
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark -  UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    //    [self.tableView reloadData];
    
}

#pragma mark - 提交订单第一步 保存图片  
- (IBAction)publishAction:(id)sender {
    
    
    NSString *desc = _needTF.text;
    
    if (desc.length == 0)
    {
        
        [MyProgressHUD showError:@"请填写订单需求"];
        
        
        return;
    }
    
    if (desc.length > 200) {
        
        [MyProgressHUD showError:@"需求描述不得超过200字"];
        
        return;
    }
    
    CGFloat xiaofei = [_xiaofeiTF.text floatValue];
    
    if (xiaofei ==0)
    {
        
        [MyProgressHUD showError:@"小费金额必须大于1"];
        
        return;
        
    }
    
    if (_address.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"定位失败，请在 设置－隐私－定位服务 里开启对《牵手邦》的定位允许"];
        
        return;
        
    }
    
    
    
    //如果有图片 先上传图片
    
    
    if (_PhotosArray.count > 0) {
        
          [MyProgressHUD showProgress];
        
        [CommonMethods upLoadPhotos:_PhotosArray resultBlock:^(BOOL success, NSArray *results) {
          
            if (!success)
            {
                
           
                
                NSLog(@"图片上传失败");
                
                [CommonMethods showDefaultErrorString:@"图片上传失败，请重新上传"];
                
            }else
            {
                
                NSLog(@"filename:%@ ",results);
                
                
                [self setjiangliMoney:results];
                
            }
            
        }];
        
      
        
        
        
        
        
     }
    else //没有图片直接上传
    {
        [self setjiangliMoney:nil];
    }
    
}

-(NSString *)getImageName:(NSInteger)tag
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *imageName  = [NSString stringWithFormat:@"%@%ld",dateStr,(long)tag];
    
    
    return imageName;
    
    
}



#pragma mark - 先设置奖励

-(void)setjiangliMoney:(NSArray*)picFilesObjects
{
    
  
     CGFloat xiaofei = [_xiaofeiTF.text floatValue];
    
    if (rewardModel.b_SenderAward) {
        
      
        
        
        BmobQuery *query = [[BmobQuery alloc]initWithClassName:kOrder];
        
        [query whereKey:@"order_state" notContainedIn:@[@(3),@(6),@(10)]];
        
//        [query whereKey:@"order_state" notContainedIn:@[@(3),@(6),@(10)]];
        
        [query setLimit:3];
        
        [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            
              CGFloat jiangli = 0;
            
            NSLog(@"queryOrderCount:%ld",(long)array.count);
            
            if (array.count < 3)
            {
                  jiangli = xiaofei * rewardModel.d_SenderAwardRatio;
                
            }
            else
            {
                
               
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //设置时区
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
                //时间格式
                [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
                //调用获取服务器时间接口，返回的是时间戳
                NSString  *timeString = [Bmob getServerTimestamp];
                //时间戳转化成时间
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString intValue]];
                
                NSString *dateStr = [CommonMethods getYYYYMMddFromDefaultDateStr:date];
                
                NSDate * serviceDate = [CommonMethods  getYYYMMddFromString:dateStr];
                
                
                BOOL moreThanThree = YES;
                
                for (int i = 0; i < array.count; i ++)
                {
                    
                    BmobObject *orderOB = array[i];
                    
                    NSString *creatTime = [CommonMethods getYYYYMMddFromDefaultDateStr:orderOB.createdAt];
                    
                    NSDate *createDate = [CommonMethods getYYYMMddFromString:creatTime];
                    
                    
                    //三个当中只要有一个不相等，就表示没超过
                    if (![serviceDate isEqualToDate:createDate])
                    {
                        
                        moreThanThree = NO;
                    }
                }
                
                
                if (moreThanThree)
                {
                    
                       jiangli = xiaofei * 0.1;
                }
                else
                {
                       jiangli = xiaofei * rewardModel.d_SenderAwardRatio;
                }
                
              
            }
            
            
            [self summitWithAttachObject:picFilesObjects jiangli:jiangli];
            
        }];
        
        
     }
    else
    {
        [self summitWithAttachObject:picFilesObjects jiangli:0];
        
        
        
    }
    

    
    
    
    
    
    
    
    
    
}

-(void)summitWithAttachObject:(NSArray*)attachObjects jiangli:(CGFloat)jiangli
{
    
    NSString *desc = _needTF.text;
    
    if (desc.length == 0)
    {
        
        [MyProgressHUD showError:@"请填写订单需求"];
        
        
        return;
    }
    
    if (desc.length > 200) {
        
        [MyProgressHUD showError:@"需求描述不得超过200字"];
        
        return;
    }
    
    CGFloat xiaofei = [_xiaofeiTF.text floatValue];
    
    if (xiaofei == 0) {
        
        [MyProgressHUD showError:@"小费金额不能为0"];
        
        return;
        
    }
    
    if (_address.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"定位失败，请在 设置－隐私－定位服务 里开启对《牵手邦》的定位允许"];
        
        return;
        
    }
    
    CGFloat benjin = [_benjinTF.text floatValue];
    
    benjin = [CommonMethods getTwopoint:benjin];
    xiaofei = [CommonMethods getTwopoint:xiaofei];
    jiangli = [CommonMethods getTwopoint:jiangli];
    
   
    
    
    BmobObject *orderObject = [BmobObject objectWithClassName:kOrder];
    
    [orderObject setObject:desc forKey:@"order_title"];
    [orderObject setObject:desc forKey:@"order_description"];
    [orderObject setObject:@(0) forKey:@"order_type"];
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    //                                QSUser *myUser = [[QSUser alloc]initFromBmobOjbect:user];
    
    [orderObject setObject:user forKey:@"user"];
    
    BmobGeoPoint *location = [[BmobGeoPoint alloc]initWithLongitude:_longitude WithLatitude:_latitude];
    
    [orderObject setObject:location forKey:@"location"];
    
    [orderObject setObject:_address forKey:@"order_address"];
    
    [orderObject setObject:@(benjin) forKey:@"order_benjin"];
    
    [orderObject setObject:@(jiangli) forKey:@"jiangli_money"];
    
    [orderObject setObject:user.username forKey:@"order_phone"];
    
    [orderObject setObject:@(xiaofei) forKey:@"order_commission"]; //小费
    
    [orderObject setObject:@(3) forKey:@"order_state"];
    
    
    if (attachObjects.count > 0) {
        
        
        BmobRelation *imageRelation = [[BmobRelation alloc]init];
        
        for (int i = 0; i < attachObjects.count; i ++) {
            
            BmobObject *oneAttach = attachObjects[i];
            
            [imageRelation addObject:oneAttach];
            
        }
      
        [orderObject addRelation:imageRelation forKey:@"attachItem"];
        
        [orderObject setObject:@YES forKey:@"is_photo_description"];
        
    }
    
    
    
    
       [MyProgressHUD showProgress];
    [orderObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
       
        if (isSuccessful) {
            
            
            [self addItems:attachObjects weiboItem:orderObject];
            
            
            
          
            
       
            
        }
        else
        {
            
            [MyProgressHUD dismiss];
            
            [CommonMethods showDefaultErrorString:@"订单提交失败"];
            NSLog(@"订单提交失败:%@",error);
            
        }
        
        
    }];
}
#pragma mark - 往AttachItem 添加 order point
-(void)addItems:(NSArray*)attachItems weiboItem:(BmobObject*)orderitem
{
    if (attachItems.count > 0) {
        
        BmobObjectsBatch *batch = [[BmobObjectsBatch alloc]init];
        
        for (int i = 0 ; i < attachItems.count; i ++) {
            BmobObject *oneItem = [attachItems objectAtIndex:i];
            
            [batch updateBmobObjectWithClassName:kAttachItem objectId:oneItem.objectId parameters:@{@"order":orderitem}];
            
            
        }
        
        [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            
            if (isSuccessful) {
                
                [self saveDetailAccount:orderitem];
            }
            else
            {
                [CommonMethods showDefaultErrorString:@"订单提交失败"];
                NSLog(@"订单提交失败:%@",error);
                [MyProgressHUD dismiss];
            }
            
            
            
        }];
        
    }
    else
    {
        [self saveDetailAccount:orderitem];
    }

    
    
}
#pragma mark - 保存订单

#pragma mark - 保存明细
-(void)saveDetailAccount:(BmobObject*)orderObject
{
    
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    
    [CommonMethods updateDetailAccountWithType:DetailAccountTypePay_error Order:orderObject User:user money:0 qianshoubi:0 withResultBlock:^(BOOL success,BmobObject *detailObject) {
       
        [MyProgressHUD dismiss];
        
        if (success)
        {
            
            
            [self payOrder:orderObject detailObject:detailObject];
            
            
        }
        else
        {
            [CommonMethods showDefaultErrorString:@"订单提交失败"];
           
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
                
                //更新订单状态
                [orderObject setObject:@(OrderStatePayedUnAccepted) forKey:@"order_state"];
                [orderObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    
                     [MyProgressHUD dismiss];
                    
                    if (isSuccessful)
                    {
                        
                        
                        _sucessPayAlert = [[UIAlertView alloc]initWithTitle:nil message:@"支付成功，订单发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
                        
                        [_sucessPayAlert show];
                        
                    }
                    else
                    {
                        
                    }
                    
                }];
                
                
                //更新明细表
                [CommonMethods updateDetailAccountWithType:DetailAccountTypeSendOrder Order:orderObject User:[BmobUser getCurrentUser] money:0 qianshoubi:0 withResultBlock:^(BOOL success, BmobObject *detailObject) {
                   
                    
                }];
                
                
           
                
            }
            else
            {
                
                  [MyProgressHUD dismiss];
                
                NSString *memo = [resultDic objectForKey:@"memo"];
                if (memo.length == 0) {
                    
                    memo = @"支付失败";
                }
                
                
                _failPayAlert = [[UIAlertView alloc]initWithTitle:nil message:memo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [_failPayAlert show];
                
                
                
                
                //
            }
        }];
        
    }
 }
#pragma mark - 查询奖励设置表
-(void)getRewardLimitation
{
    BmobQuery *queReward = [BmobQuery queryWithClassName:kRewardClassName];
    
    [queReward findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        rewardModel = [[RewardLimitationModel alloc]init];
        
        for (BmobObject *ob in array)
        {
            
            rewardModel.b_SenderAward = [[ob objectForKey:@"b_SenderAward"]boolValue];
            
            rewardModel.b_RecipientAward = [[ob objectForKey:@"b_RecipientAward"]boolValue];
            
            rewardModel.d_SenderAwardRatio = [[ob objectForKey:@"d_SenderAwardRatio"]doubleValue];
            
            rewardModel.d_RecipientAwardRatio = [[ob objectForKey:@"d_RecipientAwardRatio"]doubleValue];
            
            rewardModel.CityAwardCode = [ob objectForKey:@"CityAwardCode"];
            
            rewardModel.PlatformFee = [[ob objectForKey:@"PlatformFee"]doubleValue];
            
            rewardModel.b_RewardCurrencyActivity = [[ob objectForKey:@"b_RewardCurrencyActivity"]boolValue];
            
            rewardModel.FirstClassAward = [[ob objectForKey:@"FirstClassAward"]doubleValue];
            
            rewardModel.TwoLevelAwards = [[ob objectForKey:@"TwoLevelAwards"]doubleValue];
            
            rewardModel.ThreeLevelAwards = [[ob objectForKey:@"ThreeLevelAwards"]doubleValue];
            
            rewardModel.FirstClassAwardNum = [[ob objectForKey:@"FirstClassAwardNum"]doubleValue];
            
            rewardModel.TwoLevelAwardsNum = [[ob objectForKey:@"TwoLevelAwardsNum"]doubleValue];
            
            rewardModel.ThreeLevelAwardsNum = [[ob objectForKey:@"ThreeLevelAwardsNum"]doubleValue];
            
            
            
            
            
        }
        
    }];
    
    
}



- (IBAction)pickPhoto:(id)sender {
    
    
    
    [_pickPhotoActionSheet showInView:self.view];
    
    
    
}


#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == _pickPhotoActionSheet)
    {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 2:
                    return;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 0: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = sourceType;
        
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
    
}


#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image  = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (image != nil)
    {
        
        image = [CommonMethods autoSizeImageWithImage:image];
        
        [_PhotosArray addObject:image];
        
        [self setPhotos];
        
        [self.tableView reloadData];
        
        
        
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)setPhotos
{
    
    for (UIView *view in imagesView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    CGFloat offSet = 8.0;
    
    CGFloat imageViewWith = imagesCellHeight - offSet*2;
    CGFloat deleteButtonWith = 15.0;
    
    
    for (int i = 0; i < _PhotosArray.count; i++) {
        
        UIImage *oneImage = [_PhotosArray objectAtIndex:i];
        
        UIImageView *oneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(offSet +(imageViewWith+offSet)*i , offSet, imageViewWith, imageViewWith)];
        oneImageView.image = oneImage;
        
        [imagesView addSubview:oneImageView];
        
        
        //add delete button
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(oneImageView.frame.origin.x - 6.0, 0, deleteButtonWith, deleteButtonWith)];
        
        [deleteButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
        deleteButton.tag = i;
        
        [deleteButton addTarget:self action:@selector(deleteOneImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [imagesView addSubview:deleteButton];
        
        
        
        
    }
    
    if (_PhotosArray.count < 4)
    {
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(offSet + (imageViewWith+offSet)*_PhotosArray.count, offSet, imageViewWith, imageViewWith)];
        
        [addButton setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        
        [addButton addTarget:self action:@selector(pickPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [imagesView addSubview:addButton];
        
        
    }
    
    
    
    
}


-(void)deleteOneImage:(UIButton*)sender
{
    
    if (sender.tag < _PhotosArray.count) {
        
        [_PhotosArray removeObjectAtIndex:sender.tag];
        
        
        [self setPhotos];
        
    }
    
    
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _sucessPayAlert || alertView == _failPayAlert)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
