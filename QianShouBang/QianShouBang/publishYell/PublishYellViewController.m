//
//  PublishYellViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/12.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "PublishYellViewController.h"
#import "PhotoListView.h"

@interface PublishYellViewController ()<UITextViewDelegate,PhotoListViewDelegate>
{
    NSMutableArray *photos;
    
}
@property (weak, nonatomic) IBOutlet UITextView *yellTextView;

@property (weak, nonatomic) IBOutlet UIView *imagesView;

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation PublishYellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _yellTextView.delegate =self;
    
    
}


#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        
        _placeholderLabel.hidden = YES;
    }
    else
    {
        _placeholderLabel.hidden = NO;
        
    }
}


#pragma mark - PhotoListViewDelegate
-(void)addNewPhoto{

}

-(void)deleteOnePhoto:(NSInteger)photoIndex
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
