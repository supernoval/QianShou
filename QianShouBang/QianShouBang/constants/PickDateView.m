//
//  PickDateView.m
//  QianShouBang
//
//  Created by ucan on 15/8/10.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PickDateView.h"
#import "Constants.h"

CGFloat pickDateheight = 250;

@implementation PickDateView

-(id)init
{
    if (self == [super init]) {
        
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth , pickDateheight);
        
        self.backgroundColor = kContentColor;
        
        [self setTimeViewWithFrame:self.frame];
        
        
    }
    
    return self;
    
}


//服务时间选择
-(void)setTimeViewWithFrame:(CGRect)frame
{
    
    //时间选择白色横条
    UILabel *selectDoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
    
    selectDoneLabel.backgroundColor = kBackgroundColor;
    
    [self addSubview:selectDoneLabel];
    
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 30, frame.size.width, frame.size.height - 30)];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *now = [NSDate date];
//    datePicker.minimumDate = now;
    //datePicker.locale = NSLocaleLanguageCode;
    datePicker.date = now;
    
    [self addSubview:datePicker];
    
    
    //完成Btn
    UIButton *selectDoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-50, 0, 50, 30)];
    [selectDoneBtn addTarget:self action:@selector(completeTime) forControlEvents:UIControlEventTouchUpInside];
    [selectDoneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [selectDoneBtn setTitleColor:kDarkTintColor forState:UIControlStateNormal];
    [self addSubview:selectDoneBtn];
    
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 0, 50, 30)];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:kDarkTintColor forState:UIControlStateNormal];
    [self addSubview:cancelButton];
    
    
    
    
}
-(void)completeTime
{
    NSDate *theDate = datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *pickDateStr = [dateFormatter stringFromDate:theDate];
    
    if (_block) {
        
        _block(pickDateStr);
        
    }
    
    [self dispear];
    
}

-(void)cancel
{
    [self dispear];
    
}

-(void)setDateBlock:(PickDateBlock)block
{
    _block = block;
    
}

-(void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = self.frame;
        
        rect.origin.y = rect.origin.y - rect.size.height;
        
        self.frame = rect;
        
        
    }];
}
-(void)dispear
{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = self.frame;
        
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = rect;
        
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}




@end
