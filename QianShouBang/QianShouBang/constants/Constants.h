//
//  Constants.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

typedef NS_ENUM(NSInteger, OrderState)
{
    OrderStateUnPay = 3, //未付款
    OrderStateDone = 4,// 完成
    OrderStateAccepted = 2,//被接单
    OrderStatePayedUnAccepted = 1,//已付款未接单
    OrderStateAcceperCancel = 5, //接单者取消订单
    OrderStatePublishCancel = 6, //发单者取消订单
    OrderStatePublishConfirm = 7, //发单者确认
    OrderStateDelete = 10, //删除订单记录
    
    
    
};

//支付宝
#define kAliPayPartnerID  @"2088811228816728"

#define kAliPaySellerID  @"qsbang@163.com"

#define kURLSheme        @"QianShouBang"


#define kNotifyURL  = @"www.qs002.com/qsb/inc/order_state.php"

//#define kNotifyURL  = @"www.qs002.com/qsb/inc/order_state.php?" + "objectId=" + 订单ID + "&detail_id=" + 明细ID + "\"""

#define kAliPayPrivateKey   @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBANvzQfQt1QvhG0SNSJALcl7RlysS8ieXKXhX5mqeBQNbt5x385G9njCR03tjtk/vGTjhWuFALogt8bJ8PHZs4biG7juj8Rr5kdqoBOLd+uBsauSfbSeayyt0k0qJ9csAEA4/9fezg3psMfLM9yW7i6LIAlkOhmQt1saFvJFrAsMbAgMBAAECgYAS4a0VwyF45ZgrqF1EUFc/IIrznarAD0/2DsWu/WW8xhDbE8kLB9YeoUYgX4z1C7eElIPytknIUvlesx+Vov81aVE70eRsQSZpbXM54uZew4PqzUwwDK60D4XdAzTURZ8pN9NIer4faSj7mRjU+q7ZWR4ILvXOZdGOLVY+njSHwQJBAPCJiuTXog84TEUxMprA+oLW8nXKmnXtwd8NOSOfD1oFaEtwWHKNptElKyWxubQ9FH/6VCQl0CvMPQgqXLTjHvECQQDqFutk5sZ41cDPRsAXiBZsgS8sI1rHL3dQ0U477+t/TH+Yw9s5vk5Qf4EHceukHjrr3tNFqCNcDFt96nvbkNrLAkBEFjrpshwegMoeH+H6Kjv/A0cYjqQQU5+4Oq785U5cJgGysPdoXa5lr0a6Ycd2PH/sBfkBTm7Rpvtzr0IUteGRAkAVRif2b5KyAJsZO1DR0qhXDBaBaGUjnQi26460m8VHOGiQNZyCzuzHHA9Z4dyMecLZFNMWjYVJJEZcVycSeUOpAkAZ82CPFI2/vAR5mAqZTFP9F3AGEdf3bxK6kffTOzKDm63nI/1m/PiUvpwi9karJHo0uqAe0te45mryzFG2aYkL"


#pragma mark - Bmob
//#define kBmobApplicationID    @"ee9115c95d4ce604631935b1979a5edd"  //测试

#define kBmobApplicationID     @"b5cbd002adfbe8feee7bd6f184087379"  //正式

// 短信验证码  ShareSDK
#define kShareSDKSMSAppKey     @"95c9c33abb2c"
#define kShareSDKSMSAppSecret  @"071f5c608c8f07ba627b85e485ff6041"

//DeviceToken  ANDROID_ID
#define kDeviceTokenKey        @"DeviceTokenKey"

//DeviceToken installId data
#define kDeviceTokenData        @"DeviceTokenData"


//是否登录
#define kHadLogin              @"HadLoginKey"

//禁止用户添加好友
#define kNoAddFriends  @"NoAddFriends"

/*故事板*/
#define kSecondStoryboard @"Second"


#define IS_iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define ViewOriginY (IS_iOS7 ? 64:0)

/*宽高*/
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


/*字体*/
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_17 [UIFont systemFontOfSize:17]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_13 [UIFont systemFontOfSize:13]
#define FONT_12 [UIFont systemFontOfSize:12]



/*颜色*//*牵手邦里的颜色一共只有红，绿，灰，黑。
       红色：R，255    G，0   B，0
       主打绿色：R,65,  G,174,    B,158
       灰色：R,154    G,154    B,154
       黑色：R,0     G,0     B,0
       下面五个大图标绿色：R,10    G,184    B,7   */


#define RGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
//tabar 选中颜色
#define TabbarTintColor RGB(10,184,7,1.0)

//navigationbar 颜色
#define NavigationBarColor  RGB(65,174,158,1.0)


//背景色
#define kBackgroundColor RGB(239,239,244,1)
#define kContentColor [UIColor whiteColor]
#define kLineColor RGB(226,226,226,1)
//蓝绿字体
#define kBlueColor RGB(65,174,158,1)

//半透明背景色
#define kTransParentBackColor RGB(200,200,200,0.2)
//黄色字体
#define kYellowColor RGB(253,159,8,1)

//浅灰色气体
#define kLightTintColor  RGB(154, 154, 154, 1)

#define kDarkTintColor  RGB(49, 46, 46, 1)

#define CheckNil(a) (a)==nil?@"":(a)



#define kDarkTintColor   RGB(49, 46, 46, 1)


//定位位置
#define kUserAddress    @"UserAddress"
#define kGPSLocationLatitude    @"GPSLocationLatitude"
#define kGPSLoactionLongitude    @"GPSLocationLongitude"
