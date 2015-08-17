//
//  PickAddressView.h
//  YouKang
//
//  Created by Haikun Zhu on 15/4/24.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

typedef void (^PickAddressViewBlock)(NSDictionary*addressDict);

@interface PickAddressView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    PickAddressViewBlock _block;
    
    UIPickerView *_addressPickerView;
    
    NSArray *_cityArray;
    NSArray *_townArray;
    
    NSArray *_addressArray;
    NSString *province;
    NSString *city;
    NSString *town;
    
    
}




-(void)pickAddressBlock:(PickAddressViewBlock)block;

-(id)initWithFrame:(CGRect)frame;

-(void)show;

@end
