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


-(void)initLocationManager
{
    _locaitonManager = [[CLLocationManager alloc]init];
    _locaitonManager.delegate = self;
    
    [_locaitonManager startUpdatingLocation];
    
    
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}



@end
