//
//  QSUser.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface QSUser : BmobUser

@property (nonatomic) NSString *seal_up;
@property (nonatomic) NSString *ANDROID_ID;
@property (nonatomic) NSInteger agent_user;
@property (nonatomic) NSInteger user_sex;
@property (nonatomic) BOOL wheather_allow_add;
@property (nonatomic) NSString *user_individuality_signature;
@property (nonatomic) NSString *user_phone;
@property (nonatomic) NSString *recommendUser;
@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;
@property (nonatomic) BmobGeoPoint *geoPoint;
@property (nonatomic) NSString *nick;
@property (nonatomic) NSInteger balance;
@property (nonatomic) NSString *user_level;
@property (nonatomic) NSString *deviceType;
@property (nonatomic) NSString *installId;
@property (nonatomic) NSString *version_code;
@property (nonatomic) NSString *avatar;
@property (nonatomic) NSInteger receiver_order_count;
@property (nonatomic) BOOL emailVerified;

@property (nonatomic) NSData *authData;
@property (nonatomic) BmobGeoPoint *location;




@end
