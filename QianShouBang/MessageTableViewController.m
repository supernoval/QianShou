//
//  MessageTableViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/7.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MessageTableViewController.h"
#import "MessageCell.h"
#import "MessageDetailTVC.h"

static NSUInteger pageSize = 10;

@interface MessageTableViewController (){
    
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
}

@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self addHeaderRefresh];
    self.tableView.header.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    [self addFooterRefresh];
    self.tableView.footer.stateHidden = YES;
    
    _dataArray = [[NSMutableArray alloc]init];
    pageIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.header beginRefreshing];
    
}

- (void)headerRefresh{
    pageIndex = 0;
    [self getData];
}
- (void)footerRefresh{
    pageIndex ++;
    [self getData];
}

- (void)getData{
    
    BmobQuery *query = [BmobQuery queryWithClassName:kSystemMsg];
    
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (pageIndex == 0) {
            
            [_dataArray removeAllObjects];
            
        }
        
        [_dataArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 8)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BmobObject *obj = [_dataArray objectAtIndex:indexPath.section];
    
    static NSString *cellId = @"MessageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kContentColor;
    cell.titleText.text = [obj objectForKey:ksystem_msg_title];
    cell.timeText.text = [CommonMethods getMounthAndDay:obj.updatedAt];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BmobObject *obj = [_dataArray objectAtIndex:indexPath.section];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    MessageDetailTVC *messageDetail = [sb instantiateViewControllerWithIdentifier:@"MessageDetailTVC"];
    messageDetail.messageObj = obj;
    [self.navigationController pushViewController:messageDetail animated:YES];
    
}
@end
