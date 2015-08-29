//
//  TheExchangedGoodsTVC.m
//  QianShouBang
//
//  Created by Leo on 15/8/29.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "TheExchangedGoodsTVC.h"
#import "MallCell.h"
#import "GoodsDetailTVC.h"

static NSUInteger pageSize = 10;

@interface TheExchangedGoodsTVC (){
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
}


@end

@implementation TheExchangedGoodsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已兑换商品";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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



- (void)headerRefresh{
    pageIndex = 0;
    [self getData];
}
- (void)footerRefresh{
    pageIndex ++;
    [self getData];
}

- (void)getData{
    
    BmobQuery *query = [BmobQuery queryWithClassName:kExchangeMoneyBean];
    
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    [query whereKey:@"user" equalTo:[BmobUser getCurrentUser]];
    [query whereKey:kintergralBean notEqualTo:nil];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"pppppppppp");
        
        if (pageIndex == 0) {
            
            [_dataArray removeAllObjects];
            
        }
        
        [_dataArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        }
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataArray.count > indexPath.row) {
        
    BmobObject *oneExchange = [_dataArray objectAtIndex:indexPath.row];
    BmobObject *obj = [oneExchange objectForKey:kintergralBean];
    
    static NSString *cellId = @"RowTextCell";
    MallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MallCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.image sd_setImageWithURL:[obj objectForKey:kintergralGoodsIcon_url]];
    
    cell.titleText.text = [obj objectForKey:kintergralGoodsTitle];
    cell.introText.text = [obj objectForKey:kintergralGoodsDescription];
    
    [cell.exchangeBtn setTitle:@"已兑换" forState:UIControlStateNormal];
    
    return cell;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    GoodsDetailTVC *goodsTVC = [sb instantiateViewControllerWithIdentifier:@"GoodsDetailTVC"];
    BmobObject *oneExchange = [_dataArray objectAtIndex:indexPath.row];
    BmobObject *goodsObj = [oneExchange objectForKey:kintergralBean];
    goodsTVC.obj = goodsObj;
    [self.navigationController pushViewController:goodsTVC animated:YES];
}

@end
