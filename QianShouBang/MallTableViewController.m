//
//  MallTableViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/7.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "MallTableViewController.h"
#import "MallCell.h"
#import "GoodsDetailTVC.h"

static NSUInteger pageSize = 10;

@interface MallTableViewController (){
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
}

@end

@implementation MallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"牵手币商城";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    BmobQuery *query = [BmobQuery queryWithClassName:kIntergralBean];
    
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
        
        if (pageIndex == 0) {
            
            [_dataArray removeAllObjects];
            
        }
        
        [_dataArray addObjectsFromArray:array];
        
        BmobObject *obj = [_dataArray objectAtIndex:0];
        NSString *str = [obj objectForKey:kintergralGoodsIcon_url];
        
        NSLog(@"///:%@****:%@----:%@",str,obj.createdAt,obj.updatedAt);
        [self.tableView reloadData];
        
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 115)];
    headView.backgroundColor = [UIColor clearColor];
    
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 80)];
    midView.backgroundColor = kContentColor;
    [headView addSubview:midView];
    
    //黄色View
    UIView *yellowView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-60)/2, 5, 60, 60)];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.layer.masksToBounds = YES;
    yellowView.layer.cornerRadius = 30;
    [midView addSubview:yellowView];
    
    //牵手币
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 60, 15)];
    text.text = @"牵手币";
    text.textAlignment = NSTextAlignmentCenter;
    text.font = FONT_13;
    text.textColor = [UIColor whiteColor];
    [text bringSubviewToFront:yellowView];
    [yellowView addSubview:text];
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, 60, 15)];
    money.text = @"100";
    money.textAlignment = NSTextAlignmentCenter;
    money.font = FONT_13;
    money.textColor = [UIColor whiteColor];
    [money bringSubviewToFront:yellowView];
    [yellowView addSubview:money];
    
    //牵手币明细
    UIButton *moneyItro = [[UIButton alloc]initWithFrame:CGRectMake(8, 60, 100, 15)];
    [moneyItro setImage:[UIImage imageNamed:@"money_intro"] forState:UIControlStateNormal];
    [moneyItro setTitle:@"牵手币明细" forState:UIControlStateNormal];
    moneyItro.titleLabel.font = FONT_13;
    [moneyItro setTitleColor:kLightTintColor forState:UIControlStateNormal];
    moneyItro.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [moneyItro setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [moneyItro addTarget:self action:@selector(qianShouBiIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:moneyItro];
    
    //怎样赚取牵手币
    UIButton *makeMoney = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 128, 60, 120, 15)];
    [makeMoney setImage:[UIImage imageNamed:@"money_make"] forState:UIControlStateNormal];
    [makeMoney setTitle:@"怎样赚取牵手币" forState:UIControlStateNormal];
    makeMoney.titleLabel.font = FONT_13;
    [makeMoney setTitleColor:kLightTintColor forState:UIControlStateNormal];
    makeMoney.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [makeMoney setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [makeMoney addTarget:self action:@selector(qianShouBiMake:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:makeMoney];
    
    //热门推荐
    //牵手币
    UILabel *cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(8, 92, 100, 20)];
    cellTitle.text = @"热门推荐";
    cellTitle.textAlignment = NSTextAlignmentLeft;
    cellTitle.font = FONT_14;
    [headView addSubview:cellTitle];
    
    return headView;
}
//牵手币明细
- (void)qianShouBiIntroduce:(UIButton *)button{
}

- (void)qianShouBiMake:(UIButton *)button{
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 115;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BmobObject *obj = [_dataArray objectAtIndex:indexPath.row];
    
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
    
//    cell.exchangeBtn.tag = indexPath.row;
//    [cell.exchangeBtn addTarget:self action:@selector(exchangeGoods:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSecondStoryboard bundle:[NSBundle mainBundle]];
    GoodsDetailTVC *goodsTVC = [sb instantiateViewControllerWithIdentifier:@"GoodsDetailTVC"];
    goodsTVC.obj = [_dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:goodsTVC animated:YES];
}


- (void)exchangeGoods:(UIButton *)button{
}

- (IBAction)theExchangesGoods:(UIBarButtonItem *)sender {
}
@end
