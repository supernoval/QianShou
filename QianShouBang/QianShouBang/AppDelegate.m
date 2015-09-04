//
//  AppDelegate.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Constants.h"
#import <SMS_SDK/SMS_SDK.h>
#import <BmobSDK/Bmob.h>
#import <BmobIM/BmobIM.h>
#import <AlipaySDK/AlipaySDK.h>
#import "NotificationKey.h"

#import "Constants.h"
#import <CoreLocation/CoreLocation.h>
#import "UserService.h"
#import "JSONModel.h"
#import "SBJSON.h"
#import "CommonMethods.h"
#import "GuideViewController.h"


//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import "WXApi.h"
//#import "WeiboSDK.h"
//#import <RennSDK/RennSDK.h>

@interface AppDelegate ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    application.applicationIconBadgeNumber = 0;
    
    //设置naigationbar 背景颜色和字体颜色
    [[UINavigationBar appearance] setBarTintColor:NavigationBarColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [[UITabBar appearance] setTintColor:NavigationBarColor];
    
    //remoteNotification  远程通知
    
    
    //bmob
    [Bmob registerWithAppKey:kBmobApplicationID];
    [BmobChat registerAppWithAppKey:kBmobApplicationID];
    

    
    //用户存在就创建数据库 并获取和保存好友
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        
        [UserService saveFriendsList];
        
        
    }else{
        
    }
    
    //sharesdk sms 注册
    [SMS_SDK registerApp:kShareSDKSMSAppKey withSecret:kShareSDKSMSAppSecret];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
    }
    
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
    
    //定位
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {//ios8以后
        [_locationManager requestWhenInUseAuthorization];
//        [_locationManager requestAlwaysAuthorization];
    }
    else
    {
        [_locationManager startUpdatingLocation];
    }
    
    
    //shareSDK
    /*
    [ShareSDK registerApp:@"iosv1101"
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeDouBan),
                            @(SSDKPlatformTypeRenren),
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeRenren:
                             [ShareSDKConnector connectRenren:[RennClient class]];
                             break;
                             
                        default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTencentWeibo:
                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                                 redirectUri:@"http://www.sharesdk.cn"];
                      break;
                 
                 
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      break;
                      
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeBoth];
                      break;
                      
                  case SSDKPlatformTypeDouBan:
                      [appInfo SSDKSetupDouBanByApiKey:@"02e2cbe5ca06de5908a863b15e149b0b"
                                                secret:@"9f1e7b4f71304f2f"
                                           redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeRenren:
                      [appInfo SSDKSetupRenRenByAppId:@"226427"
                                               appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                            secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                             authType:SSDKAuthTypeBoth];
                      break;
                
                  
                 
                  default:
                      break;
              }
          }];*/


    
    return YES;
}

#ifdef __IPHONE_8_0

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
    
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    
}
#endif


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *dToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    dToken = [dToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
        NSLog(@"STR:%@",dToken);
    
    
    if (dToken)
    {
        [BmobChat regisetDeviceWithDeviceToken:deviceToken];
        
        BmobUser *user = [BmobUser getCurrentUser];
        if (user)
        {
            
//            [user setObject:dToken forKey:@"installId"];
//            [[BmobUserManager currentUserManager] bindDeviceToken:[[NSUserDefaults standardUserDefaults] dataForKey:kDeviceTokenData]];
            
//            [user updateInBackground];
            
            
        }
        
        [[NSUserDefaults standardUserDefaults ] setObject:deviceToken forKey:kDeviceTokenData];
        
        [[NSUserDefaults standardUserDefaults ] setObject:dToken forKey:kDeviceTokenKey];
        
        [[NSUserDefaults standardUserDefaults ] synchronize];
        
    }
    
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Registfail%@",error);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
     application.applicationIconBadgeNumber = 0;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"%s,url.host:%@",__func__,url.host);
    
    
    
    
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             
             NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"]integerValue];
             
             if (resultStatus == 9000) {
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kPaySucessNotification object:nil];
                 
             }
             else
             {
                 
                 NSString *memo = [resultDic objectForKey:@"memo"];
                 if (memo.length == 0) {
                     
                     memo = @"支付失败";
                 }
                 
                 
                 [[[UIAlertView alloc]initWithTitle:nil message:memo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
                 
                 
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kPayFailNotification object:nil];
                 //
             }
         }];
    }
    
    return YES;
    
}




#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||  status == kCLAuthorizationStatusAuthorizedAlways) {
        
        [_locationManager startUpdatingLocation];;
        
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults ] objectForKey:@"FirstLaunch"]boolValue]) {
            
            [[[UIAlertView alloc]initWithTitle:nil message:@"无法定位，请在 设置－隐私－定位服务 里开启对《牵手邦》的定位允许" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show ];
        }
       
        
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *location in locations) {
        
        [self locateLocation:location];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)locateLocation:(CLLocation *)location {
    
  CLGeocoder *_myGeocoder = [[CLGeocoder alloc] init];

 
    [_myGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            //这时的placemarks数组里面只有一个元素
            CLPlacemark * placemark = [placemarks firstObject];
          
//            NSLog(@"=========== addressDictionary:%@", placemark.addressDictionary);
        

            
            NSString *name =placemark.name;
            
            [[NSUserDefaults standardUserDefaults ] setObject:name forKey:kUserAddress];
            
            [[NSUserDefaults standardUserDefaults ] setFloat:location.coordinate.latitude forKey:kGPSLocationLatitude];
            [[NSUserDefaults standardUserDefaults ] setFloat:location.coordinate.longitude forKey:kGPSLoactionLongitude];
            [[NSUserDefaults standardUserDefaults ] synchronize];
            
            
            [_locationManager stopUpdatingLocation];
            
            
            //更新用户地理位置
            BmobUser *user = [BmobUser getCurrentUser];
            
            if (user)
            {
                
                BmobGeoPoint *mylocation = [[BmobGeoPoint alloc]initWithLongitude:location.coordinate.longitude WithLatitude:location.coordinate.latitude];
                
                [user setObject:mylocation forKey:@"location"];
                
                [user updateInBackground];
                
                
            }
        }
    }];
    
    /*
     city:上海市市辖区  城市
     country:中国    国家
     name:中国上海市徐汇区漕河泾街道漕河泾田东路  具体地址
     state:上海市   省份
     street:田东路  街道完整名称
     sublocaality:徐汇区  区名
     subthoroughfare:(null)
     thoroughfare:田东路 街道
     */
    /*
     dic Name = 宏润国际花园(西区)
     dic State = 上海市
     dic Street = 漕东支路 218弄
     dic SubLocality= 徐汇区
     dic SubThoroughfare= 218弄
     dic Thoroughfare = 漕东支路
     */
    
    
    /*
     {
     City = "\U4e0a\U6d77\U5e02\U5e02\U8f96\U533a";
     Country = "\U4e2d\U56fd";
     CountryCode = CN;
     FormattedAddressLines =     (
     "\U4e2d\U56fd\U4e0a\U6d77\U5e02\U5f90\U6c47\U533a\U6f15\U6cb3\U6cfe\U8857\U9053\U6f15\U4e1c\U652f\U8def218\U5f04"
     );
     Name = "\U5b8f\U6da6\U56fd\U9645\U82b1\U56ed(\U897f\U533a)";
     State = "\U4e0a\U6d77\U5e02";
     Street = "\U6f15\U4e1c\U652f\U8def 218\U5f04";
     SubLocality = "\U5f90\U6c47\U533a";
     SubThoroughfare = "218\U5f04";
     Thoroughfare = "\U6f15\U4e1c\U652f\U8def";
     }
     
     
     */
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"userInfo is :%@",[userInfo description]);
    
    if ([userInfo objectForKey:@"tag"]) {
        if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@"add"]) {
            [self saveInviteMessageWithAddTag:userInfo];
            [BmobPush handlePush:userInfo];
        } else if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@"agree"]) {
            [self saveInviteMessageWithAgreeTag:userInfo];
        } else if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@""]) {
            [self saveMessageWith:userInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DidRecieveUserMessage" object:userInfo];
        }
    }
     else
     {
         NSDictionary *aps = [userInfo objectForKey:@"aps"];
         
         NSString  *orderStr = [userInfo objectForKey:@"order"];
         
         JSONModel *model = [[JSONModel alloc]initWithString:orderStr error:nil];
         
         NSDictionary *order = [model toDictionary];
         
         NSLog(@"=========order:%@",order);
         
         NSInteger state = [[userInfo objectForKey:@"state"]integerValue];
         
         
         NSString *msg = [aps objectForKey:@"alert"];
         
         [CommonMethods showDefaultErrorString:msg];
         
         
         
     }
    
}

//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    
//    NSLog(@"%s,userInfo is :%@",__func__,[userInfo description]);
//    
//    if ([userInfo objectForKey:@"tag"]) {
//        if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@"add"]) {
//            [self saveInviteMessageWithAddTag:userInfo];
//            [BmobPush handlePush:userInfo];
//        } else if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@"agree"]) {
//            [self saveInviteMessageWithAgreeTag:userInfo];
//        } else if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@""]) {
//            [self saveMessageWith:userInfo];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"DidRecieveUserMessage" object:userInfo];
//        }
//    }
//}


#pragma mark save
-(void)saveInviteMessageWithAddTag:(NSDictionary *)userInfo{
    BmobInvitation *invitation = [[BmobInvitation alloc] init];
    invitation.avatar          = [[userInfo objectForKey:PUSH_ADD_FROM_AVATAR] description];
    invitation.fromId          = [[userInfo objectForKey:PUSH_ADD_FROM_ID] description];
    invitation.fromname        = [[userInfo objectForKey:PUSH_ADD_FROM_NAME] description];
    invitation.nick            = [[userInfo objectForKey:PUSH_ADD_FROM_NICK] description];
    invitation.time            = [[userInfo objectForKey:PUSH_ADD_FROM_TIME] integerValue];
    invitation.statue          = STATUS_ADD_NO_VALIDATION;
    [[BmobDB currentDatabase] saveInviteMessage:invitation];
}

-(void)saveInviteMessageWithAgreeTag:(NSDictionary *)userInfo{
    BmobInvitation *invitation = [[BmobInvitation alloc] init];
    invitation.avatar          = [[userInfo objectForKey:PUSH_ADD_FROM_AVATAR] description];
    invitation.fromId          = [[userInfo objectForKey:PUSH_ADD_FROM_ID] description];
    invitation.fromname        = [[userInfo objectForKey:PUSH_ADD_FROM_NAME] description];
    invitation.nick            = [[userInfo objectForKey:PUSH_ADD_FROM_NICK] description];
    invitation.time            = [[userInfo objectForKey:PUSH_ADD_FROM_TIME] integerValue];
    invitation.statue          = STATUS_ADD_AGREE;
    
    [[BmobDB currentDatabase] saveInviteMessage:invitation];
    [[BmobDB currentDatabase] saveContactWithMessage: invitation];
    
    //添加到用户的好友关系中
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        BmobUser *friendUser   = [BmobUser objectWithoutDatatWithClassName:@"User" objectId:invitation.fromId];
        BmobRelation *relation = [BmobRelation relation];
        [relation addObject:friendUser];
        [user addRelation:relation forKey:@"contacts"];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (error) {
                NSLog(@"\n error is :%@",[error description]);
            }
        }];
    }
    
}




-(void)saveMessageWith:(NSDictionary *)userInfo{
    
    BmobChatUser *user = [[BmobDB currentDatabase] queryUserWithUid:[[userInfo objectForKey:PUSH_KEY_TARGETID] description]];
    
    NSString *content = [userInfo objectForKey:PUSH_KEY_CONTENT];
    NSString *toid    = [[userInfo objectForKey:PUSH_KEY_TOID] description];
    int type          = MessageTypeText;
    if ([userInfo objectForKey:PUSH_KEY_MSGTYPE]) {
        type = [[userInfo objectForKey:PUSH_KEY_MSGTYPE] intValue];
    }
    
    
    BmobMsg *msg      = [BmobMsg createReceiveWithUser:user
                                               content:content
                                                  toId:toid
                                                  time:[[userInfo objectForKey:PUSH_KEY_MSGTIME] description]
                                                  type:type status:STATUS_RECEIVER_SUCCESS];
    
    [[BmobDB currentDatabase] saveMessage:msg];
    
    //更新最新的消息
    BmobRecent *recent = [BmobRecent recentObejectWithAvatarString:user.avatar
                                                           message:msg.content
                                                              nick:user.nick
                                                          targetId:msg.belongId
                                                              time:[msg.msgTime integerValue]
                                                              type:msg.msgType
                                                        targetName:user.username];
    
    [[BmobDB currentDatabase] performSelector:@selector(saveRecent:) withObject:recent afterDelay:0.3f];
}



@end
