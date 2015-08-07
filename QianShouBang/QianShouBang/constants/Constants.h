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



/*故事板*/
#define kSecondStoryboard @"Second"



/*宽高*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


/*字体*/
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_17 [UIFont systemFontOfSize:17]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_12 [UIFont systemFontOfSize:12]


/*颜色*/
#define RGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
//tabar 选中颜色
#define TabbarTintColor  [UIColor greenColor]

//navigationbar 颜色
#define NavigationBarColor  RGB(65,174,158,0.9)


//#define NavigationBarColor RGB(20,45,100,1)
//背景色
#define kBackgroundColor RGB(250,250,250,1)
#define kContentColor [UIColor whiteColor]
#define kLineColor RGB(220,220,220,1)
//蓝绿字体
#define kBlueColor RGB(67,202,245,1)

//黄色字体
#define kYellowColor RGB(253,159,8,1)

//浅灰色气体
#define kLightTintColor  RGBColor(124, 124, 124, 1)
#define kDarkTintColor   RGB(49, 46, 46, 1)