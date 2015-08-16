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
#import <AlipaySDK/AlipaySDK.h>
#import "NotificationKey.h"
#import "LocateCityManager.h"
#import "Constants.h"



@interface AppDelegate ()<LocateCityManagerDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置naigationbar 背景颜色和字体颜色
    [[UINavigationBar appearance] setBarTintColor:NavigationBarColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [[UITabBar appearance] setTintColor:NavigationBarColor];
    

    
    
    
    //remoteNotification  远程通知
    
    
    //bmob
    [Bmob registerWithAppKey:kBmobApplicationID];
    
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
    
    //    NSLog(@"STR:%@",dToken);
    
    
    if (dToken)
    {
        
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


#pragma mark - LocateCityManagerDelegate 
-(void)getCurrentCityNameFromLocateCityManager:(NSString *)province city:(NSString *)city town:(NSString *)town
{
    
    
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||  status == kCLAuthorizationStatusAuthorizedAlways) {
        
        [_locationManager startUpdatingLocation];;
        
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:nil message:@"无法定位，请在 设置－隐私－定位服务 里开启对《牵手邦》的定位允许" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show ];
        
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

    //NSLog(@"lat:%f, log:%f", self.location.coordinate.latitude, self.location.coordinate.longitude);
//    __block NSString *provinceName = nil;
//    __block NSString *cityName = nil;
//    __block NSString *townName = nil;
    [_myGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            //这时的placemarks数组里面只有一个元素
            CLPlacemark * placemark = [placemarks firstObject];
          
            NSLog(@"=========== addressDictionary:%@", placemark.addressDictionary);
        
//            NSString *City = [placemark.addressDictionary objectForKey:@"City"];
//            NSString *SubLocality = [placemark.addressDictionary objectForKey:@"SubLocality"];
//            NSString *Street = [placemark.addressDictionary objectForKey:@"Street"];
//            NSString *FormattedAddressLines = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
//            
//            NSString *address = [NSString stringWithFormat:@"",placemark.name,placemark.subLocality];
//            
//            NSLog(@"address:%@ FormattedAddressLines:%@ ",address,FormattedAddressLines);
            
            NSString *name =placemark.name;
            
            [[NSUserDefaults standardUserDefaults ] setObject:name forKey:kUserAddress];
            
            [[NSUserDefaults standardUserDefaults ] setFloat:location.coordinate.latitude forKey:kGPSLocationLatitude];
            [[NSUserDefaults standardUserDefaults ] setFloat:location.coordinate.longitude forKey:kGPSLoactionLongitude];
            [[NSUserDefaults standardUserDefaults ] synchronize];
            
            
            [_locationManager stopUpdatingLocation];
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




@end
