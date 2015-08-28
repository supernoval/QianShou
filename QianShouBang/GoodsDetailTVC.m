//
//  GoodsDetailTVC.m
//  QianShouBang
//
//  Created by Leo on 15/8/9.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "GoodsDetailTVC.h"
#import "ImageCell.h"
#import "TitleCell.h"
#import "GoodsDescripCell.h"
#import "StringHeight.h"

@interface GoodsDetailTVC ()
@property (nonatomic)CGFloat image_height;
@property (nonatomic, strong)UIImageView *goods_imageview;
@property (nonatomic, strong)UIImage *goods_image;

@end

@implementation GoodsDetailTVC
@synthesize obj;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor = kBackgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self tableFooterView];
    [self loadImage];
    
    // Do any additional setup after loading the view.
}

- (void)loadImage{
    self.goods_imageview = [[UIImageView alloc]init];
    
    [self.goods_imageview sd_setImageWithURL:[NSURL URLWithString:[obj objectForKey:kintergralGoodsIcon_url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if (error) {
        }else{
        self.goods_image = image;
        CGFloat x = ScreenWidth/image.size.width;
        self.image_height = image.size.height * x;
        
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
    
    return 4;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headView.backgroundColor = [UIColor clearColor];
    
    return headView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.image_height;
    }else if(indexPath.row == 3){
        return [StringHeight heightWithText:[obj objectForKey:kintergralGoodsDescription] font:FONT_14 constrainedToWidth:ScreenWidth-16]+120;
        
    }
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *imageCellId = @"ImageCell";
    ImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:imageCellId];
    if (imageCell == nil) {
        imageCell = [[NSBundle mainBundle]loadNibNamed:@"ImageCell" owner:self options:nil][0];
    }
    imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    static NSString *titleCellId = @"ImageCell";
    TitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:titleCellId];
    if (titleCell == nil) {
        titleCell = [[NSBundle mainBundle]loadNibNamed:@"TitleCell" owner:self options:nil][0];
    }
    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    static NSString *detailCellId = @"ImageCell";
    GoodsDescripCell *detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellId];
    if (detailCell == nil) {
        detailCell = [[NSBundle mainBundle]loadNibNamed:@"GoodsDescripCell" owner:self options:nil][0];
    }
    detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        {
            imageCell.image.frame = CGRectMake(0, 0, ScreenWidth, self.image_height);
            imageCell.image.image = self.goods_image;

            return imageCell;
        }
            break;
            
            case 1:
        {
            titleCell.title.text = @"兑换标题:";
            titleCell.text.text = [obj objectForKey:kintergralGoodsTitle];
            return titleCell;
        }
            break;
            
        case 2:
        {
            titleCell.title.text = @"兑换价格:";
            titleCell.text.text = [NSString stringWithFormat:@"%@",[obj objectForKey:kintergralGoodsValue]];
            return titleCell;
        }
            break;
            
        case 3:
        {
            detailCell.title.text = @"商品描述:";
            detailCell.descrip.text = [obj objectForKey:kintergralGoodsDescription];
            NSLog(@"描述：%@",[obj objectForKey:kintergralGoodsDescription]);
            return detailCell;
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
    
}

#pragma 立即兑换
- (UIView *)tableFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 75)];
    footerView.backgroundColor = kBackgroundColor;
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 15, ScreenWidth-16, 40)];
    logoutBtn.layer.masksToBounds = YES;
    logoutBtn.layer.cornerRadius = 4.0;
    logoutBtn.layer.borderColor = kYellowColor.CGColor;
    logoutBtn.layer.borderWidth = 1.0;
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:kYellowColor];
    logoutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    logoutBtn.titleLabel.font = FONT_16;
    [logoutBtn addTarget:self action:@selector(withDrawAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logoutBtn];
    return footerView;
}

- (void)withDrawAction:(UIButton *)button{
    self.view.backgroundColor = [UIColor redColor];
}

@end
