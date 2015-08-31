//
//  DarenDetailTableViewController.m
//  QianShouBang
//
//  Created by ZhuHaikun on 15/8/26.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "DarenDetailTableViewController.h"
#import "ChatViewController.h"

@interface DarenDetailTableViewController ()
{
    BmobUser *user;
    
}
@end

@implementation DarenDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"达人详情";
    
    user = [_darenObject objectForKey:@"user"];
    
    [self setSubViews];
    
}

-(void)setSubViews
{
    
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 90);
    
    
    
    _footerView.frame = CGRectMake(0, 0, ScreenWidth, 223);
    
    BmobUser *currentUser = [BmobUser getCurrentUser];
    
    if ([currentUser.objectId isEqualToString:user.objectId]) {
        
        _footerView.hidden = YES;
    }
    
    NSString *avatar = [user objectForKey:@"avatar"];
    
//    _headImageView.clipsToBounds = YES;
//    _headImageView.layer.cornerRadius = 40;
    
    int i = arc4random()%10;
    
    NSString *headString = [NSString stringWithFormat:@"head_default_%d",i];
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:headString]];
    
    
    
  
    _zixunButton.clipsToBounds = YES;
    _zixunButton.layer.cornerRadius = 20;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
       NSString * content = [_darenObject objectForKey:@"order_description"];
        CGFloat desHeight = [StringHeight heightWithText:content font:FONT_17 constrainedToWidth:200];
        
        if (desHeight < 47) {
            
            return 47;
        }
        
        return desHeight;
    }
    
    return 47;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
        UILabel *titleLabel = (UILabel*)[cell viewWithTag:100];
        UILabel *contentLabel = (UILabel*)[cell viewWithTag:101];
        
        NSString *title = nil;
        NSString *content = nil;
        
        switch (indexPath.row) {
            case 0:
            {
                title = @"昵称";
                
                content = [user objectForKey:@"nick"];
                
            }
                break;
            case 1:
            {
                title = @"保证金:";
                
                CGFloat benjin = [[_darenObject objectForKey:@"order_benjin"]floatValue];
                
                content =[NSString stringWithFormat:@"%.1f元",benjin];
                
            }
                break;
                
            case 2:
            {
                title = @"职业:";
                
                content = [_darenObject objectForKey:@"order_title"];
                
            }
                break;
            case 3:
            {
                title = @"描述:";
                
                content = [_darenObject objectForKey:@"order_description"];
            }
                
            default:
                break;
        }
        
        
        titleLabel.text = title;
        
        contentLabel.text = content;
        
    });
    
  
    
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

- (IBAction)callAction:(id)sender {
    
    NSString *phoneNum = user.username;
    
    [CommonMethods callPhoneWithSuperView:self.view phoneNum:phoneNum];
    
    
}

- (IBAction)sendMessageAction:(id)sender {
    
    NSString *phoneNum = user.username;
    
    [CommonMethods sendMessageWithSuperView:self.view phoneNum:phoneNum];

}

- (IBAction)zixunAction:(id)sender {
    
    
    
    if (user) {
        
        
  
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];

    [infoDic setObject:user.objectId forKey:@"uid"];
    [infoDic setObject:user.username forKey:@"name"];
    NSString *avatar = [user objectForKey:@"avatar"];
    NSString *nick = [user objectForKey:@"nick"];
    
    if (avatar) {
        [infoDic setObject:avatar forKey:@"avatar"];
    }
    if (nick) {
        [infoDic setObject:nick forKey:@"nick"];
    }
    ChatViewController *cvc = [[ChatViewController alloc] initWithUserDictionary:infoDic];
    cvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cvc animated:YES];
    
      }
}
@end
