//
//  GuideViewController.m
//  YouKang
//
//  Created by ucan on 14/12/16.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "GuideViewController.h"
#import "CatchOrderTVC.h"
#import "Constants.h"

@implementation GuideViewController
{
    CatchOrderTVC *_catchOrderTVC;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpFirstLaunchView];

}
#pragma mark 设置引导页
-(void)setUpFirstLaunchView
{
    [self setUpGuideScrollView];
    [self setUpGuidePageControl];
    
}

-(void)setUpGuideScrollView
{
    UIScrollView *guideScrollV = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    guideScrollV.delegate = self;
    [self.view addSubview:guideScrollV];
    guideScrollV.pagingEnabled = YES;
    guideScrollV.bounces = YES;
    guideScrollV.showsVerticalScrollIndicator = NO;
    guideScrollV.showsHorizontalScrollIndicator = NO;
    guideScrollV.tag = 100;
    guideScrollV.contentSize = CGSizeMake(ScreenWidth*4, ScreenHeight);
    
    for (int i = 0; i<3; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"guideImage_%d.png",i];
        UIImage *guideImage = [UIImage imageNamed:imageName];
        
        UIImageView *guideImageV = [[UIImageView alloc]initWithImage:guideImage];
        guideImageV.frame = CGRectMake(i*ScreenWidth, 0, ScreenWidth , ScreenHeight);
        [guideScrollV addSubview:guideImageV];
        
    }
    /*
    if (iphone4)
    {
        for (int i = 0; i<3; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"guideIma_4_%d.png",i];
            UIImage *guideImage = [UIImage imageNamed:imageName];
            
            UIImageView *guideImageV = [[UIImageView alloc]initWithImage:guideImage];
            guideImageV.frame = CGRectMake(i*vWidth, 0, vWidth , vHeight);
            [guideScrollV addSubview:guideImageV];
            
        }
    }
    else if (iphone5)
    {
        for (int i = 0; i<3; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"guideIma_5_%d.png",i];
            UIImage *guideImage = [UIImage imageNamed:imageName];
            
            UIImageView *guideImageV = [[UIImageView alloc]initWithImage:guideImage];
            guideImageV.frame = CGRectMake(i*vWidth, 0, vWidth , vHeight);
            [guideScrollV addSubview:guideImageV];
            
        }
    }
    else if (iphone6)
    {
        for (int i = 0; i<3; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"guideIma_6_%d.png",i];
            UIImage *guideImage = [UIImage imageNamed:imageName];
            
            UIImageView *guideImageV = [[UIImageView alloc]initWithImage:guideImage];
            guideImageV.frame = CGRectMake(i*vWidth, 0, vWidth , vHeight);
            [guideScrollV addSubview:guideImageV];
            
        }
    }
    else
    {
        for (int i = 0; i<3; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"guideIma_6p_%d.png",i];
            UIImage *guideImage = [UIImage imageNamed:imageName];
            
            UIImageView *guideImageV = [[UIImageView alloc]initWithImage:guideImage];
            guideImageV.frame = CGRectMake(i*vWidth, 0, vWidth , vHeight);
            [guideScrollV addSubview:guideImageV];
            
        }
    }*/
}



-(void)setUpGuidePageControl
{
    UIPageControl *guidePageControl = [[UIPageControl alloc]init];
    guidePageControl.tag = 200;
    guidePageControl.numberOfPages = 3;
    guidePageControl.currentPage = 0;
    [guidePageControl addTarget:self action:@selector(handleGuidePageControl:) forControlEvents:UIControlEventValueChanged];
    
}
-(void)handleGuidePageControl:(UIPageControl *)pageControl
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:100];
    [scrollView setContentOffset:CGPointMake(ScreenWidth *pageControl.currentPage, 0)animated:YES];
}

#pragma mark scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGPoint contentOffset = scrollView.contentOffset;
    [scrollView setContentOffset:CGPointMake(contentOffset.x+0, contentOffset.y+0 ) animated:YES];
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:200];
    pageControl.currentPage = scrollView.contentOffset.x/ScreenWidth;
    

    NSLog(@"-----%f", scrollView.contentOffset.x);
    if (scrollView.contentOffset.x > 2*(ScreenWidth))
    {
        
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}





@end
