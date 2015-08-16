//
//  UserService.m
//  BmobIMDemo
//
//  Created by Bmob on 14-7-11.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "UserService.h"
#import "Location.h"
#import <BmobIM/BmobUserManager.h>


@implementation UserService

+(void)saveFriendsList{
    BmobDB *db = [BmobDB currentDatabase];
    [db createDataBase];
    [[BmobUserManager currentUserManager] queryCurrentContactArray:^(NSArray *array, NSError *error) {
        NSMutableArray *chatUserArray = [NSMutableArray array];
        for (BmobUser * user in array) {
            BmobChatUser *chatUser = [[BmobChatUser alloc] init];
            chatUser.username      = [user objectForKey:@"username"];
            chatUser.avatar        = [user objectForKey:@"avatar"];
            chatUser.nick          = [user objectForKey:@"nick"];
            chatUser.objectId      = user.objectId;
            [chatUserArray addObject:chatUser];
        }
        [db saveOrCheckContactList:chatUserArray];
    }];
}



@end
