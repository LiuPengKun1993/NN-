//
//  NNCommentViewController.m
//  百思不得姐
//
//  Created by iOS on 16/10/1.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNCommentViewController.h"
#import "NNCommentCell.h"
#import "NNTopic.h"
#import "NNTopicCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "NNComment.h"
#import "NNCommentHeaderView.h"

@interface NNCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 *  工具条底部间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;

/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) NNComment *saved_top_cmt;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

@end

static NSString *const NNCommentID = @"comment";

@implementation NNCommentViewController



- (AFHTTPSessionManager *)manager {

    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];

}

- (void)setupBasic {

    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" hightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // cell的高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 背景色
    self.tableView.backgroundColor = NNGlobalBg;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NNCommentCell class]) bundle:nil] forCellReuseIdentifier:NNCommentID];
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, NNTopicCellMargin, 0);
    
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [notification.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 修改底部约束
    self.bottomSpace.constant = NNScreenH - frame.origin.y;
    
    // 动画时间
    CGFloat duration = [notification.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)setupHeader {
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    // 清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    // 添加cell
    NNTopicCell *cell = [NNTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(NNScreenW, self.topic.cellHeight);
    [header addSubview:cell];

    // header的高度
    header.height = self.topic.cellHeight + NNTopicCellMargin;
    
    // 设置header
    self.tableView.tableHeaderView = header;
    
}

#pragma mark - 刷新视图
- (void)setupRefresh {

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - loadNewComments
- (void)loadNewComments {

    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 最热评论
        self.hotComments = [NNComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [NNComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 页码
        self.page = 1;
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - loadMoreComments
- (void)loadMoreComments {

    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    NNComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 最新评论
        NSArray *newComments = [NNComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments addObjectsFromArray:newComments];
        
        
        // self.latestComments = @[1, 3, 0, 9]
        // newComments = @[2, 8]
        //        [self.latestComments addObject:newComments];
        // self.latestComments = @[1, 3, 0, 9, @[2, 8]]
        
        
        // 页码
        self.page = page;
        
         // 刷新数据
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
            
        } else {
        
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - dealloc
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    // 取消所有任务
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}



#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2;

    if (latestCount) return 1;
    
    return 0;
}

#pragma mark - numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    // 隐藏尾部控件
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第0组
    return latestCount;
}


#pragma mark - viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NNCommentHeaderView *header = [NNCommentHeaderView headerViewWithTableView:tableView];
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
    
        header.title = @"最新评论";
    }
    return header;
}

#pragma mark - cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NNCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NNCommentID];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;
}

- (NNComment *)commentInIndexPath:(NSIndexPath *)indexPath {

    return [self commetsInSection:indexPath.section][indexPath.row];
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commetsInSection:(NSInteger)section {

    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}


#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

     //创建menu菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    } else {
    
         // 被点击的cell
        NNCommentCell *cell = (NNCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        // 出现一个第一响应者
        [cell becomeFirstResponder];
        
        // 显示MenuController
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
        menu.menuItems = @[ding, replay, report, copy];
        
        CGRect cellRect = CGRectMake(0, cell.height / 2, cell.width, cell.height / 2);
        [menu setTargetRect:cellRect inView:cell];
        [menu setMenuVisible:YES animated:YES];
        
    }
}
- (void)ding:(UIMenuController *)menu {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NNLog(@"%s -- %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NNLog(@"%s -- %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NNLog(@"%s -- %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)copy:(UIMenuController *)menu {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = [self commentInIndexPath:indexPath].content;
}


@end
