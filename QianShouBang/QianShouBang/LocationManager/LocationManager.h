//
//  LocationManager.h
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject


+(LocationManager*)shareLocation;

@end
