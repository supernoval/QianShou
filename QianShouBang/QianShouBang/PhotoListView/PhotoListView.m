//
//  PhotoListView.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PhotoListView.h"
#import "Constants.h"


CGFloat imageWith;
CGFloat offSet = 8.0;

@implementation PhotoListView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        
        self.backgroundColor = kBackgroundColor;
        
        
        imageWith = (ScreenWidth - 5*offSet)/4;
        
        
        
        
        
    }
    
    return self;
    
}

-(void)setPhotos:(NSArray *)photos
{
    
    
    [self resetFrame:photos];
    
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
        
    }
    
 
    
   
    CGFloat deleteButtonWith = 15.0;
    
    NSInteger line = 0;
    
    
    for (int i = 0; i < photos.count; i++) {
        
        UIImage *oneImage = [photos objectAtIndex:i];
        

        
        UIImageView *oneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(offSet +(imageWith+offSet)*(i%4) ,offSet + line*(imageWith + offSet), imageWith, imageWith)];
        
        oneImageView.image = oneImage;
        
        [self addSubview:oneImageView];
        
    
        
        //add delete button
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(oneImageView.frame.origin.x - 6.0, oneImageView.frame.origin.y - 6.0, deleteButtonWith, deleteButtonWith)];
        
        [deleteButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
        deleteButton.tag = i;
        
        [deleteButton addTarget:self action:@selector(deleteOneImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteButton];
        
        
        if (i%4 == 3)
        {
            line ++;
            
            
        }
        
    }
    
    if (photos.count < 9)
    {
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(offSet + (imageWith+offSet)*(photos.count%4), line*(imageWith + offSet) + offSet, imageWith, imageWith)];
        
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

-(void)resetFrame:(NSArray*)photos
{
    CGRect originRect = self.frame;
    
    NSInteger lineNum = 0;
    
    if (photos.count < 4) {
        
        lineNum = 1;
    }
    else if (photos.count >= 4 && photos.count < 8)
    {
        lineNum = 2;
    }
    else
    {
        lineNum = 3;
        
    }
    
    
    originRect.size.height = lineNum * (imageWith + offSet)  + offSet;
    
    
    self.frame = originRect;
    
    
    
    


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
