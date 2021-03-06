//
//  CommonMethods.m
//  Xianghu
//
//  Created by iMac on 14-7-7.
//  Copyright (c) 2014年 Xianghu. All rights reserved.
//

#import "CommonMethods.h"
#import "Constants.h"
#import "MyProgressHUD.h"
#import <BmobSDK/BmobProFile.h>
#import "BmobDataListName.h"
#import "SBJSON.h"
#import "JSONModel.h"



@implementation CommonMethods

+ (NSString*)getHHmmssStr:(NSString *)dateStr
{
    NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc]init];
    
    [dateformatter1 setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    NSDate *formateDate = [dateformatter1 dateFromString:dateStr];
    
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    
    
    NSString *timeStr = [dateformatter stringFromDate:formateDate] ;
    
    return timeStr;
}
+ (NSString*)getYYYYMMddHHmmssDateStr:(NSDate *)date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    NSString *finalDateStr = [dateformatter stringFromDate:date];
    
    
    return finalDateStr;
}
+(NSInteger)getDay:(NSString *)dateStr
{
    NSDateFormatter *fromatter = [[NSDateFormatter alloc]init];
    
    [fromatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *date = [fromatter dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
  
    
    NSInteger dateFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:dateFlag fromDate:date];
    
    NSInteger today = [components day];
    
    
    return today;
    
                                    
    
}

+(NSDate*)getYYYMMddFromString:(NSString *)dateStr
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateformatter dateFromString:dateStr];
    
    return date;
    
}

+(NSDate *)getYYYYMMFromString:(NSString *)dateStr{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM"];
    NSDate *date = [dateformatter dateFromString:dateStr];
    
    return date;
}

+(NSString*)getYYYYMMddFromDefaultDateStr:(NSDate *)date
{
 
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *finalDateStr = [dateformatter stringFromDate:date];
    
    
    return finalDateStr;
    
    
}


+(NSString*)getHHmmFromDefaultDateStr:(NSDate *)date
{
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm"];
    
    
    NSString *timeStr = [dateformatter stringFromDate:date];
    
    return timeStr;
    
}

+(NSString*)getHHmmssFromDefaultDateStr:(NSDate *)date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    
    
    NSString *timeStr = [dateformatter stringFromDate:date];
    
    return timeStr;
}

+(NSString*)getYYYYMMddhhmmDateStr:(NSDate *)date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    
    
    NSString *timeStr = [dateformatter stringFromDate:date];
    
    return timeStr;
}



#pragma mark - UILabel
+(UILabel*)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAligment:(NSTextAlignment)alignment frame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.text = text;
    
    label.textColor = textColor;
    label.font = font;
    
    label.textAlignment = alignment;
    
    
    
    return label;
    
    
}


#pragma mark - UILabel
+(UILabel*)LabelWithText:(NSString *)labeltext andTextAlgniment:(NSTextAlignment)alignment andTextColor:(UIColor *)textcolor andTextFont:(UIFont *)textFont andFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = labeltext;
    label.textAlignment = alignment;
    label.textColor = textcolor;
    label.font = textFont;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
    
}



+ (BOOL)checkTel:(NSString *)str
{
    
     NSString *eleven = @"^1\\d{10}$";
    NSPredicate *regexttext11 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",eleven];
    
    if ([regexttext11 evaluateWithObject:str])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3r[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    /**
//     29         * 新增淘宝等号段
//     30         * 170,176,177,178,147
//     31         */
//    NSString *TB = @"^1(7[0678]|4[7]|8[0-9])\\d{8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    NSPredicate *regexttexttb = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TB];
//    
//    if (([regextestmobile evaluateWithObject:str] == YES)
//        || ([regextestcm evaluateWithObject:str] == YES)
//        || ([regextestcu evaluateWithObject:str] == YES)
//        || ([regextestct evaluateWithObject:str] == YES)
//        || ([regextestphs evaluateWithObject:str] == YES)
//        || [regexttexttb evaluateWithObject:str] == YES)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

#pragma mark - 获取两位小数
+(CGFloat)getTwopoint:(CGFloat)value
{

    
    
    int newIntValue = value *100;
    
    CGFloat newValue = newIntValue /100.00;
    
    
    return newValue;
    
}
#pragma mark - 判断Email格式是否正确
+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

#pragma mark - 判断用户名
+(BOOL)isRightUserName:(NSString*)Username
{
    NSString *usernameCheck = @"^[_\\w\\d\\x{4e00}-\\x{9fa5}]{2,20}$";
    
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",usernameCheck];
    
    return [usernameTest evaluateWithObject:Username];
    
    
}

#pragma mark - 密码
+(BOOL)isRightCode:(NSString*)code
{
    NSString *codeCheck = @"^[\\~!@#$%^&*()-_=+|{}\\[\\],.?\\/:;\'\"\\d\\w]{6,16}$";
    
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",codeCheck];
    
    //NSLog(@"%s,%@",__func__,code);
    
    return [codeTest evaluateWithObject:code];
    
    
}


#pragma mark - 异步请求图片
+(void)setImageViewWithImageURL:(NSString *)url imageView:(UIImageView *)imageView
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        
        if (image != nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                imageView.image = image;
                
            });
        }
 
        
        
    });
    
}

+(void)setButtonImageWithImageURL:(NSString*)url button:(UIButton*)button
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        
        if (image != nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [button setImage:image forState:UIControlStateNormal];
                
            });
        }
        
        
        
    });
}





#pragma mark - 对图片进行大小压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark - 自动压缩图片
+ (UIImage*)autoSizeImageWithImage:(UIImage *)image
{
    CGSize imageSize = image.size;
    
    
    CGFloat imagewith = 300.0;
    
    CGFloat imageHeight = imageSize.height *imagewith/imageSize.width;
    
    
    
   return [self imageWithImage:image scaledToSize:CGSizeMake(imagewith, imageHeight)];
    
 
    
}

#pragma mark - 将中间字符变成 ****
+(NSString*)geteditedmobile:(NSString*)mobile
{
    
    if (mobile.length == 11) {
        
        NSString *editemobile = mobile;
        
        NSString *firstThreeStr = [editemobile substringToIndex:3];
        
        NSString *lastFourStr = [editemobile substringFromIndex:7];
        
        editemobile = [NSString stringWithFormat:@"%@****%@",firstThreeStr,lastFourStr];
        
        
        
        return editemobile;
    }
 
    else
    {
        return mobile;
        
    }
    
}

+(BOOL)isBetweenTheTime:(NSString*)startTime endTime:(NSString*)endTime
{
    
    if (startTime == nil || endTime == nil) {
        
        return NO;
        
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    
    NSDate *startDate = [formatter dateFromString:startTime];
    
    NSDate *endDate = [formatter dateFromString:endTime];
    
    
    NSDate *now = [NSDate date];
    
    if ([now isEqualToDate:[now laterDate:startDate]] && [now isEqualToDate:[now earlierDate:endDate]])
    {
        
        
        return YES;
        
        
        
    }
    
    return NO;
    
    
}

+(BOOL)isContainsEmoji:(NSString *)string {
    
    
    
    __block BOOL isEomji = NO;
    
    
    
    [string  enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         } else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 isEomji = YES;
                 
             }
             
             
             
         } else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 
                 isEomji = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 isEomji = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 isEomji = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 isEomji = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 
                 isEomji = YES;
                 
             }
             
         }
         
     }];
    
    
    
    return isEomji;
    
}


+(void)showDefaultErrorString:(NSString *)errorStr
{
    
    [[[UIAlertView alloc]initWithTitle:nil message:errorStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show ];
    
    
    
    
}

+(void)showAlertString:(NSString *)alert delegate:(id)delegate tag:(NSInteger)tag
{
    
      UIAlertView * alertview = [[UIAlertView alloc]initWithTitle:nil message:alert delegate:delegate cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertview.tag = tag;
    
    [alertview show];
    
}

+(void)addLine:(float)x startY:(float)y color:(UIColor *)color toView:(UIView *)parentView{
    CALayer *line = [[CALayer alloc] init];
    line.frame = CGRectMake(x, y, parentView.frame.size.width-x, 1);
    line.backgroundColor = color.CGColor;
    [parentView.layer addSublayer:line];
}


+(double)distanceFromLocation:(CGFloat)latitude longitude:(CGFloat)longitude
{
    CLLocation *fromLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CGFloat currentLatitude = [[NSUserDefaults standardUserDefaults]floatForKey:kGPSLocationLatitude];
    CGFloat currentLongitude = [[NSUserDefaults standardUserDefaults] floatForKey:kGPSLoactionLongitude];
    
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:currentLatitude   longitude:currentLongitude];
    
    
    CLLocationDistance meters = [currentLocation distanceFromLocation:fromLocation];
    
    
    return meters;
    
    
    
    
}

+(NSString*)distanceStringWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
    double dis = [self distanceFromLocation:latitude longitude:longitude];
    
    if (dis < 1000) {
        
        return [NSString stringWithFormat:@"距离:%.0fm",dis];
    }
    else
    {
        return [NSString stringWithFormat:@"距离:%.2fKM",dis/1000.0];
        
    }
}

+(double)distanceBetweenLocation:(CLLocationCoordinate2D)oneCoord andLocation:(CLLocationCoordinate2D)twoCoord
{
    CLLocation *locationOne = [[CLLocation alloc]initWithLatitude:oneCoord.latitude longitude:oneCoord.longitude];
    
    CLLocation *locationTwo = [[CLLocation alloc]initWithLatitude:twoCoord.latitude longitude:twoCoord.longitude];
    
    
     CLLocationDistance meters = [locationOne distanceFromLocation:locationTwo];
    
    return meters;
    
}

+(NSString*)timeStringFromNow:(NSDate*)Thattime
{
    
    
    double time = fabs([Thattime timeIntervalSinceNow]);
    
    
    NSInteger day = (NSInteger)time/60/60/24;
    
    NSInteger hour = (NSInteger)time/60/60;
    
    NSInteger minues = (NSInteger)time/60;
    
    
    
    if (day > 0) {
        
        return [NSString stringWithFormat:@"%ld天前",(long)day];
    }
    
    if (hour > 0) {
        
        return [NSString stringWithFormat:@"%ld小时前",(long)hour];
        
    }
    
   
    return [NSString stringWithFormat:@"%ld分钟前",(long)minues];
    
    
}

+ (NSString *)getMounthAndDay:(NSDate *)dateTime{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit;
    comps = [calendar components:unitFlags fromDate:dateTime];
    long day=[comps day];//获取日期对应的日
    long month=[comps month];//获取月对应的月
    return [NSString stringWithFormat:@"%ld/%ld",month,day];
}

+ (NSInteger)getMonthFromDate:(NSDate *)dateTime{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit;
    comps = [calendar components:unitFlags fromDate:dateTime];
    long month=[comps month];//获取日期对应的月
    return month;
}

+(void)upLoadPhotos:(NSArray *)photos resultBlock:(upLoadPhotoBlock)block
{
    if (photos.count > 0) {
        
        NSMutableArray *photosDataArray = [[NSMutableArray alloc]init];
        
        for (NSInteger i = 0 ; i  < photos.count ; i ++) {
            
            UIImage *oneImage = [photos objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(oneImage, 1);
            
            
            
            NSDictionary *imagedataDic = @{@"data":imageData,@"filename":@"image.jpg"};
            
            [photosDataArray addObject:imagedataDic];
            
            
        }
        
        
        
        [MyProgressHUD showProgress];
        
        
        [BmobProFile uploadFilesWithDatas:photosDataArray resultBlock:^(NSArray *filenameArray, NSArray *urlArray, NSArray *bmobFileArray, NSError *error) {
            
            
            
            if (error) {
                
                NSLog(@"%s,error:%@",__func__,error);
                
                NSLog(@"图片上传失败");
                
                [CommonMethods showDefaultErrorString:@"图片上传失败，请重新上传"];
                
                block(NO,nil);
                
                
            }else
            {
                
                NSLog(@"filename:%@  urlArray:%@",filenameArray,urlArray);
                
              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                  
             
                
                if (bmobFileArray.count > 0) {
                    
                    
                 
                    NSMutableArray *files = [[NSMutableArray alloc]init];
                    
//                    BmobObjectsBatch *batch = [[BmobObjectsBatch alloc]init];
                    
                  __block  NSInteger num = 0;
                    
                    for (int i = 0 ; i < bmobFileArray.count; i ++) {
                        
                        BmobFile *onefile = [bmobFileArray objectAtIndex:i];
                        
                        NSString *url = onefile.url;
                        
                        
                        
                        BmobObject *attachObject = [[BmobObject alloc]initWithClassName:kAttachItem];
                        
                        [attachObject setObject:url forKey:@"attach_name"];
                        [attachObject setObject:url forKey:@"attach_url"];
                        
                       
                       
                        [attachObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                            
                            num ++;
                            
                            [files addObject:attachObject];
                            
                            if (num == bmobFileArray.count) {
                                
                                
                                //回调
                                block(YES,files);
                            }
                          
                            
                        }];
                        
                     
                        
                        
                        
                        
                    }
                    
                
                    
                    
                   
                   
                    
                    
                    
                    
                    
                }
                  
                    });
                
                
            }
            
            
        } progress:^(NSUInteger index, CGFloat progress) {
            
            
        }];
        
        
        
        
        
    }
}


+(NSString*)getCurrentDeviceName
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if (screenSize.width == 320) {
        
        if (screenSize.height == 480) {
            
            return @"来自:iPhone 4s";
        }
        
        if (screenSize.height == 568) {
            
            return @"来自:iPhone 5s";
        }
        
      
    }
    
    if (screenSize.width == 375) {
        
        return @"来自:iPhone 6";
    }
    
    if (screenSize.width == 414) {
        
        return @"来自:iPhone 6plus";
        
    }
    
    return @"来自:未知型号";
    
}


+ (void)callPhoneWithSuperView:(UIView *)view phoneNum:(NSString *)phoneNum
{
    UIWebView *webView = [[UIWebView alloc]init];
    
    NSString *phonestr  = [NSString stringWithFormat:@"tel://%@", phoneNum];
    NSURL *telUrl = [NSURL URLWithString:phonestr];
    [webView loadRequest:[NSURLRequest requestWithURL:telUrl]];
    [view addSubview:webView];
    
    
}

+ (void)sendMessageWithSuperView:(UIView *)view phoneNum:(NSString *)phoneNum
{
    UIWebView *webView = [[UIWebView alloc]init];
    
    NSString *phonestr  = [NSString stringWithFormat:@"sms://%@", phoneNum];
    NSURL *telUrl = [NSURL URLWithString:phonestr];
    [webView loadRequest:[NSURLRequest requestWithURL:telUrl]];
    [view addSubview:webView];
}
+(double)timeLeft:(NSString *)sinceTimeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    NSDate *fromDate = [formatter dateFromString:sinceTimeStr];
    
    
    double secends = [[NSDate date] timeIntervalSinceDate:fromDate];
    
    NSLog(@"fromDate:%@",fromDate);
    
    return (3600 - secends);
    
    
    
}

#pragma mark - 发送订单相关推送
+(void)sendOrderWithReceiver:(BmobUser *)receiver orderObject:(BmobObject *)orderObject message:(NSString *)message orderstate:(OrderState)state
{
   
    if (!message) {
        
        message = @"消息";
    }
    NSDictionary *orderDict = [orderObject valueForKey:@"bmobDataDic"];
    
    BmobUser *currentuser = [BmobUser getCurrentUser];
    
    NSDictionary *userDict = [currentuser valueForKey:@"bmobDataDic"];
    
    
    SBJsonWriter *write = [[SBJsonWriter alloc]init];
    
    NSString *orderJsonStr = [write stringWithObject:orderDict];
    NSString *userJsonStr = [write stringWithObject:userDict];
    

      //推送内容
    NSMutableDictionary *msgDict = [[NSMutableDictionary alloc]init];
    
    [msgDict setObject:@{@"sound":@"default",@"badge":@1,@"alert":message} forKey:@"aps"];
    [msgDict setObject:orderJsonStr forKey:@"order"];
    [msgDict setObject:@(state) forKey:@"state"];
    
//    [msgDict setObject:userJsonStr forKey:@"user"];

    
    BmobQuery *query = [BmobQuery queryForUser];
    [query selectKeys:@[@"deviceType",@"installId"]];
    [query getObjectInBackgroundWithId:receiver.objectId block:^(BmobObject *object, NSError *error) {
        BmobQuery *pushQuery = [BmobInstallation query];
        if ([[[object objectForKey:@"deviceType"] description] isEqualToString:@"ios"]) {
            [pushQuery whereKeyExists:@"deviceToken"];
            [pushQuery whereKey:@"deviceToken" equalTo:[object objectForKey:@"installId"]];
        }else{
            [pushQuery whereKeyExists:@"installationId"];
            [pushQuery whereKey:@"installationId" equalTo:[object objectForKey:@"installId"]];
        }
        //推送
        BmobPush *push = [BmobPush push];
      
        [push setData:msgDict];
        [push setQuery:pushQuery];
        [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                
                NSLog(@"push Success!");
             
            }
            else
            {
                NSLog(@"push fail:%@",error);
                
            }
           
        }];
    }];
    
    
}

#pragma mark - 更新明细
+(void)updateDetailAccountWithType:(DetailAccountType)type Order:(BmobObject*)order User:(BmobUser*)user  money:(double)money qianshoubi:(double)qianshoubi withResultBlock:(updateDetailAccountBlock)block
{
    
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    
    [query whereKey:@"user" equalTo:user];
    
    [query orderByDescending:@"updatedAt"];
    
    query.limit = 1;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
        
    if (!error)
    {
        
        double tMoneyCount = 0;
        double tIntegralCount = 0.0;
        
        double jiangli = [[order objectForKey:@"jiangli_money"]doubleValue];
        double benjin = [[order objectForKey:@"order_benjin"]doubleValue];
        double commision = [[order objectForKey:@"order_commission"]doubleValue];
        
        //交易额
        double tMoney = 0.0;
        
        //积分交易额
        double tIntegral = 0.0;
        
        if (array.count > 0)
        {
            
            BmobObject *beforeDetail = [array firstObject];
            
            tMoneyCount = [[beforeDetail objectForKey:@"tMoneyCount"]doubleValue];
            tIntegralCount = [[beforeDetail objectForKey:@"tIntegralCount"]doubleValue];
            
            
        }
        
        
    bool cash = false; //提现
    bool income = false;//接单收入
    bool expenditure = false; //发单支出
    bool pay_error = false; //支付失败
    bool open_vip_error = false; //办理会员失败
    bool recharge = false; //存款
    bool vip = false; //办理会员
    bool return_money = false; //取消订单返还的余额
    bool isJiangli = false; //奖励
    bool failure_pay = false; //支付失败
    bool cash_error = false; //提现失败
    bool release_order_jl = false;//发单并完成的奖励
    bool receive_order_jl = false; //接单奖励
    bool is_master_order = false; //达人未付款
    bool return_bzj = false;// 返回保证金
    bool Intergral_exchange = false; //牵手币兑换
    bool isQsMoneyType = false; //牵手币类型
    bool isAccountAmountType = false; //帐户金额类型
    bool monthly_bonus_points = false; //月奖励
    bool first_bonus_points = false; //首次奖励牵手币
    
    
    switch (type) {
        case DetailAccountTypeCash:
        {
            cash = true;
        }
            break;
        case DetailAccountTypeCash_error:
        {
            cash_error = true;
        }
            break;
        case DetailAccountTypeExpenditure:
        {
            expenditure = true;
        }
            break;
        case DetailAccountTypeFailure_pay:
        {
            failure_pay = true;
        }
            break;
        case DetailAccountTypeFirst_bonus_points:
        {
            first_bonus_points = true;
            
        }
            break;
        case DetailAccountTypeIncome:
        {
            tMoney = benjin + commision;
            
            tMoneyCount += benjin + commision;
            
            income = true;
            
        }
            break;
        case DetailAccountTypeIntegral_exchange:
        {
            Intergral_exchange = true;
        }
            break;
        case DetailAccountTypeIs_master_order:
        {
            is_master_order = true;
        }
            break;
        case DetailAccountTypeIsAccountAmountType:
        {
            isAccountAmountType = true;
        }
            break;
        case DetailAccountTypeIsJiangli:
        {
            
            isJiangli = true;
        }
            break;
        case DetailAccountTypeIsQsMoneyType:
        {
            isQsMoneyType = true;
        }
            break;
        case DetailAccountTypeMonthly_bonus_points:
        {
            monthly_bonus_points = true;
        
        }
            break;
        case DetailAccountTypeOpen_vip_error:
        {
            open_vip_error = true;
        }
            break;
        case DetailAccountTypePay_error:
        {
            tMoney = benjin + commision;
            tIntegral = 0.0;
            
            pay_error = true;
        }
            break;
        case DetailAccountTypeReceive_order_jl:
        {
            tIntegralCount += tIntegral;
            
            receive_order_jl = true;
        }
            break;
        case DetailAccountTypeRecharge:
        {
            recharge = true;
        }
            break;
        case DetailAccountTypeRelease_order_jl:
        {
            release_order_jl = true;
        }
            break;
        case DetailAccountTypeReturn_bzj:
        {
            return_bzj = true;
        }
            break;
        case DetailAccountTypeReturn_money:
        {
            tMoney = benjin + commision;
            
            tIntegral = 0.0;
            
            tMoneyCount += tMoney;
            
            
            return_money = true;
        }
            break;
        case DetailAccountTypeVip:
        {
            vip = true;
        }
            break;
        case DetailAccountTypeSendOrder:
        {
            tMoney = benjin + commision;
            tIntegral = 0.0;
            
        }
            break;
            
        default:
            break;
    }
    
    
 
 
       
  
    
    
    BmobObject *detailObject = [BmobObject objectWithClassName:kDetailAccount];
    
    [detailObject setObject:user forKey:@"user"];
    [detailObject setObject:order forKey:@"order"];
    
    
    [detailObject setObject:@(cash) forKey:@"cash"];
    [detailObject setObject:@(expenditure) forKey:@"expenditure"];
    [detailObject setObject:@(monthly_bonus_points) forKey:@"monthly_bonus_points"];
    [detailObject setObject:@(open_vip_error) forKey:@"open_vip_error"];
    [detailObject setObject:@(receive_order_jl) forKey:@"receive_order_jl"];
    [detailObject setObject:@(recharge) forKey:@"recharge"];
    [detailObject setObject:@(release_order_jl) forKey:@"release_order_jl"];
    [detailObject setObject:@(return_money) forKey:@"return_money"];
    [detailObject setObject:@(cash_error) forKey:@"cash_error"];
    [detailObject setObject:@(failure_pay) forKey:@"failure_pay"];
    [detailObject setObject:@(income) forKey:@"income"];
    [detailObject setObject:@(isAccountAmountType) forKey:@"isAccountAmountType"];
    [detailObject setObject:@(pay_error) forKey:@"pay_error"];
    [detailObject setObject:@(return_bzj) forKey:@"return_bzj"];
    [detailObject setObject:@(vip) forKey:@"vip"];
    [detailObject setObject:@(isJiangli) forKey:@"isJiangli"];
    
    
        tIntegral = [CommonMethods getTwopoint:tIntegral];
        tMoney = [CommonMethods getTwopoint:tIntegral];
        jiangli = [CommonMethods getTwopoint:jiangli];
        tIntegralCount = [CommonMethods getTwopoint:tIntegralCount];
        tMoneyCount = [CommonMethods getTwopoint:tMoneyCount];
        
    [detailObject setObject:@(tIntegral) forKey:@"tIntegral"];
    
    [detailObject setObject:@(tMoney) forKey:@"tMoney"];
    
    [detailObject setObject:@(jiangli) forKey:@"tJiangli"];
    
    [detailObject setObject:@(tIntegralCount) forKey:@"tIntegralCount"];
    
    [detailObject setObject:@(tMoneyCount) forKey:@"tMoneyCount"];
    
    [detailObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        
        if (isSuccessful) {
            
           
            block(YES,detailObject);
            
        }
        else
        {
            
             block(NO,detailObject);
            
            [MyProgressHUD dismiss];
            
            
            NSLog(@"%s,error:%@",__func__,error);
            
            
            
        }
        
    }];
           
       }
       else
       {
           NSLog(@"updateDetailerror:%@",error);
           
       }
       
   }];

    
    
}

@end
