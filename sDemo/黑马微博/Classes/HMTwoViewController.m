//
//  HMTwoViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMTwoViewController.h"
#import "HMThreeViewController.h"

@interface HMTwoViewController ()
- (IBAction)jumpThree;

@end

@implementation HMTwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"哈哈" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (IBAction)jumpThree {
    HMThreeViewController *vc = [[HMThreeViewController alloc] init];
    vc.title = @"ThreeVC";
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
