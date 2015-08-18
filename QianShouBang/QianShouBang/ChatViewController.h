//
//  ChatViewController.h
//  XueHang
//
//  Created by Bmob on 14-6-5.
//  Copyright (c) 2014年 bmob. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#import "BaseViewController.h"
@interface ChatViewController : BaseViewController{



}

- (instancetype)initWithUserDictionary:(NSDictionary*)dic;


-(void)location:(CLLocationCoordinate2D)coor address:(NSString *)address;
@end
