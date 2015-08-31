//
//  UserDetailTVC.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/19.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "UserDetailTVC.h"
#import "ChatViewController.h"

@interface UserDetailTVC ()<SDPhotoBrowserDelegate>
{
    BmobUser *targetUser;
    
    UIView *_rightView;
    
    UIImage *headimage;
    
    
}
@end

@implementation UserDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详细资料";
    
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 70);
    
    self.footerView.frame = CGRectMake(0, 0, ScreenWidth, 180);
    
    if ([_user.username isEqualToString:[BmobUser getCurrentUser].username]) {
        
        
        _sendMesButton.hidden = YES;
        _phoneCallButton.hidden = YES;
        
    }
    switch (_fromType) {
        case FromTypeFriendList:
        {
            [_sendMesButton setTitle:@"发送消息" forState:UIControlStateNormal];
        }
            break;
        case FromTypeNear:
        {
            [_sendMesButton setTitle:@"发送好友请求" forState:UIControlStateNormal];
            
            _phoneCallButton.hidden = YES;
            
            
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    
    
    _rightView = [self getRightVeiw];
    
    
    
    [self getUserInfo];
    
}

-(void)getUserInfo
{
    BmobQuery *query = [BmobQuery queryWithClassName:kUser ];
  
    [query whereKey:@"username" equalTo:self.user.username];
    
    NSLog(@"username:%@",[self.user objectForKey:@"username"]);
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        if (array.count > 0) {
            
            targetUser = [array firstObject];
            
            [self setupViews];
            
        }
        
    }];
    
}
-(void)setupViews
{
   
    int i = arc4random()%10;
    
    NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
    
    [self.headButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[targetUser objectForKey:@"avatar"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:headString]];
    
    

    self.nickLabel.text = [targetUser objectForKey:@"nick"];
    NSString *username = [CommonMethods geteditedmobile:targetUser.username];
    self.usernameLabel.text = [NSString stringWithFormat:@"牵手号:%@",username];
    
    self.addressLabel.text = [targetUser objectForKey:@"user_city"];
    
    self.desLabel.text = [targetUser objectForKey:@"user_individuality_signature"];
    
    self.ageLabel.text = [NSString stringWithFormat:@"%@",[targetUser objectForKey:@"agent_user"]];
    
   

    
    
    
}


#pragma mark- 加入黑名单 删除好友 View
- (UIView *)getRightVeiw{
    
    CGFloat width = 100;
    CGFloat height = 80;
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-width-2, 2, width, height)];
    greenView.backgroundColor = kBlueColor;
    
    [CommonMethods addLine:15 startY:height/2 color:[UIColor whiteColor] toView:greenView];
   
    
    
    UIButton *femaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, height/2)];
    femaleBtn.backgroundColor = [UIColor clearColor];
    [femaleBtn setTitle:@"加入黑名单" forState:UIControlStateNormal];
    [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    femaleBtn.titleLabel.font = FONT_15;
    [femaleBtn addTarget:self action:@selector(addToBlackList) forControlEvents:UIControlEventTouchUpInside];
    [greenView addSubview:femaleBtn];
    
    UIButton *maleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, height/2, width, height/2)];
    maleBtn.backgroundColor = [UIColor clearColor];
    [maleBtn setTitle:@"删除好友" forState:UIControlStateNormal];
    [maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    maleBtn.titleLabel.font = FONT_15;
    [maleBtn addTarget:self action:@selector(deleteFriend) forControlEvents:UIControlEventTouchUpInside];
    [greenView addSubview:maleBtn];
    
    UIControl *backView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight- 64)];
    
    backView.backgroundColor = kTransParentBackColor;
    
    [backView addTarget:self action:@selector(dismissRightView) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:greenView];
    
    
    
    return backView;
}

-(void)dismissRightView
{
    [_rightView removeFromSuperview];
    
}

-(void)addToBlackList
{
    
    
}


-(void)deleteFriend
{
    [[BmobUserManager currentUserManager] deleteContactWithUid:targetUser.objectId block:^(BOOL isSuccessful, NSError *error) {
        
        [MyProgressHUD dismiss];
        
        if (isSuccessful)
        {
            
            [CommonMethods showDefaultErrorString:@"好友删除成功"];
            
        
        }
        else
        {
          [CommonMethods showDefaultErrorString:@"好友删除失败 "];
            
            NSLog(@"error:%@",error);
            
            
        }
        
    }];
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

#pragma mark - 发送添加好友信息 、开始聊天
- (IBAction)sendAction:(id)sender {
    
    
    switch (_fromType) {
        case FromTypeNear:
        {
            
            BOOL isSeal = [[targetUser objectForKey:@"seal_up"]boolValue];
            if (isSeal) {
                
                [CommonMethods showDefaultErrorString:@"该用户已设置不能添加好友"];
                
                return;
                
                
            }
            
            
            [MyProgressHUD showProgress];
            
            [[BmobChatManager currentInstance] sendMessageWithTag:TAG_ADD_CONTACT targetId:targetUser.objectId block:^(BOOL isSuccessful, NSError *error) {
                
                [MyProgressHUD dismiss];
                
                if (isSuccessful) {
                    NSLog(@"send requst success!");
                    
                    [CommonMethods showDefaultErrorString:@"好友请求发送成功"];
                    
                }else{
                    
                    [CommonMethods showDefaultErrorString:@"好友请求发送失败"];
                    NSLog(@"send requst fail:%@!",error);
                    
                    
                }
            }];
        }
            break;
            
        case FromTypeFriendList:
        {
            NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
            BmobChatUser *user = (BmobChatUser *)self.user;
            [infoDic setObject:user.objectId forKey:@"uid"];
            [infoDic setObject:user.username forKey:@"name"];
            NSString *avatar = [user objectForKey:@"avatar"];
            NSString *nick = [user objectForKey:@"nick"];
            
            if (avatar) {
                [infoDic setObject:avatar forKey:@"avatar"];
            }
            if (nick) {
                [infoDic setObject:nick forKey:@"nick"];
            }
            ChatViewController *cvc = [[ChatViewController alloc] initWithUserDictionary:infoDic];
            cvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        
            
        default:
            break;
    }
    
}

- (IBAction)phoneCallAction:(id)sender {
    
    [CommonMethods callPhoneWithSuperView:self.view phoneNum:targetUser.username];
    
    
}

- (IBAction)showRightAction:(id)sender {
    
    if (_rightView.superview) {
        
        [_rightView removeFromSuperview];
        
    }
    else
    {
         [self.view addSubview:_rightView];
    }
    
}

- (IBAction)showHeadView:(id)sender {
    
    NSString *avatar = [targetUser objectForKey:@"avatar"];
    
    if (avatar) {
        
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.sourceImagesContainerView = self.headButton; // 原图的父控件
        browser.imageCount = 1; // 图片总数
        browser.currentImageIndex = 0;
        browser.delegate = self;
        [browser show];
    }
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
   
    
    return self.headButton.currentBackgroundImage;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [targetUser objectForKey:@"avatar"];
    return [NSURL URLWithString:urlStr];
}
@end
