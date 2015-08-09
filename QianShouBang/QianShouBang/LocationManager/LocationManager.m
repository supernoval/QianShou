//
//  LocationManager.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager


static  LocationManager *manager = nil;

+(LocationManager*)shareLocation
{
   static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        manager = [[LocationManager alloc]init];
        
    });
    
    
    return manager;
    
    
}


@end
