//
//  NearPeopleTVC.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "NearPeopleTVC.h"
#import "NearPeopleCell.h"

static NSUInteger pageSize = 10;

@interface NearPeopleTVC ()
@property (nonatomic, strong)UIView *checkView;
@property (nonatomic)BOOL showCheckView;
@property (nonatomic, strong)BmobUser *user;
@property (nonatomic, strong)BmobGeoPoint *currentPoint;
@property (nonatomic) NSInteger catagoryNum;//0-女生 1-男生 2-全部

@end

@implementation NearPeopleTVC{
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.currentPoint = [[BmobGeoPoint alloc]init];

    
    self.title = @"附近人";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.checkView = [self nearCatagoryVeiw];
    [self.view addSubview:self.checkView];
    self.checkView.hidden = YES;
    self.showCheckView = NO;
    
    
    
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
    self.catagoryNum = 2;
    
     _user = [BmobUser getCurrentUser];
    
    self.currentPoint = [_user objectForKey:@"location"];
    
    
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
    
    BmobQuery *query = [BmobUser query];
    
    query.limit = pageSize;
    query.skip = pageSize*pageIndex;
    
    if (self.catagoryNum == 0) {
        [query whereKey:@"location" nearGeoPoint:self.currentPoint];
        [query whereKey:kuser_sex equalTo:@(0)];
    }else if(self.catagoryNum == 1){
        [query whereKey:@"location" nearGeoPoint:self.currentPoint];
        [query whereKey:kuser_sex equalTo:@(1)];
    }else if(self.catagoryNum == 2){
        [query whereKey:@"location" nearGeoPoint:self.currentPoint];
    }
    
    
    NSLog(@"&&&&:%f==%f",self.currentPoint.longitude,self.currentPoint.latitude);
    NSLog(@"number:%li",(long)self.catagoryNum);
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        [self endHeaderRefresh];
        [self endFooterRefresh];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count+10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"NearPeopleCell";
    NearPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"NearPeopleCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    if (_dataArray.count > indexPath.row) {
        
        BmobUser *oneUser = [_dataArray objectAtIndex:indexPath.row];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[oneUser objectForKey:kavatar]]];
        cell.name.text = @"呵呵大大（男）";
        cell.distance.text = @"距离800KM";
        
    }
    
  
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark- 附近人种类View
- (UIView *)nearCatagoryVeiw{
    CGFloat width = 100;
    CGFloat height = 120;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-width-2, 2, width, height)];
    view.backgroundColor = kBlueColor;
    
    [CommonMethods addLine:15 startY:height/3 color:[UIColor whiteColor] toView:view];
    [CommonMethods addLine:15 startY:height*2/3 color:[UIColor whiteColor] toView:view];
    
    
    UIButton *femaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, height/3)];
    femaleBtn.backgroundColor = [UIColor clearColor];
    [femaleBtn setTitle:@"只看女生" forState:UIControlStateNormal];
    [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    femaleBtn.titleLabel.font = FONT_16;
    [femaleBtn addTarget:self action:@selector(checkFemalealeAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:femaleBtn];
    
    UIButton *maleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, height/3, width, height/3)];
    maleBtn.backgroundColor = [UIColor clearColor];
    [maleBtn setTitle:@"只看男生" forState:UIControlStateNormal];
    [maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    maleBtn.titleLabel.font = FONT_16;
    [maleBtn addTarget:self action:@selector(checkMaleAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:maleBtn];
    
    
    UIButton *greetBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, height*2/3, width, height/3)];
    greetBtn.backgroundColor = [UIColor clearColor];
    [greetBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [greetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    greetBtn.titleLabel.font = FONT_16;
    [greetBtn addTarget:self action:@selector(checkAllAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:greetBtn];
    
    return view;
}

- (void)checkFemalealeAction{
    self.showCheckView = NO;
    self.checkView.hidden = YES;
    self.catagoryNum = 0;
    [self getData];
}
-(void)checkMaleAction{
    self.showCheckView = NO;
    self.checkView.hidden = YES;
    self.catagoryNum = 1;
    [self getData];
}
- (void)checkAllAction{
    self.showCheckView = NO;
    self.checkView.hidden = YES;
    self.catagoryNum = 2;
    [self getData];
}
#pragma mark- 查看不同种类的附近人
- (IBAction)catagotyAction:(UIBarButtonItem *)sender {
    self.showCheckView = !self.showCheckView;
    if (self.showCheckView) {
        self.checkView.hidden = NO;
    }else{
        self.checkView.hidden = YES;
    }
    
    
}
@end
