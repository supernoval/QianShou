//
//  SendNeedTableViewController.m
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "SendNeedTableViewController.h"
#import "RewardLimitationModel.h"


static NSString *needCell = @"needCell";
static NSString *imagesCell = @"imagesCell";
static NSString *benjinCell = @"benjinCell";
static NSString *tipsCell = @"tipsCell";


@interface SendNeedTableViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
    RewardLimitationModel *rewardModel;
    
}
@end

@implementation SendNeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _footerView.frame = CGRectMake(0, 0, ScreenWidth, 150);
    _publishButton.clipsToBounds = YES;
    _publishButton.layer.cornerRadius = 10;
    
    [self getRewardLimitation];
    
    
    
}

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                
                return 81;
            }
            
            if (indexPath.row == 1) {
                
                return 70;
            }
        }
            break;
        case 1:
        {
            return 99;
        }
            break;
        case 2:
        {
            return 99;
        }
            
            break;
            
        default:
        {
            return 44;
            
        }
            break;
    }
    
    return 44
    ;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
            
        default:
        {
            return 1;
            
        }
            break;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:needCell];
                
                
            }
            if (indexPath.row == 1) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:imagesCell];
                
            }
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:benjinCell];
            
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:tipsCell];
            
        }
            break;
            
            
        default:
            break;
    }
    
    return cell;
    
}


#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark -  UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    
}

- (IBAction)publishAction:(id)sender {
}



#pragma mark - 查询奖励设置表
-(void)getRewardLimitation
{
    BmobQuery *queReward = [BmobQuery queryWithClassName:kRewardClassName];
    
    [queReward findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        rewardModel = [[RewardLimitationModel alloc]init];
        
        for (BmobObject *ob in array) {
          
           
            
           
            
            
        }
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
