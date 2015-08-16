//
//  YellModel.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/16.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "JSONModel.h"
#import <BmobSDK/Bmob.h>
@interface YellModel : JSONModel


@property (nonatomic) NSArray *photos;
@property (nonatomic) BmobObject *yellObject;


@end
