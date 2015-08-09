//
//  PayOrder.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/8.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Order.h"
@interface PayOrder : NSObject

+(void)loadAlipayWithPayInfo:(Order*)order;

@end
