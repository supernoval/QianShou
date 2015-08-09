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



@interface SendNeedTableViewController ()<UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    RewardLimitationModel *rewardModel;
    
    
    UIActionSheet *_pickPhotoActionSheet;
    
    NSMutableArray *_PhotosArray;
    
    UIView *imagesView; //用于放图片
    
    Order *_order; //支付model
    
    
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
    
    if (xiaofei == 0) {
        
        [MyProgressHUD showError:@"小费金额不能为0"];
        
        return;
        
    }
    
    
    
    //如果有图片 先上传图片
    
    
    if (_PhotosArray.count > 0) {
        
        NSMutableArray *photosDataArray = [[NSMutableArray alloc]init];
        
        for (NSInteger i ; i  < _PhotosArray.count ; i ++) {
            
            UIImage *oneImage = [_PhotosArray objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(oneImage, 1);
            
            
            
            NSDictionary *imagedataDic = @{@"data":imageData,@"filename":@"image.jpg"};
            
            [photosDataArray addObject:imagedataDic];
            
            
        }
        
        
        
        [MyProgressHUD showProgress];
        
        
        [BmobProFile uploadFilesWithDatas:photosDataArray resultBlock:^(NSArray *filenameArray, NSArray *urlArray, NSArray *bmobFileArray, NSError *error) {
            
            [MyProgressHUD dismiss];
            
            if (error) {
                
                NSLog(@"%s,error:%@",__func__,error);
                
                NSLog(@"图片上传失败");
                
                [CommonMethods showDefaultErrorString:@"图片上传失败，请重新上传"];
                
            }else
            {
                
                NSLog(@"filename:%@  urlArray:%@",filenameArray,urlArray);
                
                
                if (bmobFileArray.count > 0) {
                    
                    
                    BmobObjectsBatch *batch = [[BmobObjectsBatch alloc]init];
                    NSMutableArray *files = [[NSMutableArray alloc]init];
                    
                    
                    for (int i = 0 ; i < bmobFileArray.count; i ++) {
                        
                        BmobFile *onefile = [bmobFileArray objectAtIndex:i];
                        
                        NSString *url = onefile.url;
                        
                        
                   
                        BmobObject *attachObject = [[BmobObject alloc]initWithClassName:kAttachItem];
                        
                        [attachObject setObject:url forKey:@"attach_name"];
                        [attachObject setObject:url forKey:@"attach_url"];
                        
                        [files addObject:attachObject];
                        
                      
                        [batch saveBmobObjectWithClassName:kAttachItem parameters:@{@"attach_name":url,@"attach_url":url}];
                        
                        
                        
                        
                    }
                    
                    
                    [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        
                        if (isSuccessful) {
                            
                            [self summitWithAttachObject:files];
                            
                        }
                    }];
            
                    
                    
                    
                }
            }
            
            
        } progress:^(NSUInteger index, CGFloat progress) {
            
            
        }];
        
        
        
        
        
    }
    else //没有图片直接上传
    {
        [self summitWithAttachObject:nil];
        
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

-(void)summitWithAttachObject:(NSMutableArray*)attachObjects
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
    
    CGFloat benjin = [_benjinTF.text floatValue];
    
    CGFloat order_commission = 0;
    
    if (rewardModel.b_SenderAward) {
        
        order_commission = xiaofei * rewardModel.d_SenderAwardRatio;
    }
    
    
    BmobObject *orderObject = [BmobObject objectWithClassName:kOrder];
    
    [orderObject setObject:desc forKey:@"order_title"];
    [orderObject setObject:desc forKey:@"order_description"];
    [orderObject setObject:@(0) forKey:@"order_type"];
    
    BmobUser *user = [BmobUser getCurrentUser];
    
    //                                QSUser *myUser = [[QSUser alloc]initFromBmobOjbect:user];
    
    [orderObject setObject:user forKey:@"user"];
    
    BmobGeoPoint *location = [[BmobGeoPoint alloc]initWithLongitude:0 WithLatitude:0];
    
    [orderObject setObject:location forKey:@"location"];
    
    [orderObject setObject:@(benjin) forKey:@"order_benjin"];
    
    [orderObject setObject:@(xiaofei) forKey:@"jiangli_money"];
    
    [orderObject setObject:user.username forKey:@"order_phone"];
    
    [orderObject setObject:@(order_commission) forKey:@"order_commmission"];
    
    [orderObject setObject:@(3) forKey:@"order_state"];
    
    
    if (attachObjects.count > 0) {
        
        
        BmobRelation *imageRelation = [[BmobRelation alloc]init];
        
        for (int i = 0; i < attachObjects.count; i ++) {
            BmobObject *oneAttach = attachObjects[i];
            
            [imageRelation addObject:oneAttach];
            
        }
      
        [orderObject addRelation:imageRelation forKey:@"attachItem"];
        
    }
    
    
    
    [MyProgressHUD showProgress];
    
    [orderObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        [MyProgressHUD dismiss];
        if (isSuccessful) {
            
            [self saveDetailAccount:orderObject];
            
            
            
        }
        else
            
        {
            
            [CommonMethods showDefaultErrorString:@"订单提交失败"];
            NSLog(@"订单提交失败:%@",error);
            
        }
        
        
    }];
}

#pragma mark - 保存明细
-(void)saveDetailAccount:(BmobObject*)orderObject
{
    BmobUser *user = [BmobUser getCurrentUser];
    
    
    
    double jiangli = [[orderObject objectForKey:@"jiangli_money"]doubleValue];
    double benjin = [[orderObject objectForKey:@"order_benjin"]doubleValue];
    double commision = [[orderObject objectForKey:@"order_commmission"]doubleValue];
    
    
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
    
    [detailObject setObject:@(jiangli) forKey:@"tIntegralCount"];
    
    [detailObject setObject:@(benjin) forKey:@"tMoneyCount"];
    
    [detailObject setObject:@NO forKey:@"vip"];
    
    [detailObject setObject:@(commision) forKey:@"tIntegral"];
    
    [detailObject setObject:@(benjin) forKey:@"tMoney"];
    
    [detailObject setObject:@(jiangli) forKey:@"tJiangli"];
    
    
    [detailObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        
        if (isSuccessful) {
            
            [self payOrder:orderObject detailObject:detailObject];
            
        }
        else
        {
            
            
            
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
    
    
    order.tradeNO = [NSString stringWithFormat:@"%@,%@",orderObject.objectId,detailObject.objectId]; //订单ID（由商家自行制定）
    
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
                
                
            }
            else
            {
                
                NSString *memo = [resultDic objectForKey:@"memo"];
                if (memo.length == 0) {
                    
                    memo = @"支付失败";
                }
                
                
                [[[UIAlertView alloc]initWithTitle:nil message:memo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
                
                
                
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
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
    
}


#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image  = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (image != nil)
    {
        
        
        
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
