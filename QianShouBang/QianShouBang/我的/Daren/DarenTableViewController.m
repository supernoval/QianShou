//
//  DarenTableViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/8.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "DarenTableViewController.h"
#import "Constants.h"
#import <BmobSDK/BmobProFile.h>
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

static CGFloat imagesCellHeight = 70.0;

@interface DarenTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    UIActionSheet *_pickPhotoActionSheet;
    
    NSMutableArray *_PhotosArray;
    
    UIView *imagesView; //用于放图片
    
    UIAlertView *_sucessPayAlert;
    
    UIAlertView *_failPayAlert;
    
    
}
@end

@implementation DarenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title = @"发布达人信息";
    
    
     _PhotosArray  = [[NSMutableArray alloc]init];
    
    _footerView.frame = CGRectMake(0, 0, ScreenWidth , 150);
    
    _darenButton.clipsToBounds = YES;
    _darenButton.layer.cornerRadius = 10.0;
    
    
    _pickPhotoActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"相册图片描述"];
    [_pickPhotoActionSheet addButtonWithTitle:@"手机拍照描述"];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"取消"];
    
    _pickPhotoActionSheet.cancelButtonIndex = 2;
    
    
    [self initImagesView];
    
}
-(void)initImagesView
{
    imagesView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, imagesCellHeight)];
    [_photosCell.contentView addSubview:imagesView];
    
    [self setPhotos];
    
    
    
    
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

- (void)pickPhoto:(id)sender {
    
    
    
    [_pickPhotoActionSheet showInView:self.view];
    
    
    
}
-(void)deleteOneImage:(UIButton*)sender
{
    
    if (sender.tag < _PhotosArray.count) {
        
        [_PhotosArray removeObjectAtIndex:sender.tag];
        
        
        [self setPhotos];
        
    }
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)publishDarenAtion:(id)sender {
    
    //先查询是否发过达人
    BmobQuery *queryDaren = [BmobQuery queryWithClassName:kOrder];
    
    [queryDaren whereKey:@"order_type" equalTo:@(100)];
    [queryDaren whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [queryDaren whereKey:@"order_state" equalTo:@(1)];
    
    [MyProgressHUD showProgress];
    
    [queryDaren findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count > 0) {
            
            [CommonMethods showDefaultErrorString:@"您已发布过达人，不能再次发布"];
            
            return ;
        }
        else
        {
            if (_carrierT.text.length ==0) {
                
                [CommonMethods showDefaultErrorString:@"职业不能为空"];
                
                return;
            }
            
            
            if (_goodAtTF.text.length == 0) {
                
                [CommonMethods showDefaultErrorString:@"请填写擅长的技能"];
                
                return;
            }
            
            
            CGFloat money = [_moneyTF.text floatValue];
            
            if (money < 0.1) {
                
                [CommonMethods showDefaultErrorString:@"保证金不能少于50元"];
                
                return;
                
            }
            
            
            [self updatePhotos];
            
        }
        
    }];
    
    
   
}

#pragma mark - 先保存照片
- (void)updatePhotos
{
    //如果有图片 先上传图片
    
    
    if (_PhotosArray.count > 0) {
        
        [MyProgressHUD showProgress];
        
        [CommonMethods upLoadPhotos:_PhotosArray resultBlock:^(BOOL success, NSArray *results) {
            
            if (success)
            {
                
                [self summitAttachItems:results];
                
                 NSLog(@"filename:%@ ",results);
                
            }else
            {
                
              
                [MyProgressHUD dismiss];
                
                NSLog(@"图片上传失败");
                
                [CommonMethods showDefaultErrorString:@"图片上传失败，请重新上传"];
                

                
            }
            
        }];
        
        
        
        
        
        
        
    }
    else //没有图片直接上传
    {
        
        [self summitAttachItems:nil];
        
    }
}


#pragma mark - 保存达人订单
-(void)summitAttachItems:(NSArray*)attachObjects
{
    
    NSString *carrier = _carrierT.text;
    NSString *descrip = _goodAtTF.text;
    
    CGFloat benjin = [_moneyTF.text floatValue];
    benjin = [CommonMethods getTwopoint:benjin];
    
    
    BmobObject *orderObject = [BmobObject objectWithClassName:kOrder];
    
    [orderObject setObject:carrier forKey:@"order_title"];
    [orderObject setObject:descrip forKey:@"order_description"];
    [orderObject setObject:@(100) forKey:@"order_type"];
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    //                                QSUser *myUser = [[QSUser alloc]initFromBmobOjbect:user];
    
    [orderObject setObject:user forKey:@"user"];
    
    
   NSString *_address = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAddress];
   double _longitude = [[NSUserDefaults standardUserDefaults ] floatForKey:kGPSLoactionLongitude];
   double _latitude = [[NSUserDefaults standardUserDefaults ] floatForKey:kGPSLocationLatitude];
    
    BmobGeoPoint *location = [[BmobGeoPoint alloc]initWithLongitude:_longitude WithLatitude:_latitude];
    
    [orderObject setObject:location forKey:@"location"];
    
    [orderObject setObject:_address forKey:@"order_address"];
    
    [orderObject setObject:@(benjin) forKey:@"order_benjin"];
    
    [orderObject setObject:@(0) forKey:@"jiangli_money"];
    
    [orderObject setObject:user.username forKey:@"order_phone"];
    
    [orderObject setObject:@(0) forKey:@"order_commission"]; //小费
    
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
    
    
    [orderObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        
         
        
        
        if (isSuccessful) {
           
            [self saveDetailAccount:orderObject];
            
            
        }
        else
        {
            
            [MyProgressHUD dismiss];
            
            [CommonMethods showDefaultErrorString:@"达人信息保存失败，请重试"];
            
            NSLog(@"error:%@",error);
            
            
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
    
    
    [detailObject setObject:@(jiangli) forKey:@"tIntegralCount"];
    
    [detailObject setObject:@(benjin) forKey:@"tMoneyCount"];
    
    [detailObject setObject:@NO forKey:@"vip"];
    
    [detailObject setObject:@(commision) forKey:@"tIntegral"];
    
    [detailObject setObject:@(benjin) forKey:@"tMoney"];
    
    [detailObject setObject:@(jiangli) forKey:@"tJiangli"];
    
    [detailObject setObject:@YES forKey:@"OpenMaster"];
    
    
    
    [detailObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        [MyProgressHUD dismiss];
        
        if (isSuccessful) {
            
            [self payOrder:orderObject detailObject:detailObject];
            
        }
        else
        {
            
            [MyProgressHUD dismiss];
            
            
            NSLog(@"%s,error:%@",__func__,error);
            
            
            
        }
        
    }];
    
    
    
}


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
                        
                        
                        _sucessPayAlert = [[UIAlertView alloc]initWithTitle:nil message:@"支付成功，达人发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
                        
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
                
                
                _failPayAlert = [[UIAlertView alloc]initWithTitle:nil message:memo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [_failPayAlert show];
                
                
                
                
                //
            }
        }];
        
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

@end
