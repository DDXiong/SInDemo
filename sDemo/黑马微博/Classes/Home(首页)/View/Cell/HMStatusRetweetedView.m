//
//  HMStatusRetweetedView.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMStatusRetweetedView.h"
#import "HMStatusRetweetedFrame.h"
#import "HMStatus.h"
#import "HMUser.h"
#import "HMStatusPhotosView.h"
#import "HMStatusLabel.h"
#import "HMStatusRetweetedToolbar.h"
#import "HMStatusDetailViewController.h"

@interface HMStatusRetweetedView()
/** 正文 */
@property (nonatomic, weak) HMStatusLabel *textLabel;
/** 配图相册 */
@property (nonatomic, weak) HMStatusPhotosView *photosView;
/** 工具条 */
@property (nonatomic, weak) HMStatusRetweetedToolbar *toolbar;
@end

@implementation HMStatusRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        
        // 1.正文（内容）
        HMStatusLabel *textLabel = [[HMStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 2.配图相册
        HMStatusPhotosView *photosView = [[HMStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        // 3.工具条
        HMStatusRetweetedToolbar *toolbar = [[HMStatusRetweetedToolbar alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        
        // 4.添加手势监听器
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 跳转控制器
    UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    // 当前选中的导航控制器
    UINavigationController *nav = (UINavigationController *)tabbarVc.selectedViewController;
    
    // push微博详情控制器
    HMStatusDetailViewController *detailVc = [[HMStatusDetailViewController alloc] init];
    detailVc.status = self.retweetedFrame.retweetedStatus;
    [nav pushViewController:detailVc animated:YES];
}

- (void)setRetweetedFrame:(HMStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    HMStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    
    // 1.正文（内容）
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 2.配图相册
    if (retweetedStatus.pic_urls.count) { // 有配图
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    // 3.工具条
    if (retweetedStatus.isDetail) {
        self.toolbar.frame = retweetedFrame.toolbarFrame;
        self.toolbar.status = retweetedFrame.retweetedStatus;
        self.toolbar.hidden = NO;
    } else {
        self.toolbar.hidden = YES;
    }
}

@end