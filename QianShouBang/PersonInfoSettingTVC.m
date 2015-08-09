//
//  PersonInfoSettingTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PersonInfoSettingTVC.h"
#import "RowTextCell.h"
#import "PortraitCell.h"
#import "IntroduceYourselfViewController.h"
#import "NickNameViewController.h"
#import "BindPhoneViewController.h"

@interface PersonInfoSettingTVC ()
@property (nonatomic, strong)UIActionSheet *sexAC;
@property (nonatomic, strong)UIActionSheet *pickPhotoActionSheet;
@end

@implementation PersonInfoSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息设置";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    headView.backgroundColor = [UIColor clearColor];
    
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 60;
        }
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *portraitCellId = @"PortraitCell";
    PortraitCell *portraitCell = [tableView dequeueReusableCellWithIdentifier:portraitCellId];
    if (portraitCell == nil) {
        portraitCell = [[NSBundle mainBundle]loadNibNamed:@"PortraitCell" owner:self options:nil][0];
    }
    portraitCell.selectionStyle = UITableViewCellSelectionStyleNone;
    portraitCell.backgroundColor = kContentColor;
    
    
    
    static NSString *cellId = @"RowTextCell";
    RowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RowTextCell" owner:self options:nil][0];
    }
    cell.extraText.hidden = YES;
    cell.arrow.hidden = YES;
    cell.extraText.textColor = kBlueColor;
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //头像
                    portraitCell.image.image = [UIImage imageNamed:@"setting"];
                    return portraitCell;
                }
                    break;
                    
                case 1:
                {
                    cell.extraText.hidden = NO;
                    cell.arrow.hidden = NO;
                    cell.text.text = @"自我描述";
                    cell.extraText.text = @"主人很懒，什么都没留下";
                    return cell;
                    
                }
                    break;
                    
                case 2:
                {
                    cell.extraText.hidden = NO;
                    cell.arrow.hidden = YES;
                    cell.text.text = @"账号";
                    cell.extraText.text = @"15222222222";
                    return cell;
                   
                }
                    break;
                    
                case 3:
                {
                    cell.extraText.hidden = NO;
                    cell.arrow.hidden = NO;
                    cell.text.text = @"昵称";
                    cell.extraText.text = @"牛逼邦果";
                    return cell;
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.extraText.hidden = NO;
                    cell.arrow.hidden = NO;
                    cell.text.text = @"手机号";
                    cell.extraText.text = @"15222222222";
                    return cell;

                }
                    break;
                    
                case 1:
                {
                    cell.extraText.hidden = YES;
                    cell.arrow.hidden = NO;
                    cell.text.text = @"生日";
                    return cell;
                    
                }
                    break;
                    
                case 2:
                {
                    cell.extraText.hidden = YES;
                    cell.arrow.hidden = NO;
                    cell.text.text = @"地区";
                    return cell;
                    
                }
                    break;
                    
                case 3:
                {
                    cell.extraText.hidden = NO;
                    cell.arrow.hidden = NO;
                    cell.text.text = @"性别";
                    cell.extraText.text = @"性别是啥";
                    return cell;
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                //头像
            case 0:
            {
                _pickPhotoActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
                
                [_pickPhotoActionSheet addButtonWithTitle:@"相册图片描述"];
                [_pickPhotoActionSheet addButtonWithTitle:@"手机拍照描述"];
                
                [_pickPhotoActionSheet addButtonWithTitle:@"取消"];
                
                _pickPhotoActionSheet.cancelButtonIndex = 2;
                [_pickPhotoActionSheet showInView:self.view];
                
            }
                break;
                
                //自我描述
            case 1:
            {
                IntroduceYourselfViewController *introVC = [sb instantiateViewControllerWithIdentifier:@"IntroduceYourselfViewController"];
                [self.navigationController pushViewController:introVC animated:YES];
            }
                break;
                
                //账号
            case 2:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //昵称
            case 3:
            {
                NickNameViewController *nickVC = [sb instantiateViewControllerWithIdentifier:@"NickNameViewController"];
                [self.navigationController pushViewController:nickVC animated:YES];
                
            }
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
                //手机号
            case 0:
            {
                BindPhoneViewController *bindVC = [sb instantiateViewControllerWithIdentifier:@"BindPhoneViewController"];
                [self.navigationController pushViewController:bindVC animated:YES];
            }
                break;
                
                //生日
            case 1:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //地区
            case 2:
                self.view.backgroundColor = [UIColor redColor];
                break;
                
                //性别
            case 3:
            {
                self.sexAC = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"男性",@"女性", nil];
                [self.sexAC addButtonWithTitle:@"取消"];
                self.sexAC.cancelButtonIndex = 2;
                [self.sexAC showInView:self.view];
            }
                break;
                
            default:
                break;
        }
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet == self.sexAC) {
        if (buttonIndex == 0) {//男性
                    }else if(buttonIndex == 1){//女性
        }
    }else if (actionSheet == _pickPhotoActionSheet){
        
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
/*
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
    
    
    
    
}*/
@end
