//
//  HMCommentsResult.m
//  黑马微博
//
//  Created by apple on 14-7-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMCommentsResult.h"
#import "MJExtension.h"
#import "HMComment.h"

@implementation HMCommentsResult
- (NSDictionary *)objectClassInArray
{
    return @{@"comments" : [HMComment class]};
}
@end
