//
//  RewardLimitationModel.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/6.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import "JSONModel.h"

@interface RewardLimitationModel : JSONModel

@property (nonatomic) BOOL b_SenderAward;//发单人是否奖励
@property (nonatomic) BOOL b_RecipientAward;	//接单人是否奖励
@property (nonatomic) double d_SenderAwardRatio;//发单人奖励比例
@property (nonatomic) double d_RecipientAwardRatio;//接单人奖励比例
@property (nonatomic) NSString *CityAwardCode;//城市代码奖励集合
@property (nonatomic) double PlatformFee;//平台手续费
@property (nonatomic) BOOL b_RewardCurrencyActivity;//牵手币是否奖励
@property (nonatomic) double FirstClassAward;//一级奖励
@property (nonatomic) double TwoLevelAwards;//二级奖励
@property (nonatomic) double ThreeLevelAwards;//三级奖励
@property (nonatomic) double FirstClassAwardNum;//一级奖励数额
@property (nonatomic) double TwoLevelAwardsNum;//二级奖励数额
@property (nonatomic) double ThreeLevelAwardsNum;//三级奖励数额
@end
