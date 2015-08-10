//
//  LocateCityManager.m
//  YouKang
//
//  Created by 123456 on 14/12/24.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "LocateCityManager.h"
#import <UIKit/UIKit.h>
@implementation LocateCityManager

+ (instancetype)locateCity {
    return [[self alloc] init];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _myGeocoder = [[CLGeocoder alloc] init];
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //    _locationManager.distanceFilter=1000.0f;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {//ios8以后
            [_locationManager requestWhenInUseAuthorization];
//            [_locationManager requestAlwaysAuthorization];
        }
        else
        {
            [_locationManager startUpdatingLocation];
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"didChangeAuthorizationStatus---%u",status);
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||  status == kCLAuthorizationStatusAuthorizedAlways) {
        
        [_locationManager startUpdatingLocation];;
        
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:nil message:@"无法定位，请在 设置－隐私－定位服务 里开启对《牵手邦》的定位允许" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show ];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didChangeAuthorizationStatus----%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //    self.location = newLocation;
    NSLog(@"didUpdateToLocation:  newLocation: %@",newLocation);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    //NSLog(@"location...........%@", [locations description]);
    for (CLLocation *location in locations) {
        [self locateLocation:location];
    }
}

- (void)locateLocation:(CLLocation *)location {
    _location = location;
    //NSLog(@"lat:%f, log:%f", self.location.coordinate.latitude, self.location.coordinate.longitude);
    __block NSString *provinceName = nil;
    __block NSString *cityName = nil;
    __block NSString *townName = nil;
    [_myGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            //这时的placemarks数组里面只有一个元素
            CLPlacemark * placemark = [placemarks firstObject];
            provinceName= [placemark.addressDictionary objectForKey:@"State"];
            cityName = [placemark.addressDictionary objectForKey:@"City"];
            if ([[cityName substringToIndex:2] isEqualToString:@"上海"]) {
                cityName = @"上海";
            }
            townName = [placemark.addressDictionary objectForKey:@"SubLocality"];
            NSLog(@"===========province:%@, city:%@, town:%@,  addressDictionary:%@", provinceName, cityName, townName,placemark.addressDictionary);
            
            NSString *name = [placemark.addressDictionary objectForKey:@"name"];
            
            if (name.length > 0)
            {
                
                [self.locationDelegate locateAddress:name latitude:location.coordinate.latitude longitude:location.coordinate.longitude];
                
                [_locationManager stopUpdatingLocation];
            }
        
            
        }
    }];
    
    /*
     city:上海市市辖区  城市
     country:中国    国家
     name:中国上海市徐汇区漕河泾街道漕河泾田东路  具体地址
     state:上海市   省份
     street:田东路  街道完整名称
     sublocaality:徐汇区  区名
     subthoroughfare:(null) 
     thoroughfare:田东路 街道
     */
    /*
     dic Name = 宏润国际花园(西区)
     dic State = 上海市
     dic Street = 漕东支路 218弄
     dic SubLocality= 徐汇区
     dic SubThoroughfare= 218弄
     dic Thoroughfare = 漕东支路
     */
    
    
    /*
     {
     City = "\U4e0a\U6d77\U5e02\U5e02\U8f96\U533a";
     Country = "\U4e2d\U56fd";
     CountryCode = CN;
     FormattedAddressLines =     (
     "\U4e2d\U56fd\U4e0a\U6d77\U5e02\U5f90\U6c47\U533a\U6f15\U6cb3\U6cfe\U8857\U9053\U6f15\U4e1c\U652f\U8def218\U5f04"
     );
     Name = "\U5b8f\U6da6\U56fd\U9645\U82b1\U56ed(\U897f\U533a)";
     State = "\U4e0a\U6d77\U5e02";
     Street = "\U6f15\U4e1c\U652f\U8def 218\U5f04";
     SubLocality = "\U5f90\U6c47\U533a";
     SubThoroughfare = "218\U5f04";
     Thoroughfare = "\U6f15\U4e1c\U652f\U8def";
     }
     
     
    */
    
}




@end
