//
//  LocateCityManager.h
//  YouKang
//
//  Created by 123456 on 14/12/24.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
@protocol LocateCityManagerDelegate <NSObject>

@optional

-(void)locateAddress:(NSString*)address latitude:(double)latitude  longitude:(double)longitude;

@end

@interface LocateCityManager : CLLocationManager<CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    CLGeocoder *_myGeocoder;
    CLLocation* _location;
    LocateCityManager *_locationCityManager;
}
@property (nonatomic,assign) id<LocateCityManagerDelegate> locationDelegate;



+ (instancetype)locateCity;

@end
