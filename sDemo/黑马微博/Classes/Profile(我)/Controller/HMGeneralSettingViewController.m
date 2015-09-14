//
//  HMGeneralSettingViewController.m
//  黑马微博
//
//  Created by apple on 14-7-21.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMGeneralSettingViewController.h"
#import "HMCommonGroup.h"
#import "HMCommonItem.h"
#import "HMCommonArrowItem.h"
#import "HMCommonSwitchItem.h"
#import "MBProgressHUD+MJ.h"
#import "SDImageCache.h"
#import "HMCommonLabelItem.h"
#import "NSString+File.h"

@interface HMGeneralSettingViewController ()

@end

@implementation HMGeneralSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    // 2.设置组的所有行数据
    HMCommonLabelItem *readMdoe = [HMCommonLabelItem itemWithTitle:@"阅读模式"];
    readMdoe.text = @"有图模式";
    
    group.items = @[readMdoe];
}

- (void)setupGroup1
{
    // 1.创建组
    HMCommonGroup *group = [HMCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
     HMCommonArrowItem *clearCache = [HMCommonArrowItem itemWithTitle:@"清除图片缓存"];
    
    // 设置缓存的大小
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    [caches stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    NSString *imageCachePath = [SDImageCache sharedImageCache].diskCachePath;
    long long fileSize = [imageCachePath fileSize];
    
    clearCache.subtitle = [NSString stringWithFormat:@"(%.1fM)", fileSize / (1000.0 * 1000.0)];
    
    __weak typeof(clearCache) weakClearCache = clearCache;
    __weak typeof(self) weakVc = self;
    clearCache.operation = ^{
        [MBProgressHUD showMessage:@"正在清除缓存...."];
        
        // 清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:imageCachePath error:nil];
        
        // 设置subtitle
        weakClearCache.subtitle = nil;
        
        // 刷新表格
        [weakVc.tableView reloadData];
        
        [MBProgressHUD hideHUD];
    };
    
    group.items = @[clearCache];
    
//    HMLog(@"%lld", [@"/Users/apple/Desktop/音乐" fileSize]);
}

- (void)dealloc
{
    HMLog(@"HMGeneralSettingViewController---dealloc");
}

/**
 *  计算某个文件\文件夹的大小
 *
 *  @param file 文件\文件夹的路径
 */
//- (long long)fileSizeAtFile:(NSString *)file
//{
//    // 1.文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    
//    // 2.判断file是否存在
//    BOOL isDirectory = NO;
//    BOOL fileExists = [mgr fileExistsAtPath:file isDirectory:&isDirectory];
//    // 文件\文件夹不存在
//    if (fileExists == NO) return 0;
//    
//    // 3.判断file是否为文件夹
//    if (isDirectory) { // 是文件夹
//        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:file error:nil];
//        long long totalSize = 0;
//        for (NSString *subpath in subpaths) {
//            NSString *fullSubpath = [file stringByAppendingPathComponent:subpath];
//            totalSize += [self fileSizeAtFile:fullSubpath];
//        }
//        return totalSize;
//    } else { // 不是文件夹, 文件
//        // 直接计算当前文件的尺寸
//        NSDictionary *attr = [mgr attributesOfItemAtPath:file error:nil];
//        return [attr[NSFileSize] longLongValue];
//    }
//    
//    // 只能获得当前文件夹里面的子文件\子文件夹
////    NSArray *contents = [mgr contentsOfDirectoryAtPath:file error:nil];
//}

- (void)setupGroup2
{
    
}
@end
