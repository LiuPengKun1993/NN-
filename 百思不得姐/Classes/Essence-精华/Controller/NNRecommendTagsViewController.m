//
//  NNRecommendTagsViewController.m
//  百思不得姐
//
//  Created by iOS on 16/9/27.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNRecommendTagsViewController.h"

#import "NNRecommendTag.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "NNRecommendTagCell.h"

@interface NNRecommendTagsViewController ()

/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;


@end
static NSString *const NNTagsID = @"tag";


@implementation NNRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self loadTags];
}

#pragma mark - 设置tableView内容
- (void)setUpTableView {

    self.title = @"推荐标签";
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NNRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:NNTagsID];
    
    self.tableView.rowHeight = 70;
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置背景色
    self.tableView.backgroundColor = NNGlobalBg;
}

- (void)loadTags {

    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [NNRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NNRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:NNTagsID];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
