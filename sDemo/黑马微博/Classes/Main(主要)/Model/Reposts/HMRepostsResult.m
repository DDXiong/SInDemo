//
//  HMRepostsResult.m
//  黑马微博
//
//  Created by apple on 14-7-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMRepostsResult.h"
#import "MJExtension.h"
#import "HMStatus.h"

@implementation HMRepostsResult
- (NSDictionary *)objectClassInArray
{
    return @{@"reposts" : [HMStatus class]};
}
@end
