//
//  LocationViewController.h
//  BmobIMDemo
//
//  Created by Bmob on 14-7-14.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "BaseViewController.h"
#import <BmobSDK/Bmob.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"


@interface LocationViewController : BaseViewController<MKMapViewDelegate>



-(instancetype)initWithLocationCoordinate:(CLLocationCoordinate2D)coord;



@end
