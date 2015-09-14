
//
//  HMDiscoverViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMDiscoverViewController.h"
#import "HMSearchBar.h"
#import "HMCommonGroup.h"
#import "HMCommonItem.h"
#import "HMCommonCell.h"
#import "HMCommonArrowItem.h"
#import "HMCommonSwitchItem.h"
#import "HMCommonLabelItem.h"
#import "HMOneViewController.h"
#import "HMTwoViewController.h"

@interface HMDiscoverViewController ()
@end

@implementation HMDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 搜索框
    HMSearchBar *searchBar = [HMSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
    // 初始化模型数据
    [self setupGroups];
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
    HMCommonArrowItem *hotStatus = [HMCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    hotStatus.destVcClass = [HMOneViewController class];
    
    HMCommonArrowItem *findPeople = [HMCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.badgeValue = @"N";
    findPeople.destVcClass = [HMOneViewController class];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonItem *gameCenter = [HMCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameCenter.destVcClass = [HMTwoViewController class];
    
    HMCommonLabelItem *near = [HMCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
    near.destVcClass = [HMTwoViewController class];
    near.text = @"测试文字";
    
    HMCommonSwitchItem *app = [HMCommonSwitchItem itemWithTitle:@"应用" icon:@"app"];
    app.destVcClass = [HMTwoViewController class];
    app.badgeValue = @"10";
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HMCommonSwitchItem *video = [HMCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
    video.operation = ^{
        HMLog(@"----点击了视频---");
    };
    
    HMCommonSwitchItem *music = [HMCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
    HMCommonItem *movie = [HMCommonItem itemWithTitle:@"电影" icon:@"movie"];
    movie.operation = ^{
        HMLog(@"----点击了电影");
    };
    HMCommonLabelItem *cast = [HMCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
    cast.operation = ^{
        HMLog(@"----点击了播客");
    };
    cast.badgeValue = @"5";
    cast.subtitle = @"(10)";
    cast.text = @"axxxx";
    HMCommonArrowItem *more = [HMCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
//    more.badgeValue = @"998";
    
    group.items = @[video, music, movie, cast, more];
}
@end
