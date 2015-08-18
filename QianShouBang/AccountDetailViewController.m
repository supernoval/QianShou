//
//  AccountDetailViewController.m
//  QianShouBang
//
//  Created by ucan on 15/8/14.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "AccountDetailViewController.h"
#import "AccountCell.h"
#import "MJRefresh.h"

static NSUInteger pageSize = 10;

@interface AccountDetailViewController ()

@end

@implementation AccountDetailViewController{
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
    
    BmobUser *_user;
    
}

@synthesize from;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.from == 1) {
        self.title = @"账户明细";
    }else if (self.from == 2){
        self.title = @"牵手币明细";
    }
    
    _dataArray = [[NSMutableArray alloc]init];
    pageIndex = 0;
    
    [self addHeadView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _user = [BmobUser getCurrentUser];
    
    NSLog(@"id：%@",[_user objectForKey:kobjectId]);
    
    [self.tableView.header beginRefreshing];
    
}


- (void)accountHeaderRefresh{
    pageIndex = 0;
    [self getData];
}
- (void)accountFooterRefresh{
    pageIndex ++;
    [self getData];
}

- (void)getData{
    
    BmobQuery *query = [BmobQuery queryWithClassName:kDetailAccount];
    
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    
    [query whereKey:@"user" equalTo:_user];

    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (error) {
            NSLog(@"%@",error);
        }else{
            
            if (pageIndex == 0) {
                
                [_dataArray removeAllObjects];
                
            }
            
            [_dataArray addObjectsFromArray:array];
            
            NSLog(@"*******______----:%lu",(unsigned long)_dataArray.count);
            [self.tableView reloadData];
        }
        
        
    }];
    
    
}



- (void)addHeadView{
    UILabel *label_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth/4 , 21)];
    label_1.text = @"时间";
    label_1.textAlignment = NSTextAlignmentCenter;
    label_1.font = FONT_14;
    label_1.textColor = kBlueColor;
    [self.view addSubview:label_1];
    
    UILabel *label_2 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, 64,ScreenWidth/4 , 21)];
    label_2.text = @"来源";
    label_2.textAlignment = NSTextAlignmentCenter;
    label_2.font = FONT_14;
    label_2.textColor = kBlueColor;
    [self.view addSubview:label_2];
    
    UILabel *label_3 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2,64 ,ScreenWidth/4 , 21)];
    label_3.text = @"支出/收入";
    label_3.textAlignment = NSTextAlignmentCenter;
    label_3.font = FONT_14;
    label_3.textColor = kBlueColor;
    [self.view addSubview:label_3];
    
    UILabel *label_4 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*3/4,64 ,ScreenWidth/4 , 21)];
    label_4.text = @"余额";
    label_4.textAlignment = NSTextAlignmentCenter;
    label_4.font = FONT_14;
    label_4.textColor = kBlueColor;
    [self.view addSubview:label_4];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, label_4.frame.origin.y+label_4.frame.size.height+2, ScreenWidth, 1)];
    line.backgroundColor = kBlueColor;
    [self.view addSubview:line];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,line.frame.origin.y+2, ScreenWidth, ScreenHeight-23-64) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(accountHeaderRefresh)];
    self.tableView.header.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(accountFooterRefresh)];
    self.tableView.footer.stateHidden = YES;
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
    
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"AccountCell";
    AccountCell *cell = (AccountCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[AccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.time.text = @"09/05";
    cell.fromLabel.text = @"我用支付宝支出";
    cell.money.text = @"+201";
    cell.remainMoney.text = @"654";
   
    return cell;
}




@end
