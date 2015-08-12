//
//  PhotoListView.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoListViewDelegate <NSObject>

-(void)addNewPhoto;
-(void)deleteOnePhoto:(NSInteger)photoIndex;


@end

@interface PhotoListView : UIView

@property (nonatomic)NSArray *photos;

@property (nonatomic) id <PhotoListViewDelegate>  photoDelegate;


@end
