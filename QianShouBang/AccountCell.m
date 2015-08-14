//
//  AccountCell.m
//  QianShouBang
//
//  Created by ucan on 15/8/14.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "AccountCell.h"
#import "Constants.h"

@implementation AccountCell

- (void)awakeFromNib {
    self.frame = CGRectMake(0, 0, ScreenWidth, 40);
    self.backgroundColor = kContentColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth/4 , 40)];
        _time.text = @"06/08";
        _time.textAlignment = NSTextAlignmentCenter;
        _time.font = FONT_14;
        _time.textColor = kBlueColor;
        [self addSubview:_time];
        
        _fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, 0,ScreenWidth/4 , 40)];
        _fromLabel.text = @"支付宝支出";
        _fromLabel.textAlignment = NSTextAlignmentCenter;
        _fromLabel.font = FONT_14;
        _fromLabel.textColor = kBlueColor;
        [self addSubview:_fromLabel];
        
        _money = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2,0 ,ScreenWidth/4 , 40)];
        _money.text = @"＋500";
        _money.textAlignment = NSTextAlignmentCenter;
        _money.font = FONT_14;
        _money.textColor = [UIColor redColor];
        [self addSubview:_money];
        
        _remainMoney = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*3/4,0 ,ScreenWidth/4 , 40)];
        _remainMoney.text = @"＋500";
        _remainMoney.textAlignment = NSTextAlignmentCenter;
        _remainMoney.font = FONT_14;
        _remainMoney.textColor = [UIColor redColor];
        [self addSubview:_remainMoney];
        
        _line = [[UIImageView alloc]initWithFrame:CGRectMake(8, 39, ScreenWidth-8, 1)];
        _line.backgroundColor = kLineColor;
        [self addSubview:_line];

    }
    return self;
}


@end
