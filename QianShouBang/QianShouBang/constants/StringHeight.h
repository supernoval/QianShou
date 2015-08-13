//
//  StringHeight.h
//  UcanService
//
//  Created by ucan on 15/4/15.
//  Copyright (c) 2015年 ucan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface StringHeight : NSObject

+ (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font constrainedToWidth:(CGFloat)width;

@end
