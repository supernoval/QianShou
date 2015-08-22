//
//  BaseTableViewController.h
//  QianShouBang
//
//  Created by Haikun Zhu on 15/7/31.
//  Copyright (c) 2015年 zhuhaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "Constants.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CommonMethods.h"
#import "MyProgressHUD.h"
#import "QSUser.h"
#import "BmobDataListName.h"
#import "UIImageView+WebCache.h"
#import <BmobIM/BmobIM.h>
#import <BmobIM/BmobChatManager.h>
#import <BmobIM/BmobChat.h>
#import <BmobIM/BmobDB.h>
#import "UIImageView+WebCache.h"
#import "YellModel.h"
#import "SDPhotoItem.h"
#import "SDPhotoGroup.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface BaseTableViewController : UITableViewController
{
    
}

@property (nonatomic ) BOOL notNeedSetTitle;


-(void)addHeaderRefresh;
-(void)addFooterRefresh;

-(void)endHeaderRefresh;
-(void)endFooterRefresh;

-(void)removeHeaderRefresh;
-(void)removeFooterRefresh;

-(void)headerRefresh;
-(void)footerRefresh;



@end
