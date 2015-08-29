//
//  YellDetailTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/27.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "YellDetailTableViewController.h"
#import "YellCell.h"
#import "EmojiView.h"
#import "CommentCell.h"
#import "UserDetailTVC.h"


static NSString *contentCell = @"contentCell";

@interface YellDetailTableViewController ()<UITextFieldDelegate,EmojiViewDelegate>
{
    NSArray *_commentArray;
    
    UIView *_bottomView;
    UITextField *_replayTextField;
    
    EmojiView *_emojiView;
    
    BmobUser *weibouser;
    
     UITapGestureRecognizer *_tapResign;
    
    
    
}
@end

@implementation YellDetailTableViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    [_bottomView removeFromSuperview];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self setBottomView];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"呐喊详情";
    
    
    _tapResign = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
    weibouser = [_yellmodel.yellObject objectForKey:@"user"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self getCommentList];
    
    
}

-(void)hideKeyboard
{
    [_replayTextField resignFirstResponder];
    
    [self.view removeGestureRecognizer:_tapResign];
    
    
}
-(void)getCommentList
{
    BmobQuery *query = [BmobQuery queryWithClassName:kCommentList];
    
    [query whereKey:@"items" equalTo:self.yellmodel.yellObject];
    [query includeKey:@"from_user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array)
        {
            
            _commentArray = array;
            
            [self.tableView reloadData];
            
        }
        
        
        
        
    }];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    
    blankView.backgroundColor = [UIColor clearColor];
    
    return blankView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _commentArray.count ) {
        
        
        return 44;
        
    }
    
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            
            CGFloat photoViewHeight = 0;
            
            NSArray *imgs = _yellmodel.photos;
            
            long imageCount = imgs.count;
            int perRowImageCount = ((imageCount == 4) ? 2 : 3);
            CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
            int totalRowCount = ceil(imageCount / perRowImageCountF);
            
            photoViewHeight = 95 * totalRowCount;
            
            
            CGFloat textHeight = 0;
            
            NSString *text = [_yellmodel.yellObject objectForKey:@"content"];
            
            textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth - 16];
            
            if (textHeight < 30)
            {
                
                textHeight = 30;
                
                
            }
            
            
            
            return 158 + photoViewHeight + textHeight;
            
        }
            break;
            
            
        default:
        {
            BmobObject *commentObject = [_commentArray objectAtIndex:indexPath.section -1];
            
            
            NSString *content = [commentObject objectForKey:@"comment_content"];
            
           CGFloat textHeight = [StringHeight heightWithText:content font:FONT_17 constrainedToWidth:ScreenWidth - 80];
            
            if (textHeight < 21)
            {
                
                textHeight = 21;
                
                
            }
            
            return 55 + textHeight;
            
        }
            break;
    }
    
    return 44;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    return _commentArray.count + 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            YellCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCell];
            dispatch_async(dispatch_get_main_queue(), ^{
                
      
                UIButton *headbutton = (UIButton*)[cell viewWithTag:100];
                
                UILabel *headTitle = (UILabel*)[cell viewWithTag:101];
                
                UIImageView *sexImageview = (UIImageView*)[cell viewWithTag:102];
                
                UIImageView *vipImageView = (UIImageView *)[cell viewWithTag:103];
                
                UILabel *timeLabel = (UILabel*)[cell viewWithTag:104];
                
                UILabel *contentLabel = (UILabel*)[cell viewWithTag:105];
                
                SDPhotoGroup *imageView = (SDPhotoGroup*)[cell viewWithTag:106];
                
                headbutton.clipsToBounds = YES;
                headbutton.layer.cornerRadius = 30.0;
                
                [headbutton addTarget:self
                               action:@selector(showWeiboUser)
                     forControlEvents:UIControlEventTouchUpInside];
                
               
                
                NSInteger viplevel = [[weibouser objectForKey:@"user_level"]integerValue];
                if (viplevel == 2) {
                    
                    vipImageView.hidden = NO;
                }
                else
                {
                    vipImageView.hidden = YES;
                    
                }
                
            
                
                [headbutton sd_setImageWithURL:[NSURL URLWithString:[weibouser objectForKey:@"avatar"] ] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head_default"]];
                 
                
                headTitle.text = [weibouser objectForKey:@"nick"];
                
                cell.nameLabelWithConstrain.constant = [StringHeight widthtWithText:headTitle.text font:FONT_15 constrainedToHeight:21];
                
                
                // 文字内容
                NSString * content = [_yellmodel.yellObject objectForKey:@"content"];
                //                content = [CommonUtil escapeUnicodeString:content];
              
                
                contentLabel.text = content;
                
                NSString *text = [_yellmodel.yellObject objectForKey:@"content"];
                
                CGFloat  textHeight = [StringHeight heightWithText:text font:FONT_17 constrainedToWidth:ScreenWidth - 16];
                
                if (textHeight < 30) {
                    
                    textHeight = 30;
                }
                
                cell.contentTextHeight.constant = textHeight;
                
                
                
                
                //图片view  高度
                
                
                cell.contentView.tag = indexPath.section;
                
                
                
                if (_yellmodel.photos)
                {
                    
                    imageView.photoItemArray = _yellmodel.photos;
                    
                }
                
                
                
                CGFloat photoViewHeight = 0;
                
                
                NSArray *imgs =_yellmodel.photos;
                
                long imageCount = imgs.count;
                int perRowImageCount = ((imageCount == 4) ? 2 : 3);
                CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
                int totalRowCount = ceil(imageCount / perRowImageCountF);
                photoViewHeight  = 95 * totalRowCount;
                
                
                cell.photoViewHeight.constant = photoViewHeight;
                
                
                
                timeLabel.text = [CommonMethods timeStringFromNow:_yellmodel.yellObject.createdAt];
                
                
                
                //性别
                NSInteger user_sex = [[weibouser objectForKey:@"user_sex"]integerValue];
                
                if (user_sex == 1) {
                    
                    sexImageview.image = [UIImage imageNamed:@"male"];
                    
                }
                else
                {
                    sexImageview.image = [UIImage imageNamed:@"female"];
                    
                }
                
                
                
                UILabel *fromlabel = (UILabel*)[cell viewWithTag:107];
                
                UILabel *distanceLabel = (UILabel*)[cell viewWithTag:108];
                
                UIButton *likeButton = (UIButton*)[cell viewWithTag:109];
                
                UILabel *likeNumLabel = (UILabel*)[cell viewWithTag:110];
                
                UILabel *commentNumlabel = (UILabel*)[cell viewWithTag:111];
                
                [likeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
                
                fromlabel.text = [_yellmodel.yellObject objectForKey:@"build_model"];
                
                NSInteger commentNum = [[_yellmodel.yellObject objectForKey:@"comment_total"]integerValue];
                NSInteger totalNum = [[_yellmodel.yellObject objectForKey:@"zan_total"]integerValue];
                
                commentNumlabel.text = [NSString stringWithFormat:@"%ld",(long)commentNum];
                
                likeNumLabel.text = [NSString stringWithFormat:@"%ld",(long)totalNum];
                
                BmobGeoPoint *point = [_yellmodel.yellObject objectForKey:@"location"];
                
                double distance = [CommonMethods distanceFromLocation:point.latitude longitude:point.longitude];
                
                
                if (distance > 1000) {
                    
                    distance = distance/1000.0;
                    
                    distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",distance];
                }
                else
                {
                    distanceLabel.text = [NSString stringWithFormat:@"%.0fm",distance];
                    
                    
                }
                
                BOOL hideInfo = [[_yellmodel.yellObject objectForKey:@"hide_info"]boolValue];
                
                
                //匿名 隐藏信息
                if (hideInfo) {
                    
                    [headbutton removeTarget:self action:@selector(showWeiboUser) forControlEvents:UIControlEventTouchUpInside];
                    
                    headTitle.text = @"匿名";
                    cell.nameLabelWithConstrain.constant = 30;
                    
                    distanceLabel.text = @"0.0km";
                    
                    [headbutton setImage:[UIImage imageNamed:@"head_default"] forState:UIControlStateNormal];
                    
                }
                
            });
            
            return cell;
            
        }
            break;
            
            
        default:
        {
            
          CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
            
          BmobObject *commentObject = [_commentArray objectAtIndex:indexPath.section -1];
            
           BmobUser *user = [commentObject objectForKey:@"from_user"];
            
            NSString *content = [commentObject objectForKey:@"comment_content"];
            
            CGFloat textHeight = [StringHeight heightWithText:content font:FONT_17 constrainedToWidth:ScreenWidth - 80];
            
            if (textHeight < 21)
            {
                
                textHeight = 21;
                
                
            }
            
            cell.contentheightConstraint.constant = textHeight;
            cell.contentLabel.text = content;
            
            cell.contentView.tag = indexPath.section;
            
            NSString *name = [user objectForKey:@"nick"];
            NSString *avatar = [user objectForKey:@"avatar"];
            NSInteger user_level = [[user objectForKey:@"user_level"]integerValue];
            
            [cell.headButton sd_setImageWithURL:[NSURL URLWithString:avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head_default"]];
            
            cell.headButton.clipsToBounds = YES;
            cell.headButton.layer.cornerRadius = 25;
            [cell.headButton addTarget:self action:@selector(showreplayUser:) forControlEvents:UIControlEventTouchUpInside];
            
            
            cell.nameLabel.text = name;
            
            CGFloat nickWith = [StringHeight widthtWithText:name font:FONT_16 constrainedToHeight:21];
            
            cell.nameWithContraint.constant = nickWith;
            
            if (user_level == 2) {
                
                cell.vipImageView.hidden = NO;
            }
            else
            {
                cell.vipImageView.hidden = YES;
                
            }
            
            
            return cell;
            
            
        }
            break;
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)setBottomView
{
    CGFloat bottomViewOrginY = 0.0f;
    
    if (IS_iOS7) {
        bottomViewOrginY = ScreenHeight-44;
    }else{
        bottomViewOrginY = ScreenHeight -64-44;
    }
    
    _bottomView                           = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewOrginY, ScreenWidth, 144)];
    _bottomView.backgroundColor = kLineColor;
    
    [self.navigationController.view addSubview:_bottomView];
    
    
    //输入框
    _replayTextField                        = [[UITextField alloc] initWithFrame:CGRectMake(60, 8, ScreenWidth - 60 - 80, 30)];
    _replayTextField.font                   = FONT_15;
    _replayTextField.delegate               = self;
    _replayTextField.returnKeyType          = UIReturnKeySend;
    _replayTextField.backgroundColor        = [UIColor whiteColor];
    _replayTextField.clipsToBounds = YES;
    _replayTextField.layer.cornerRadius = 5;
    [_bottomView addSubview:_replayTextField];
    
    //    表情
    _emojiView                            = [[EmojiView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 100)];
    _emojiView.backgroundColor            = [UIColor whiteColor];
    _emojiView.delegate                   = self;
    [_emojiView createEmojiView];
    
    _emojiView.hidden = YES;
    
    [_bottomView addSubview:_emojiView];
    
    
    //显示表情
    UIButton    *emojiButton              = [UIButton buttonWithType:UIButtonTypeCustom];
    emojiButton.tag                       = 100;
    [emojiButton setFrame:CGRectMake(5, 0, 50, 44)];
    [emojiButton addTarget:self action:@selector(showEmojiView) forControlEvents:UIControlEventTouchUpInside];
    [emojiButton setImage:[UIImage imageNamed:@"chat_icon2"] forState:UIControlStateNormal];
    [emojiButton setImage:[UIImage imageNamed:@"chat_icon2_"] forState:UIControlStateHighlighted];
    [_bottomView addSubview:emojiButton];
    
    //发送
    UIButton *sendButton = [[UIButton alloc]initWithFrame:CGRectMake(_replayTextField.frame.origin.x + CGRectGetWidth(_replayTextField.frame) + 5, 0, 50, 44)];
    [sendButton setTitle:@"回复" forState:UIControlStateNormal];
    [sendButton setTitleColor:kBlueColor forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [sendButton addTarget:self action:@selector(sendReplay:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView addSubview:sendButton];
    
    

}

-(void)showEmojiView
{
   
    [_replayTextField resignFirstResponder];
    
    
    CGFloat bottomViewOrginY = 0.0f;
    
    if (IS_iOS7) {
        bottomViewOrginY = ScreenHeight-144;
    }else{
        bottomViewOrginY = ScreenHeight -64-144;
    }
    
    _emojiView.hidden = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect oldFrame = _bottomView.frame;
        
        _bottomView.frame = CGRectMake(oldFrame.origin.x, bottomViewOrginY, oldFrame.size.width, oldFrame.size.height);
        
        
        
    }];
    
    
}

#pragma mark - 发送回复
-(void)sendReplay:(UIButton*)sender
{
    
    [_replayTextField resignFirstResponder];
    
    if (_replayTextField.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请输入回复内容"];
        return;
        
    }
    
    BmobUser *currentUser = [BmobUser getCurrentUser];
    
    
    BmobObject *replayObject = [BmobObject objectWithClassName:kCommentList];
    
    [replayObject setObject:_replayTextField.text forKey:@"comment_content"];
    
    [replayObject setObject:currentUser forKey:@"from_user"];
    [replayObject setObject:self.yellmodel.yellObject forKey:@"items"];
    
    
    [replayObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
            
            [MyProgressHUD showError:@"评论成功"];
            
            _replayTextField.text = nil;
            
//            BmobObject *object = [BmobObject objectWithoutDatatWithClassName:kWeiboListItem objectId:_yellmodel.yellObject.objectId];
//            
//            [object incrementKey:@"comment_total"];
//            [object saveInBackground];
            
            BmobUser *user = [_yellmodel.yellObject objectForKey:@"user"];
//
            NSInteger cmment_total = [[_yellmodel.yellObject objectForKey:@"comment_total"]integerValue];
            
            cmment_total ++;
            [_yellmodel.yellObject setObject:@(cmment_total) forKey:@"comment_total"];
//
//          
            [_yellmodel.yellObject setObject:user forKey:@"user"];
//            BmobRelation *relation = [BmobRelation relation];
//            
//          
//            [_yellmodel.yellObject addRelation:relation forKey:@"attachItem"];
            
//            [_yellmodel.yellObject incrementKey:@"comment_total"];
            
            BmobRelation *commentRelation = [BmobRelation relation];
            [commentRelation addObject:replayObject];
            
            [_yellmodel.yellObject addRelation:commentRelation forKey:@"commentitem"];
            
            
            [_yellmodel.yellObject updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                if (isSuccessful)
                {
                    
                     [self getCommentList];
                }
                else
                {
                    NSLog(@"error:%@",error);
                    
                    [self getCommentList];
                    
                }
            }];
            
           
           
            
            
            
        }
        else
        {
            [MyProgressHUD showError:@"评论失败"];
            
        }
    }];
    
    
    
}

-(void)keyBoardShow:(NSNotification*)note
{
    
    [self.view addGestureRecognizer:_tapResign];
    
    if (note)
    {
        _emojiView.hidden = YES;
        
        NSValue *keyboardBoundsValue = [[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardEndRect = [keyboardBoundsValue CGRectValue];
        
        CGFloat bottomViewOrginY = 0.0f;
        
        if (IS_iOS7) {
            bottomViewOrginY = ScreenHeight-44-keyboardEndRect.size.height;
        }else{
            bottomViewOrginY = ScreenHeight-64-44-keyboardEndRect.size.height;
        }
        
        
        [UIView animateWithDuration:0.2 animations:^{
           
            CGRect oldFrame = _bottomView.frame;
            
            _bottomView.frame = CGRectMake(oldFrame.origin.x, bottomViewOrginY, oldFrame.size.width, oldFrame.size.height);
            
        
            
        }];
        
        
        
    }
}

-(void)keyBoardHide:(NSNotification*)note
{
    if (note)
    {
     
        
        CGFloat bottomViewOrginY = 0.0f;
        
        if (IS_iOS7) {
            bottomViewOrginY = ScreenHeight-44;
        }else{
            bottomViewOrginY = ScreenHeight -64-44;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect oldFrame = _bottomView.frame;
            
            _bottomView.frame = CGRectMake(oldFrame.origin.x, bottomViewOrginY, oldFrame.size.width, oldFrame.size.height);
            
            
            
        }];
        
        
        
    }

}

#pragma mark - EmojiViewDelegate
-(void)didSelectEmojiView:(EmojiView *)view emojiText:(NSString *)text
{
    _replayTextField.text = [_replayTextField.text stringByAppendingString:text];
//    _replayTextField.text = [CommonUtil turnStringToEmojiText:_replayTextField.text];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    
    return NO;
}

-(void)showWeiboUser
{
   
    
    UserDetailTVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetailTVC"];
    
    detailVC.fromType = FromTypeFriendList;
    
    detailVC.user =weibouser;
    
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)showreplayUser:(UIButton*)sender
{
    CommentCell *cell = (CommentCell*)[sender superview];
    
    BmobObject *replayObject = [_commentArray objectAtIndex:cell.tag - 1];
    
    BmobUser *user = [replayObject objectForKey:@"from_user"];
    
    UserDetailTVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetailTVC"];
    
    detailVC.fromType = FromTypeFriendList;
    
    detailVC.user =user;
    
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


-(void)likeAction:(UIButton*)sender
{
  
    
    NSString *objectId = _yellmodel.yellObject.objectId;
    
    BmobUser *currentUser = [BmobUser getCurrentUser];
    
    NSString *userObjectId = currentUser.objectId;
    
    NSArray *zanArray = [[NSUserDefaults standardUserDefaults ] objectForKey:kZanList];
    
    BOOL finalZan = YES;
    
    if (zanArray)
    {
        NSMutableArray *muZanArray = [[NSMutableArray alloc]initWithArray:zanArray];
        
        
        
        
        BOOL had = NO;
        
        for (int i = 0 ; i < zanArray.count; i ++) {
            
            NSDictionary *dict = [zanArray objectAtIndex:i];
            
            NSString *temObjectId = [dict objectForKey:@"weiboObjectId"];
            NSString *temuserObjectId = [dict objectForKey:@"userObjectId"];
            
            if ([temObjectId isEqualToString:objectId] && [temuserObjectId isEqualToString:userObjectId]) {
                
                BOOL hadzan = [[dict objectForKey:@"hadzan"]boolValue];
                
                if (hadzan) {
                    
                    hadzan = NO;
                    
                    finalZan = NO;
                    
                }
                else
                {
                    hadzan = YES;
                    
                    
                    
                }
                
                NSMutableDictionary *mudict = [[NSMutableDictionary alloc]initWithDictionary:dict];
                [mudict setObject:@(hadzan) forKey:@"hadzan"];
                
                [muZanArray replaceObjectAtIndex:i withObject:mudict];
                
                
                had = YES;
                
            }
        }
        
        
        if (!had)
        {
            
            
            
            NSDictionary *dict = @{@"weiboObjectId":objectId,@"userObjectId":userObjectId,@"hadzan":@YES};
            
            [muZanArray addObject:dict];
            
        }
        
        [[NSUserDefaults standardUserDefaults ] setObject:muZanArray forKey:kZanList];
        [[NSUserDefaults standardUserDefaults ] synchronize];
        
        
    }
    else
    {
        NSArray *zanArray = @[@{@"weiboObjectId":objectId,@"userObjectId":userObjectId,@"hadzan":@YES}];
        
        [[NSUserDefaults standardUserDefaults ] setObject:zanArray forKey:kZanList];
        [[NSUserDefaults standardUserDefaults ] synchronize];
        
        
        
        
    }
    
    
    
    BmobObject *object = [BmobObject objectWithoutDatatWithClassName:kWeiboListItem objectId:_yellmodel.yellObject.objectId];
    
    if (finalZan) {
        
        [object incrementKey:@"zan_total"];
    }
    else
    {
        
            
      [object decrementKey:@"zan_total"];
            
        
        
        
    }
    
    [MyProgressHUD showProgress];
    
    [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        
        if (isSuccessful)
        {
            
            BmobQuery *query = [BmobQuery queryWithClassName:kWeiboListItem];
            [query includeKey:@"user"];
            [query whereKey:@"objectId" equalTo:object.objectId];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (array) {
                    
                    BmobObject *firstObject = [array firstObject];
                    _yellmodel.yellObject = firstObject;
                    
                    [self.tableView reloadData];
                    
                }
                
                [MyProgressHUD dismiss];
                
            }];
            

            
        }
        
        
        if (error) {
            
            NSLog(@"error:%@",error);
            [MyProgressHUD dismiss];
            
        }
        
    }];
}

-(BOOL)hadZan:(BmobObject*)weiboObject
{
    NSString *objectId = weiboObject.objectId;
    
    BmobUser *currentUser = [BmobUser getCurrentUser];
    
    NSString *userObjectId = currentUser.objectId;
    
    NSArray *zanArray = [[NSUserDefaults standardUserDefaults ] objectForKey:kZanList];
    
    if (zanArray)
    {
        
        for (int i = 0 ; i < zanArray.count; i ++) {
            
            NSDictionary *dict = [zanArray objectAtIndex:i];
            
            NSString *temObjectId = [dict objectForKey:@"weiboObjectId"];
            NSString *temuserObjectId = [dict objectForKey:@"userObjectId"];
            BOOL hadZan = [[dict objectForKey:@"hadzan"]boolValue];
            
            
            if ([temObjectId isEqualToString:objectId] && [temuserObjectId isEqualToString:userObjectId] && hadZan) {
                
                
                return YES;
                
            }
        }
        
    }
    
    return NO;
    
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
