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

static CGFloat imagesCellHeight = 70.0;

@interface DarenTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    
    UIActionSheet *_pickPhotoActionSheet;
    
    NSMutableArray *_PhotosArray;
    
    UIView *imagesView; //用于放图片
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)publishDarenAtion:(id)sender {
    
    [self updatePhotos];
    
}

#pragma mark - 先保存照片
- (void)updatePhotos
{
    if (_PhotosArray.count > 0)
    {
      
        NSMutableArray *photosDataArray = [[NSMutableArray alloc]init];
        
        for (NSInteger i = 0 ; i  < _PhotosArray.count ; i ++) {
            
            UIImage *oneImage = [_PhotosArray objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(oneImage, 1);
            
            
            
            NSDictionary *imagedataDic = @{@"data":imageData,@"filename":@"image.jpg"};
            
            [photosDataArray addObject:imagedataDic];
            
            
        }
        
        
        
        [MyProgressHUD showProgress];
        
        
        [BmobProFile uploadFilesWithDatas:photosDataArray resultBlock:^(NSArray *filenameArray, NSArray *urlArray, NSArray *bmobFileArray, NSError *error) {
            
            
            
            if (error) {
                
                NSLog(@"%s,error:%@",__func__,error);
                
                NSLog(@"图片上传失败");
                
                [CommonMethods showDefaultErrorString:@"图片上传失败，请重新上传"];
                
            }
            else
            {
                
                NSLog(@"filename:%@  urlArray:%@",filenameArray,urlArray);
                
                
                if (bmobFileArray.count > 0)
                {
                    
                    
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
                    
             
                    
                    
                    
                }
            }
            
            
        } progress:^(NSUInteger index, CGFloat progress) {
            
            
        }];
        
        
    }
    else
    {
        
    }
}





@end
