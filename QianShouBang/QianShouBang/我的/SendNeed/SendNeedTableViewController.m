//
//  SendNeedTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "SendNeedTableViewController.h"
#import "RewardLimitationModel.h"




static NSString *needCell = @"needCell";
static NSString *imagesCell = @"imagesCell";
static NSString *benjinCell = @"benjinCell";
static NSString *tipsCell = @"tipsCell";


@interface SendNeedTableViewController ()<UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    RewardLimitationModel *rewardModel;
    
   
    UIActionSheet *_pickPhotoActionSheet;
    
    NSMutableArray *_PhotosArray;
    
    UIView *imagesView; //用于放图片
    
    
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
}



#pragma mark - 查询奖励设置表
-(void)getRewardLimitation
{
    BmobQuery *queReward = [BmobQuery queryWithClassName:kRewardClassName];
    
    [queReward findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        rewardModel = [[RewardLimitationModel alloc]init];
        
        for (BmobObject *ob in array)
        {
          
           
            
           
            
            
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
        
        
        if (_PhotosArray.count > 0) {
            
            
        }
     
        [_PhotosArray addObject:image];
        
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
    for (int i = 0; i < _PhotosArray.count; i++) {
        
        
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
