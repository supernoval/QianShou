//
//  PhotoListView.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PhotoListView.h"
#import "Constants.h"

@implementation PhotoListView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        
        self.backgroundColor = kBackgroundColor;
        
        
        
        
    }
    
    return self;
    
}

-(void)setPhotos:(NSArray *)photos
{
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    CGFloat offSet = 8.0;
    
    CGFloat imageViewWith = self.frame.size.height - offSet*2;
    CGFloat deleteButtonWith = 15.0;
    
    
    for (int i = 0; i < photos.count; i++) {
        
        UIImage *oneImage = [photos objectAtIndex:i];
        
        UIImageView *oneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(offSet +(imageViewWith+offSet)*i , offSet, imageViewWith, imageViewWith)];
        oneImageView.image = oneImage;
        
        [self addSubview:oneImageView];
        
        
        //add delete button
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(oneImageView.frame.origin.x - 6.0, 0, deleteButtonWith, deleteButtonWith)];
        
        [deleteButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
        deleteButton.tag = i;
        
        [deleteButton addTarget:self action:@selector(deleteOneImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteButton];
        
        
        
        
    }
    
    if (photos.count < 4)
    {
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(offSet + (imageViewWith+offSet)*photos.count, offSet, imageViewWith, imageViewWith)];
        
        [addButton setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        
        [addButton addTarget:self action:@selector(pickPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:addButton];
        
        
    }
    
}

-(void)deleteOneImage:(UIButton*)sender
{
    [self.photoDelegate deleteOnePhoto:sender.tag];
    
}

-(void)pickPhoto:(UIButton*)sender
{
    [self.photoDelegate addNewPhoto];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
