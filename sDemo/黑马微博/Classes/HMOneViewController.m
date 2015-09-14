//
//  HMOneViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMOneViewController.h"
#import "HMTwoViewController.h"

@interface HMOneViewController ()
- (IBAction)jumpTwo;

@end

@implementation HMOneViewController

- (IBAction)jumpTwo {
    HMTwoViewController *two = [[HMTwoViewController alloc] init];
    two.title = @"TwoVc";
    [self.navigationController pushViewController:two animated:YES];
}
@end
