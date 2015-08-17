//
//  PickAddressView.m
//  YouKang
//
//  Created by Haikun Zhu on 15/4/24.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "PickAddressView.h"
#import "CommonMethods.h"
@implementation PickAddressView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = kContentColor;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
        NSString *jsonString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData *jdata = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        
        _addressArray = (NSArray*)[NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"_____addressArray:%@",_addressArray);
        
//        if (_addressArray !=nil)
//        {
//            
//            NSDictionary *selProvinceDict = [_addressArray objectAtIndex:0];
//            province = [selProvinceDict objectForKey:@"province"];
//            
//            _cityArray = [selProvinceDict objectForKey:@"city"];
//            NSDictionary *citydict = [_cityArray objectAtIndex:0];
//            city = [citydict objectForKey:@"city"];
//            
//            NSLog(@"%s,%@",__func__,citydict);
//
//            _townArray = [citydict objectForKey:@"town"];
//
//            town = [_townArray objectAtIndex:0];
//        }
     
        
        
        [self addViewsWithFrame:frame];
        
        
        
    }
    
    
    return self;
    
}

-(void)addViewsWithFrame:(CGRect)frame
{
    CGFloat titleLabelHeight = 30.0;
    
    UILabel *titleLabel = [CommonMethods LabelWithText:@"请选择" andTextAlgniment:NSTextAlignmentCenter andTextColor:[UIColor blackColor] andTextFont:FONT_16 andFrame:CGRectMake(0, 0, frame.size.width, titleLabelHeight)];
    
    [self addSubview:titleLabel];
    
    UIView *lineOne = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabelHeight, frame.size.width, 0.5)];
    lineOne.backgroundColor = kLineColor;
    [self addSubview:lineOne];
    
    self.layer.cornerRadius = 3;
    self.layer.borderColor = kLineColor.CGColor;
    self.layer.borderWidth = 0.5;
    self.clipsToBounds = YES;
    
    UIButton *cancelbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height - titleLabelHeight, frame.size.width/2, titleLabelHeight)];
    [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbutton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelbutton.layer.borderWidth = 0.5;
    cancelbutton.layer.borderColor = kLineColor.CGColor;
    cancelbutton.backgroundColor = kContentColor;
  
    
    UIButton *okButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2, frame.size.height - titleLabelHeight, frame.size.width/2, titleLabelHeight)];
    [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.borderColor = kLineColor.CGColor;
    okButton.layer.borderWidth = 0.5;
    okButton.backgroundColor = kContentColor;
    
  
    
    _addressPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, titleLabelHeight, frame.size.width, frame.size.height - titleLabelHeight*2 - 8)];
    
    _addressPickerView.dataSource = self;
    _addressPickerView.delegate =self;
    
    [self addSubview:_addressPickerView];
    
      [self addSubview:okButton];
    
      [self addSubview:cancelbutton];
    
 
    
}

-(void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = self.frame;
        
        rect.origin.y = rect.origin.y - 300 - 8;
        
        self.frame = rect;
        
        
    }];
}
-(void)selectAction
{
    if (province.length > 0 && city.length > 0 && town.length > 0 ) {
        
        
        NSDictionary *blockDict = @{@"province":province,@"city":city,@"town":town};
        
        if (_block)
        {
            
              _block(blockDict);
        }
     
        
        [self dispear];
        
    }
    else
    {
        
    }
}
-(void)cancel
{
    [self dispear];
    
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
-(void)pickAddressBlock:(PickAddressViewBlock)block
{
    _block = block;
    
}

#pragma mark - UIPickerViewDataSource
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            
            
            return self.frame.size.width/3 - 20;

        }
            break;
        case 1:
        {
        
              return self.frame.size.width/3 - 20;
        }
            break;
        case 2:
        {
           
              return self.frame.size.width/3 + 40;
        }
            break;
            
        default:
            break;
    }
    return self.frame.size.width/3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
        {
            
            return _addressArray.count;
            
        }
            break;
        case 1:
        {
            return _cityArray.count;
            
        }
            break;
        case 2:
        {
            return _townArray.count;
            
        }
            break;
            
            
        default:
            break;
    }
    return 0;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}
-(NSAttributedString*)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    
    NSString *text = @"";
    switch (component) {
        case 0:
        {
              // NSLog(@"%s,_____addressArray:%@",__func__,_addressArray);
            NSDictionary *oneProvinceDict = [_addressArray objectAtIndex:row];
            
           text = [oneProvinceDict objectForKey:@"province"];
            
         
            
          
            
        }
            break;
        case 1:
        {
            NSDictionary *oneCityDict = [_cityArray objectAtIndex:row];
            
            text = [oneCityDict objectForKey:@"city"];
          
            
            
        }
            break;
        case 2:
        {
             text = [_townArray objectAtIndex:row];

            
            
            
        }
            
        default:
            break;
    }
     NSDictionary *atrribute = @{NSFontAttributeName:FONT_12};
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:text attributes:atrribute];
   
   // [title addAttributes:atrribute range:NSMakeRange(0,text.length)];
    
    
    
    return title;
    
}

#pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            NSLog(@"%s,_____addressArray:%@",__func__,_addressArray);
            
            NSDictionary *selProvinceDict = [_addressArray objectAtIndex:row];
            province = [selProvinceDict objectForKey:@"province"];
            
            _cityArray = [selProvinceDict objectForKey:@"city"];
            
            
            NSDictionary *selCity = [_cityArray firstObject];
            city = [selCity objectForKey:@"city"];
            
            _townArray = [selCity objectForKey:@"town"];
           
            town = [_townArray firstObject];
            
            [_addressPickerView reloadAllComponents];
            
//            [_addressPickerView reloadComponent:1];
//            [_addressPickerView reloadComponent:2];
            
            
            
            
        }
            break;
        case 1:
        {
         
            
//            [_addressPickerView reloadComponent:2];
            
        }
            break;
        case 2:
        {
            town = [_townArray objectAtIndex:row];
            
        }
            break;
            
            
        default:
            break;
    }
}



@end
