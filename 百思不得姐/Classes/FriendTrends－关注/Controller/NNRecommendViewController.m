//
//  NNRecommendViewController.m
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "NNRecommendCategoryCell.h"
#import "MJExtension.h"
#import "NNRecommendCategory.h"
#import "NNRecommendUser.h"
#import "NNRecommendUserCell.h"
#import "MJRefresh.h"
#define NNSelectedCategory self.categories[self.categoriesTableView.indexPathForSelectedRow.row]


@interface NNRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;

/**
 *  右边的表格
 */
@property (weak, nonatomic) IBOutlet UITableView *userTabelView;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

static NSString * const NNCategoryID = @"category";
static NSString * const NNUserID = @"user";
@implementation NNRecommendViewController

- (AFHTTPSessionManager *)manager {

    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setUpTableView];
    
    // 添加刷新控件
    [self setUpRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
    
}


/**
 *  加载左侧的类别数据
 */
- (void)loadCategories {
    // 显示指示器
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        // 服务器返回的JSDN数据
        self.categories = [NNRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoriesTableView reloadData];
        
        // 默认选中首行
        [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTabelView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载信息失败！"];
    }];
}
/**
 *  控件的初始化
 */
- (void)setUpTableView {
    // 注册
    [self.categoriesTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NNRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:NNCategoryID];
    
    [self.userTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([NNRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:NNUserID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoriesTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTabelView.contentInset = self.categoriesTableView.contentInset;
    self.userTabelView.rowHeight = 70;
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = NNGlobalBg;
}

/**
 *  添加刷新控件
 */
- (void)setUpRefresh {

    self.userTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTabelView.mj_footer.hidden = YES;
 }

- (void)loadNewUsers {
    
    NNRecommendCategory *RC = NNSelectedCategory;
    
    RC.currentPage = 1;

    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(RC.ID);
    params[@"page"] = @(RC.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [NNRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 清除所有旧数据
        [RC.users removeAllObjects];
        // 添加到当前类别对应的用户数组中
        [RC.users addObjectsFromArray:users];
        // 保存总数
        RC.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        // 刷新右边的表格
        [self.userTabelView reloadData];
        // 结束刷新
        [self.userTabelView.mj_header endRefreshing];
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        // 结束刷新
        [self.userTabelView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers {
    NNRecommendCategory *RC = NNSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(RC.ID);
    params[@"page"] = @(++RC.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [NNRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [RC.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        // 刷新右边的表格
        [self.userTabelView reloadData];
        // 结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        // 结束刷新
        [self.userTabelView.mj_footer endRefreshing];
    }];
}

- (void)checkFooterState {

    NNRecommendCategory *RC = NNSelectedCategory;
    
    self.userTabelView.mj_footer.hidden = (RC.users.count == 0);
    
    if (RC.users.count == RC.total) {
        [self.userTabelView.mj_footer endRefreshingWithNoMoreData];
    } else {
    
        [self.userTabelView.mj_footer endRefreshing];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.categoriesTableView) { // 左边的类别表格
        return self.categories.count;
    } else { // 右边的用户表格
        [self checkFooterState];
        return [NNSelectedCategory users].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categoriesTableView) { // 左边的类别表格
        NNRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NNCategoryID];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    } else { // 右边的用户表格
        NNRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NNUserID];
        
        cell.user = [NNSelectedCategory users][indexPath.row];
        
        return cell;
    }
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NNLogFunc;
    // 结束刷新
    [self.userTabelView.mj_header endRefreshing];
    [self.userTabelView.mj_footer endRefreshing];
    
    
    NNRecommendCategory *category = self.categories[indexPath.row];
    
    
    if(category.users.count) {
    // 显示曾经的数据
        [self.userTabelView reloadData];
    } else {
       
        [self.userTabelView reloadData];
        // 进入下拉刷新
        [self.userTabelView.mj_header beginRefreshing];
    }
    
}
/**
 1.目前只能显示1页数据
 2.重复发送请求
 3.网络慢带来的细节问题
 */

#pragma mark - 控制器的销毁
- (void)dealloc {

    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
