//
//  ContactTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "ContactTVC.h"
#import "ContactCell.h"
#import "SettingTVC.h"
#import "PersonInfoSettingTVC.h"

@interface ContactTVC ()
@property(strong,nonatomic)UISearchBar *headSearchBar;

@end

@implementation ContactTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.tableHeaderView = [self tableHeadView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma- tableHeadView
- (UIView *)tableHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headView.backgroundColor = kContentColor;
   
    _headSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-10 ,40)];
    
    _headSearchBar.placeholder = @"搜索";
    
    _headSearchBar.backgroundColor = [UIColor clearColor];
    
    [_headSearchBar setBarTintColor:kBlueColor];
    _headSearchBar.layer.borderColor = [UIColor clearColor].CGColor;
    _headSearchBar.layer.borderWidth = 0.0;
    
    _headSearchBar.delegate = self;
    
    //    _headSearchBar.showsCancelButton = YES;
    
    _headSearchBar.searchBarStyle = UISearchBarStyleDefault;
    
    //去掉搜索框背景
    for (UIView *view in _headSearchBar.subviews) {
        
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0)
        {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    [headView addSubview:_headSearchBar];
    return headView;

}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if (section == 0) {
        height = 5;
    }else{
        height = 10;
    }
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"ContactCell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ContactCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    
    switch (indexPath.section) {
        case 0:
            cell.image.image = [UIImage imageNamed:@"chat_message"];
            cell.text.text = @"聊天消息";
            break;
            
        case 1:
            cell.image.image = [UIImage imageNamed:@"new_friend"];
            cell.text.text = @"新朋友";
            break;
            
        case 2:
            cell.image.image = [UIImage imageNamed:@"near_by"];
            cell.text.text = @"附近人";
            break;
            
        default:
            break;
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    
    PersonInfoSettingTVC *personSettingTVC = [sb instantiateViewControllerWithIdentifier:@"PersonInfoSettingTVC"];
    [self.navigationController pushViewController:personSettingTVC animated:YES];
    //    switch (indexPath.section) {
    //        case 0:
    //            self.view.backgroundColor = kBackgroundColor;
    //            break;
    //
    //        case 1:
    //            <#statements#>
    //            break;
    //
    //        case 2:
    //            <#statements#>
    //            break;
    //            
    //        default:
    //            break;
    //    }
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
    
}

@end
