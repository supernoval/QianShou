//
//  BmobDataListName.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/8/5.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//


//牵手邦   bmob 数据库表 名

//用户表
#define kUserClassName  @"_User"

//奖励机制表
#define kRewardClassName  @"RewardLimitation"

//图片
#define kAttachItem       @"AttachItem"
//订单
#define kOrder             @"Order"

//呐喊
#define kWeiboListItem      @"WeiboListItem"

//呐喊回复
#define kCommentList      @"CommentList"

//系统消息
#define kSystemMsg          @"SystemMsg"

//点赞
#define kZanList            @"ZanList"  //存本地数组   weiboItem objectid, zanuser objectid ,iszan bool

/*User表对应Key*/
#define kUser @"_User"
#define kobjectId @"objectId"
#define kusername @"username"
#define kmobilePhoneNumber @"mobilePhoneNumber"
#define kuser_sex @"user_sex"
#define kuser_individuality_signature @"user_individuality_signature"
#define kuser_phone @"user_phone"
#define knick @"nick"
#define kavatar @"avatar"
#define klocation @"location"
#define kauthData @"authData"
#define kwheather_allow_add @"wheather_allow_add"
#define kuser_birthday @"user_birthday"
#define kuser_city @"user_city"
#define kbalance @"balance"
#define kuser_level @"user_level"

/*牵手币商城表*/
#define kIntergralBean @"IntergralBean"
#define kintergralGoodsDescription @"intergralGoodsDescription"
#define kintergralGoodsIcon_url @"intergralGoodsIcon_url"
#define kintergralGoodsSurplusNumber @"intergralGoodsSurplusNumber"
#define kintergralGoodsTitle @"intergralGoodsTitle"
#define kintergralGoodsValue @"intergralGoodsValue"

/*账户明细表*/
#define kDetailAccount   @"DetailAccount"
#define ktMoneyCount     @"tMoneyCount"
#define ktIntegralCount  @"tIntegralCount"
#define ktIntegral       @"tIntegral"
#define ktMoney          @"tMoney"
#define ktJiangLi        @"tJiangLi"
#define kisAccountAmountType @"isAccountAmountType"
#define kisQsMoneyType   @"isQsMoneyType"
#define kIntergral_exchange @"Intergral_exchange"

/*系统消息表对应Key*/
#define ksystem_msg_content @"system_msg_content"
#define ksystem_msg_title @"system_msg_title"

/*兑换牵手币*/
#define kExchangeMoneyBean @"ExchangeMoneyBean"
#define kexchange_integrl_num @"exchange_integrl_num"
#define kuse_money_value @"use_money_value"
#define  kintergralBean  @"intergralBean"

/*余额提现表*/
#define kCash @"Cash"
#define kcash_account  @"cash_account"
#define kcash_number   @"cash_number"
#define kis_need_cash  @"is_need_cash"
#define kname          @"name"