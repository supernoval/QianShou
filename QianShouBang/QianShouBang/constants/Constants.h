//
//  Constants.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//
#pragma mark - Bmob 
#define kBmobApplicationID    @"ee9115c95d4ce604631935b1979a5edd"

// 短信验证码  ShareSDK
#define kShareSDKSMSAppKey     @"95c9c33abb2c"
#define kShareSDKSMSAppSecret  @"071f5c608c8f07ba627b85e485ff6041"

//DeviceToken  ANDROID_ID
#define kDeviceTokenKey        @"DeviceTokenKey"


//是否登录
#define kHadLogin              @"HadLoginKey"


/*宽高*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



/*颜色*/
#define RGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
//tabar 选中颜色
#define TabbarTintColor  [UIColor greenColor]

//navigationbar 颜色
#define NavigationBarColor  [UIColor redColor]


//#define NavigationBarColor RGB(20,45,100,1)
//背景色
#define kBackgroundColor RGB(250,250,250,1)
#define kContentColor [UIColor whiteColor]