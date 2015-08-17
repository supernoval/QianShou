//
//  RankTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "RankTVC.h"
#import "RankCell.h"
#import "StringHeight.h"

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
    cell.nameWidth.constant = [StringHeight widthtWithText:@"超人不会飞" font:FONT_15  constrainedToHeight:21];
    
    cell.rankNumber.text = [NSString stringWithFormat:@"%ld",(indexPath.row+1)];
    if (indexPath.row == 0) {
        cell.rankNumber.backgroundColor = [UIColor redColor];
        cell.rankNumber.textColor = [UIColor whiteColor];
    }else if(indexPath.row == 1){
        cell.rankNumber.backgroundColor = [UIColor purpleColor];
        cell.rankNumber.textColor = [UIColor whiteColor];
    }else if(indexPath.row == 2){
        cell.rankNumber.backgroundColor = [UIColor orangeColor];
        cell.rankNumber.textColor = [UIColor whiteColor];
    }else{
        cell.rankNumber.backgroundColor = [UIColor whiteColor];
        cell.rankNumber.textColor = [UIColor blackColor];
    }
    //头像
    cell.image.image = [UIImage imageNamed:@"setting"];
    //姓名
    cell.name.text = @"超人不会飞";
    
    //简介
    cell.intro_text.text = @"去尼玛的超人不会飞";
    
    //vip
    cell.vip.image = [UIImage imageNamed:@"vip_2"];
    
    cell.money.text = [NSString stringWithFormat:@"¥250.0"];
    return cell;
}


@end
