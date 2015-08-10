//
//  PickDateView.h
//  QianShouBang
//
//  Created by ucan on 15/8/10.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PickDateBlock)(NSString *dateStr);

@interface PickDateView : UIView
{
    UIView *backView;
    UIDatePicker *datePicker;
    
    PickDateBlock _block;
    
    
    
}


-(id)init;
-(void)setDateBlock:(PickDateBlock)block;
-(void)show;
-(void)dispear;

@end
