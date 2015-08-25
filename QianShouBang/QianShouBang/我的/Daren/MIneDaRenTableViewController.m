//
//  MIneDaRenTableViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/25.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MIneDaRenTableViewController.h"
#import "MineDarenCell.h"

static NSString *const cellid = @"darencell";

@interface MIneDaRenTableViewController ()
{
    BmobUser *_currentUser;
    
    BmobObject *_darenObject;
    
    
}
@end

@implementation MIneDaRenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的达人";
    
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 125);
    _footerView.frame = CGRectMake(0, 0, ScreenWidth, 122);
    _footerView.hidden = YES;
    
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 30;
    
    _xiajiaButton.clipsToBounds = YES;
    _xiajiaButton.layer.cornerRadius = 23.0;
    
    _currentUser = [BmobUser getCurrentUser];
    
    [self setSubViews];
    
    [self getdata];
    
}

-(void)setSubViews
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[_currentUser objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    BOOL isMale = [[_currentUser objectForKey:@"user_sex"]boolValue];
    
    
    if (!isMale) {
        
        _sexImage.image = [UIImage imageNamed:@"female"];
        
    }
    
    NSString *nick = [_currentUser objectForKey:@"nick"];
    
    if (nick) {
     
        _nickNameLabel.text = nick;
        
     
    }
    
    _phoneLabel.text = _currentUser.username;
    
    

    
}

-(void)getdata
{
    
    BmobQuery *query = [BmobQuery queryWithClassName:kOrder];
    
    [query whereKey:@"order_type" equalTo:@(100)];
    [query whereKey:@"user" equalTo:_currentUser];
    
    
    [MyProgressHUD showProgress];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
       
        [MyProgressHUD dismiss];
        
        
        if (array.count > 0) {
            
            
            _darenObject = [array firstObject];
            
            _footerView.hidden = NO;
            
        }
        
        
        
        [self.tableView reloadData];
        
        
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_darenObject) {
        
        return 4;
    }
    
    return 1;
    
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_darenObject) {
        
        UITableViewCell *blankCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blankCell"];
        
        blankCell.textLabel.text = @"您还未申请过达人";
        
        blankCell.textLabel.textColor = kDarkTintColor;
        
        blankCell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        blankCell.userInteractionEnabled = NO;
        
        
        return blankCell;
        
        
        
    }
    
    
    MineDarenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    NSString *content = nil;
    NSString *title = nil;
    
    UIColor *contentColor = kDarkTintColor;
    
    
    switch (indexPath.row) {
        case 0:
        {
            title = @"发布日期:";
            content = [CommonMethods getYYYYMMddHHmmssDateStr:_darenObject.createdAt];
            contentColor = kDarkTintColor;
        }
            break;
        case 1:
        {
            title = @"职    业:";
            content = [_darenObject objectForKey:@"order_title"];
            contentColor = kDarkTintColor;
        }
            break;
        case 2:
        {
            title = @"内    容:";
            content = [_darenObject objectForKey:@"order_description"];
            contentColor = kDarkTintColor;
            
        }
            break;
        case 3:
        {
            title = @"保证金:";
            CGFloat benjin = [[_darenObject objectForKey:@"order_benjin"]floatValue];
            
            content = [NSString stringWithFormat:@"%.1f元",benjin];
            contentColor = [UIColor redColor];
            
        }
            
        default:
            break;
    }
    
    
    cell.contentLabel.text = content;
    
    cell.dateLabel.text = title;
    
    cell.contentLabel.textColor = contentColor;
    
    
    return cell;
    
    
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

- (IBAction)xiajiaAction:(id)sender {
    
    
}
@end
