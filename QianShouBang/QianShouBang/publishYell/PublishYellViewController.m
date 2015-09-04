//
//  PublishYellViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PublishYellViewController.h"
#import "PhotoListView.h"
#import <BmobSDK/BmobProFile.h>

@interface PublishYellViewController ()<UITextViewDelegate,PhotoListViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSMutableArray *photos;
    
    PhotoListView *_photoListView;
    
    UIActionSheet *_pickPhotoActionSheet;
    
    BOOL hideInfo;
    
    
    
    
}
@property (weak, nonatomic) IBOutlet UITextView *yellTextView;

@property (weak, nonatomic) IBOutlet UILabel *textNumlabel;


@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
- (IBAction)publish:(id)sender;

@end

@implementation PublishYellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    photos = [[NSMutableArray alloc]init];
    
    

    
    _yellTextView.delegate = self;
    
    _photoListView = [[PhotoListView alloc]initWithFrame:CGRectMake(0, 184, ScreenWidth, 70)];
    _photoListView.photoDelegate = self;
    
    [self.view addSubview:_photoListView];
    
    NSLog(@"y:%.2f ",_photoListView.frame.origin.y);
    
    _photoListView.photos  = photos;
    [self setbottomViewFrame];
    
    _pickPhotoActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"相册图片描述"];
    [_pickPhotoActionSheet addButtonWithTitle:@"手机拍照描述"];
    
    [_pickPhotoActionSheet addButtonWithTitle:@"取消"];
    
    _pickPhotoActionSheet.cancelButtonIndex = 2;
    
    
    _locationLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAddress];
    
    
    
    
}


#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        
        _placeholderLabel.hidden = YES;
    }
    else
    {
        _placeholderLabel.hidden = NO;
        
    }
    
     [self changeTextLeftlabel:textView];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@""]) {
        
        return YES;
        
    }
    if (textView.text.length >=1500) {
        
        return NO;
    }
    
   
    
    
    return YES;
    
    
}


-(void)changeTextLeftlabel:(UITextView*)TV
{
    NSInteger textNum = TV.text.length;
    
   
    
    NSString *textStr = [NSString stringWithFormat:@"%ld/1500",(long)textNum];
    
    
    _textNumlabel.text = textStr;
    
}

#pragma mark - PhotoListViewDelegate
-(void)addNewPhoto{
  
    
    [_pickPhotoActionSheet showInView:self.view];
    
    
}

-(void)deleteOnePhoto:(NSInteger)photoIndex
{
    [photos removeObjectAtIndex:photoIndex];
    
    _photoListView.photos = photos;
    [self setbottomViewFrame];
    
    
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
        
        
        [photos addObject:image];
        
        _photoListView.photos = photos;
        
        [self setbottomViewFrame];
        
        
        
        
        
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)publish:(id)sender {
    
    [self uploadPhotos];
    
    
    
}

#pragma mark - 首先是否有照片上传
-(void)uploadPhotos
{
    
    if (_yellTextView.text.length  == 0)
    {
        
        [CommonMethods showDefaultErrorString:@"请输入分享内容"];
        
        return;
    }
    
    
    if (photos.count > 0)
    {
      
        [CommonMethods upLoadPhotos:photos resultBlock:^(BOOL success, NSArray *results) {
        
            if (success)
            {
              
                [self summitYellWithAttachItems:results];
                
                
            }
            else
            {
                [MyProgressHUD dismiss];
                
            }
            
        }];
        
    
        
        
    }
    else
    {
        [self summitYellWithAttachItems:nil];
        
    }
}

#pragma mark - 提交呐喊
-(void)summitYellWithAttachItems:(NSArray*)attachItems
{
    BmobObject *weiboObject = [[BmobObject alloc]initWithClassName:kWeiboListItem];
    
    [weiboObject setObject:[BmobUser getCurrentUser] forKey:@"user"];
    
    BmobRelation *relation = [[BmobRelation alloc]init];
    
    for (BmobObject *ob in attachItems) {
       
        [relation addObject:ob];
        
        
    }
    
    [weiboObject addRelation:relation forKey:@"attachItem"];
    
    double latitude = [[NSUserDefaults standardUserDefaults ]floatForKey:kGPSLocationLatitude];
    double longitude = [[NSUserDefaults standardUserDefaults ] floatForKey:kGPSLoactionLongitude];
    
    BmobGeoPoint *location = [[BmobGeoPoint alloc]initWithLongitude:longitude WithLatitude:latitude];
    
    [weiboObject setObject:@(attachItems.count) forKey:@"total"];
    
    [weiboObject setObject:location forKey:@"location"];
    
    if (_yellTextView.text.length > 0)
    {
      
        [weiboObject setObject:_yellTextView.text forKey:@"content"];
        
        
    }
    
    NSString *phoneModel = [CommonMethods getCurrentDeviceName];
    
    
    [weiboObject setObject:phoneModel forKey:@"build_model"];
    
    [weiboObject setObject:@(hideInfo) forKey:@"hide_info"];
    [weiboObject setObject:@YES forKey:@"isSuccess"];
    
    
    [weiboObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
      
        
        if (isSuccessful) {
            
           
            if (attachItems.count > 0) {
                
                [self addItems:attachItems weiboItem:weiboObject];
                
                
            }
            else
            {
                 [MyProgressHUD showError:@"发布成功"];
            }
            
            
           
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
        else
            
        {
            
              [MyProgressHUD dismiss];
            
            
            [MyProgressHUD showError:@"发布失败"];
        }
        
    }];
    
    
}

#pragma mark - 往AttachItem 添加WeiboItem point 
-(void)addItems:(NSArray*)attachItems weiboItem:(BmobObject*)weiboItem
{
    BmobObjectsBatch *batch = [[BmobObjectsBatch alloc]init];
    
    for (int i = 0 ; i < attachItems.count; i ++) {
        BmobObject *oneItem = [attachItems objectAtIndex:i];
        
        [batch updateBmobObjectWithClassName:kAttachItem objectId:oneItem.objectId parameters:@{@"items":weiboItem}];
        
        
    }
    
    [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        
          [MyProgressHUD dismiss];
        
        if (isSuccessful) {
            
            
            [MyProgressHUD showError:@"发布成功"];
        }
        
        else
            
        {
            [MyProgressHUD showError:@"发布失败"];
        }
        
        
    }];
    

    
}

-(void)setbottomViewFrame
{
    
    _toTextViewSpace.constant = _photoListView.frame.size.height + 8.0;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideInfoAction:(id)sender {
    
    if (hideInfo) {
        
        hideInfo = NO;
        
        [_hideInfoButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        
    }
    else
    {
        hideInfo = YES;
         [_hideInfoButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }
}
@end
