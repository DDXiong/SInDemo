//
//  HMAccountTool.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#define HMAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "HMAccountTool.h"
#import "HMAccount.h"

@implementation HMAccountTool

+ (void)save:(HMAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:HMAccountFilepath];
}

+ (HMAccount *)account
{
    // 读取帐号
    HMAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HMAccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];

    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}

+ (void)accessTokenWithParam:(HMAccessTokenParam *)param success:(void (^)(HMAccount *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[HMAccount class] success:success failure:failure];
}
@end
