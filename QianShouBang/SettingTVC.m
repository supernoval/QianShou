//
//  SettingTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "SettingTVC.h"
#import "RowTextCell.h"
#import "AccountManageTVC.h"
#import "PrivacyTVC.h"
#import "GeneralTVC.h"
#import "AboutQianShouBangTVC.h"
#import "LoginViewController.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
//#import <ShareSDK/ShareSDK+Base.h>

@interface SettingTVC ()
/**
 *  面板
 */
@property (nonatomic, strong) UIView *panelView;

/**
 *  加载视图
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation SettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self tableFooterView];
    
    //加载等待视图
    self.panelView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.panelView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.panelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingView.frame = CGRectMake((self.view.frame.size.width - self.loadingView.frame.size.width) / 2, (self.view.frame.size.height - self.loadingView.frame.size.height) / 2, self.loadingView.frame.size.width, self.loadingView.frame.size.height);
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.panelView addSubview:self.loadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 2;
    }else{
        return 1;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    headView.backgroundColor = [UIColor clearColor];
    
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"RowTextCell";
    RowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RowTextCell" owner:self options:nil][0];
    }
    cell.extraText.hidden = YES;
    if (indexPath.section == 0) {
        cell.text.text = @"账户管理";
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.text.text = @"隐私";
        }else if(indexPath.row == 1){
            cell.text.text = @"通用";
        }
    }else if(indexPath.section == 2){
        cell.text.text = @"分享";
    }else if(indexPath.section == 3){
        cell.text.text = @"关于牵手帮";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {//账户管理
                AccountManageTVC *accountTVC = [sb instantiateViewControllerWithIdentifier:@"AccountManageTVC"];
                [self.navigationController pushViewController:accountTVC animated:YES];
            }
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0) {//隐私
                PrivacyTVC *privacyTVC = [sb instantiateViewControllerWithIdentifier:@"PrivacyTVC"];
                [self.navigationController pushViewController:privacyTVC animated:YES];
            }else if (indexPath.row == 1){//通用
                GeneralTVC *generalTVC = [sb instantiateViewControllerWithIdentifier:@"GeneralTVC"];
                [self.navigationController pushViewController:generalTVC animated:YES];
                
                
            }
        }
            break;
            
        case 2:
        {//分享
//            [self showShareActionSheet:self.view];
            
        }
            break;
            
        case 3:
        {
            AboutQianShouBangTVC *aboutTVC = [sb instantiateViewControllerWithIdentifier:@"AboutQianShouBangTVC"];
            [self.navigationController pushViewController:aboutTVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma 退出登录
- (UIView *)tableFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    footerView.backgroundColor = kBackgroundColor;
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth, 40)];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:kContentColor];
    logoutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    logoutBtn.titleLabel.font = FONT_16;
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logoutBtn];
    return footerView;
}

- (void)logout:(UIButton *)button{
    
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:kHadLogin];
    [[NSUserDefaults standardUserDefaults ] synchronize];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    
    LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
     [BmobUser logout];
}

/*
- (void)showShareActionSheet:(UIView *)view
{
    
    __weak SettingTVC *theController = self;
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    //1.2、自定义分享平台（非必要）
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    //添加一个自定义的平台（非必要）
    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Icon.png"]
                                                                                  label:@"自定义"
                                                                                onClick:^{
                                                                                    
                                                                                    //自定义item被点击的处理逻辑
                                                                                    NSLog(@"=== 自定义item被点击 ===");
                                                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"自定义item被点击"
                                                                                                                                        message:nil
                                                                                                                                       delegate:nil
                                                                                                                              cancelButtonTitle:@"确定"
                                                                                                                              otherButtonTitles:nil];
                                                                                    [alertView show];
                                                                                }];
    [activePlatforms addObject:item];
    
    //设置分享菜单栏样式（非必要）
    //        [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:249/255.0 green:0/255.0 blue:12/255.0 alpha:0.5]];
    //        [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor whiteColor]];
    //        [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
    //        [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
    //        [SSUIShareActionSheetStyle setCurrentPageIndicatorTintColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]];
    //        [SSUIShareActionSheetStyle setPageIndicatorTintColor:[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]];
    
    //    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:activePlatforms
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       [theController showLoadingView:NO];
                       [theController.tableView reloadData];
                   }
                   
               }];
    //    NSArray *itemArray = [[NSArray alloc]init];
    //    itemArray = @[@(SSDKPlatformTypeTencentWeibo),@(SSDKPlatformTypeRenren),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat)];
    //    [itemArray addObject:@(SSDKPlatformTypeTencentWeibo)];
    //    [itemArray addObject:@(SSDKPlatformTypeQQ)];
    //    [itemArray addObject:item];
    //    SSUIShareActionSheetController *sheet = [[SSUIShareActionSheetController alloc]initWithItems:itemArray];
    //    [sheet initWithItems:itemArray];
    //另附：设置跳过分享编辑页面，直接分享的平台。
    //        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
    //                                                                         items:itemArray
    //                                                                   shareParams:shareParams
    //                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
    //                                                           }];
    
    
    //
    //        //删除和添加平台示例
    //        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    //    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeWechat)];
    //    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeTencentWeibo)];
    //    [sheet showInView:self.view];
}*/

#pragma mark -

/**
 *  显示加载动画
 *
 *  @param flag YES 显示，NO 不显示
 */
- (void)showLoadingView:(BOOL)flag
{
    if (flag)
    {
        [self.view addSubview:self.panelView];
        [self.loadingView startAnimating];
    }
    else
    {
        [self.panelView removeFromSuperview];
    }
}


@end
