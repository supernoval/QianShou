//
//  CommonMethods.h
//  Xianghu
//
//  Created by iMac on 14-7-7.
//  Copyright (c) 2014年 Xianghu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import<UIKit/UIKit.h>
#import "Constants.h"

#import <CoreLocation/CoreLocation.h>
#import <BmobIM/BmobIM.h>
#import <BmobIM/BmobChatManager.h>
#import <BmobIM/BmobChat.h>
#import <BmobIM/BmobDB.h>

#import <BmobSDK/Bmob.h>

//更新明细
typedef void (^updateDetailAccountBlock)(BOOL success,BmobObject*detailObject);

//上传图片
typedef void (^upLoadPhotoBlock)(BOOL success,NSArray*results);


@interface CommonMethods : NSObject

+(NSString*)getHHmmssStr:(NSString*)dateStr;

+(NSString *)getYYYYMMddHHmmssDateStr:(NSDate*)date;

+(NSString*)getYYYYMMddhhmmDateStr:(NSDate*)date;

+(NSString*)getYYYYMMddFromDefaultDateStr:(NSDate*)date;
+(NSString*)getHHmmFromDefaultDateStr:(NSDate*)date;

+(NSString *)getHHmmssFromDefaultDateStr:(NSDate*)date;


+(NSDate*)getYYYMMddFromString:(NSString*)dateStr;

+(NSDate *)getYYYYMMFromString:(NSString *)dateStr;

+(NSInteger)getDay:(NSString*)dateStr;

+(BOOL)isBetweenTheTime:(NSString*)startTime endTime:(NSString*)endTime;



#pragma mark - 获取当前机型
+(NSString*)getCurrentDeviceName;



#pragma mark - 请求图片
+(void)setImageViewWithImageURL:(NSString*)url imageView:(UIImageView*)imageView;

+(void)setButtonImageWithImageURL:(NSString*)url button:(UIButton*)button;


#pragma mark - label
+(UILabel*)labelWithText:(NSString *)text textColor:(UIColor*)textColor font:(UIFont*)font textAligment:(NSTextAlignment)alignment frame:(CGRect)frame;

#pragma mark - UIlabel
+(UILabel*)LabelWithText:(NSString*)labeltext andTextAlgniment:(NSTextAlignment)alignment andTextColor:(UIColor*)textcolor andTextFont:(UIFont*)textFont andFrame:(CGRect)frame;

#pragma mark - 判断手机号码格式是否正确
+ (BOOL)checkTel:(NSString *)str;

#pragma mark - 拨打电话
+ (void)callPhoneWithSuperView:(UIView*)view phoneNum:(NSString*)phoneNum;

#pragma mark - 发送短信
+ (void)sendMessageWithSuperView:(UIView*)view phoneNum:(NSString*)phoneNum;


#pragma mark - 判断email格式是否正确
+ (BOOL)isValidateEmail:(NSString *)Email;





#pragma mark - 密码校验
+(BOOL)isRightCode:(NSString*)code;


#pragma mark - 对图片进行大小压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

#pragma makr - 自动压缩图片
+(UIImage*)autoSizeImageWithImage:(UIImage *)image;


#pragma mark - 将中间字符变成 ****
+(NSString*)geteditedmobile:(NSString*)mobile;

#pragma mark - 判断是否emoji表情
+(BOOL)isContainsEmoji:(NSString *)string;


#pragma mark -  显示错误提示
+(void)showDefaultErrorString:(NSString*)errorStr;
+(void)showAlertString:(NSString*)alert delegate:(id)delegate tag:(NSInteger)tag;

#pragma mark- 添加横线
+(void)addLine:(float)x startY:(float)y color:(UIColor *)color toView:(UIView *)parentView;


#pragma mark - 计算距离
+(double)distanceFromLocation:(CGFloat)latitude  longitude:(CGFloat)longitude;

#pragma  mark - 得到距离字符串
+(NSString*)distanceStringWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude;

#pragma mark - 计算两点距离
+(double)distanceBetweenLocation:(CLLocationCoordinate2D)oneCoord andLocation:(CLLocationCoordinate2D)twoCoord;


#pragma mark -  获取几天前
+(NSString*)timeStringFromNow:(NSDate*)Thattime;

#pragma mark - 获取剩余时间
+(double )timeLeft:(NSString*)sinceTimeStr;


#pragma mark - 获取date中的月日
+ (NSString *)getMounthAndDay:(NSDate *)dateTime;

#pragma mark- 获取date中的月
+ (NSInteger)getMonthFromDate:(NSDate *)dateTime;
#pragma mark - Bmob上传图片 
+(void)upLoadPhotos:(NSArray*)photos resultBlock:(upLoadPhotoBlock)block;

#pragma mark - 发送订单相关推送
+(void)sendOrderWithReceiver:(BmobUser*)receiver
                 orderObject:(BmobObject*)orderObject
                     message:(NSString*)message
                  orderstate:(OrderState)state;



#pragma mark - 更新明细
+(void)updateDetailAccountWithType:(DetailAccountType)type
                             Order:(BmobObject*)order
                              User:(BmobUser*)user
                             money:(double)money
                        qianshoubi:(double)qianshoubi
                   withResultBlock:(updateDetailAccountBlock)block;


@end


