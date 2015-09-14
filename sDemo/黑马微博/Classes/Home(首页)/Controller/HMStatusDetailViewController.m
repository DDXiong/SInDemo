//
//  HMStatusDetailViewController.m
//  黑马微博
//
//  Created by apple on 14-7-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMStatusDetailViewController.h"
#import "HMStatusDetailView.h"
#import "HMStatusDetailFrame.h"
#import "HMStatus.h"
#import "HMStatusDetailBottomToolbar.h"
#import "HMStatusDetailTopToolbar.h"
#import "HMStatusTool.h"
#import "HMComment.h"

@interface HMStatusDetailViewController () <UITableViewDataSource, UITableViewDelegate, HMStatusDetailTopToolbarDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) HMStatusDetailTopToolbar *topToolbar;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *reposts;
@end

@implementation HMStatusDetailViewController
- (NSMutableArray *)comments
{
    if (_comments == nil) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}

- (NSMutableArray *)reposts
{
    if (_reposts == nil) {
        self.reposts = [NSMutableArray array];
    }
    return _reposts;
}

- (HMStatusDetailTopToolbar *)topToolbar
{
    if (!_topToolbar) {
        self.topToolbar = [HMStatusDetailTopToolbar toolbar];
        self.topToolbar.status = self.status;
        self.topToolbar.delegate = self;
    }
    return _topToolbar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
    // 创建tableView
    [self setupTableView];
    
    // 创建微博详情控件
    [self setupDetailView];
    
    // 创建底部工具条
    [self setupBottomToolbar];
}

/**
 *  创建底部工具条
 */
- (void)setupBottomToolbar
{
    HMStatusDetailBottomToolbar *bottomToolbar = [[HMStatusDetailBottomToolbar alloc] init];
    bottomToolbar.y = CGRectGetMaxY(self.tableView.frame);
    bottomToolbar.width = self.view.width;
    bottomToolbar.height = self.view.height - self.tableView.height;
    [self.view addSubview:bottomToolbar];
}

/**
 *  创建tableView
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.width = self.view.width;
    tableView.height = self.view.height - 35;
    tableView.backgroundColor = HMGlobalBg;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

/**
 *  创建微博详情控件
 */
- (void)setupDetailView
{
    // 创建微博详情控件
    HMStatusDetailView *detailView = [[HMStatusDetailView alloc] init];
    // 创建frame对象
    HMStatusDetailFrame *detailFrame = [[HMStatusDetailFrame alloc] init];
    self.status.retweeted_status.detail = YES;
    detailFrame.status = self.status;
    // 传递frame数据
    detailView.detailFrame = detailFrame;
    // 设置微博详情的高度
    detailView.height = detailFrame.frame.size.height;
    self.tableView.tableHeaderView = detailView;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topToolbar.selectedButtonType == HMStatusDetailTopToolbarButtonTypeComment) {
        return self.comments.count;
    } else {
        return self.reposts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (self.topToolbar.selectedButtonType == HMStatusDetailTopToolbarButtonTypeComment) {
        HMComment *cmt = self.comments[indexPath.row];
        cell.textLabel.text = cmt.text;
    } else {
        HMStatus *status = self.reposts[indexPath.row];
        cell.textLabel.text = status.text;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topToolbar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.topToolbar.height;
}

#pragma mark - 顶部工具条的代理
- (void)topToolbar:(HMStatusDetailTopToolbar *)topToolbar didSelectedButton:(HMStatusDetailTopToolbarButtonType)buttonType
{
    [self.tableView reloadData];
    switch (buttonType) {
        case HMStatusDetailTopToolbarButtonTypeComment: // 评论
            [self loadComments];
            break;
            
        case HMStatusDetailTopToolbarButtonTypeRetweeted: // 转发
            [self loadRetweeteds];
            break;
    }
}

/**
 *  加载评论数据
 */
- (void)loadComments
{
    HMCommentsParam *param = [HMCommentsParam param];
    param.id = self.status.idstr;
    HMComment *cmt = [self.comments firstObject];
    param.since_id = cmt.idstr;
    
    [HMStatusTool commentsWithParam:param success:^(HMCommentsResult *result) {
        // 评论总数
        self.status.comments_count = result.total_number;
        self.topToolbar.status = self.status;
        
        // 累加评论数据
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
        [self.comments insertObjects:result.comments atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  加载转发数据
 */
- (void)loadRetweeteds
{
    HMRepostsParam *param = [HMRepostsParam param];
    param.id = self.status.idstr;
    HMStatus *status = [self.reposts firstObject];
    param.since_id = status.idstr;
    
    [HMStatusTool repostsWithParam:param success:^(HMRepostsResult *result) {
        // 转发总数
        self.status.reposts_count = result.total_number;
        self.topToolbar.status = self.status;
        
        // 累加评论数据
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.reposts insertObjects:result.reposts atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
