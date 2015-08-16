//
//  RankTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RankTVC.h"
#import "RankCell.h"

static NSUInteger pageSize = 10;

@interface RankTVC (){
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
}

@end

@implementation RankTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"财富榜";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self addHeaderRefresh];
    self.tableView.header.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    [self addFooterRefresh];
    self.tableView.footer.stateHidden = YES;
    
    _dataArray = [[NSMutableArray alloc]init];
    pageIndex = 0;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    BmobQuery *query = [BmobQuery queryWithClassName:kWeiboListItem];
    
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    [query includeKey:@"user"];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"RankCell";
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RankCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    
    cell.rankNumber.text = [NSString stringWithFormat:@"%li",indexPath.row+1];
    if (indexPath.row == 0) {
        cell.rankNumber.backgroundColor = RGB(140, 55, 37, 1.0);
    }else if(indexPath.row == 1){
        cell.rankNumber.backgroundColor = RGB(157, 100, 59, 1.0);
    }else if(indexPath.row == 2){
        cell.rankNumber.backgroundColor = RGB(159, 122, 59, 1.0);
    }else{
        cell.rankNumber.backgroundColor = [UIColor whiteColor];
    }
    //头像
    cell.image.image = [UIImage imageNamed:@"setting"];
    //姓名
    cell.name.text = @"超人飞";
    
    //简介
    cell.intro_text.text = @"去尼玛的超人不会飞";
    
    //vip
    cell.vip.image = [UIImage imageNamed:@"vip_2"];
    
    cell.money.text = [NSString stringWithFormat:@"¥250.0"];
    return cell;
}


@end
