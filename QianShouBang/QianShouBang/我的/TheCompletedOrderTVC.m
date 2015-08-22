//
//  TheCompletedOrderTVC.m
//  QianShouBang
//
//  Created by ucan on 15/8/17.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "TheCompletedOrderTVC.h"
#import "CompletedOrderCell.h"
#import "LocationViewController.h"
#import "OrderProgressViewController.h"

static NSUInteger pageSize = 10;

@interface TheCompletedOrderTVC ()

@end

@implementation TheCompletedOrderTVC{
    NSMutableArray *_dataArray;
    
    NSInteger pageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已完成纪录";
    self.view.backgroundColor = kBackgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    
    BmobQuery *query = [BmobQuery queryWithClassName:kOrder];
    query.limit = pageSize;
    query.skip = pageSize * pageIndex;
    
    [query whereKey:@"receive_user" equalTo:[BmobUser getCurrentUser]];
    [query whereKey:@"order_state" equalTo:@(OrderStateDone)];
    [query includeKey:@"receive_user"];
    [query includeKey:@"user"];
    
    
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"CompletedOrderCell";
    CompletedOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CompletedOrderCell" owner:self options:nil][0];
    }
    cell.backgroundColor = kContentColor;
    cell.contentView.tag = indexPath.section;
    
    if (_dataArray.count > indexPath.section) {
        
        
        BmobObject *orderObject = [_dataArray objectAtIndex:indexPath.section];
        
        cell.time.text = [CommonMethods getYYYYMMddhhmmDateStr:orderObject.createdAt];
        
        cell.title.text = [orderObject objectForKey:@"order_title"];
        
        [cell.addressButton setTitle:[orderObject objectForKey:@"order_address"] forState:UIControlStateNormal];
        
        [cell.addressButton addTarget:self action:@selector(showLocation:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BmobObject *orderObject = [_dataArray objectAtIndex:indexPath.section];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    OrderProgressViewController *progressVC = [main instantiateViewControllerWithIdentifier:@"OrderProgressViewController"];
    
    progressVC.orderObject = orderObject;
    progressVC.isFisnish = YES;
    
    [self.navigationController pushViewController:progressVC animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}



-(void)showLocation:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    BmobObject *orderObject = [_dataArray objectAtIndex:cell.tag];
    
    BmobGeoPoint *point = [orderObject objectForKey:@"location"];
    
    LocationViewController *locVC = [[LocationViewController alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
    locVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:locVC animated:YES];
}


@end
