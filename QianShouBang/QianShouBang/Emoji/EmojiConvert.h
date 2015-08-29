//
//  EmojiConvert.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/29.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmojiConvert : NSObject


+ (NSString*)getOldEmojiFromNew:(NSString*)newString;

+ (NSString *)getNewEmojiFromOld:(NSString*)oldString;

@end
