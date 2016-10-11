//
//  NNMeViewController.m
//  百思不得姐
//
//  Created by iOS on 16/9/25.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNMeViewController.h"
#import "NNMeCell.h"
#import "NNMeFooterView.h"
#import "NNSettingViewController.h"

@interface NNMeViewController ()<NNMeFooterViewDelegate>

@end

static NSString *NNMeID = @"me";
@implementation NNMeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}

- (void)setupTableView {

    // 设置背景色
    self.view.backgroundColor = NNGlobalBg;
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[NNMeCell class] forCellReuseIdentifier:NNMeID];
    
    // 调整header和footer
//    self.tableView.sectionHeaderHeight = NNTopicCellMargin;
//    self.tableView.sectionFooterHeight = NNTopicCellMargin;
    
    // 设置footerView
    NNMeFooterView *MeFooterView = [[NNMeFooterView alloc] init];
    MeFooterView.delegate = self;
    self.tableView.tableFooterView = MeFooterView;
    // 调整inset
//    self.tableView.contentInset = UIEdgeInsetsMake(NNTopicCellMargin, 0, 0, 0);
    
}

- (void)setupNav {
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *nightModeButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    
    self.navigationItem.rightBarButtonItems = @[settingButton, nightModeButton];
}


- (void)settingClick {
    [self.navigationController pushViewController:[[NNSettingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}

- (void)nightModeClick {

    NNLogFunc;
}

#pragma mark - NNMeFooterViewDelegate代理方法
- (void)MeFooterViewDidLoadDate:(NNMeFooterView *)MeFooterView {

    self.tableView.contentInset = UIEdgeInsetsMake(64 + NNTopicCellMargin, 0, MeFooterView.height + 45, 0);
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return NNTopicCellMargin;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    return NNTopicCellMargin;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NNMeCell *cell = [tableView dequeueReusableCellWithIdentifier:NNMeID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
        cell.textLabel.text = @"登陆/注册";
    } else if (indexPath.section == 1) {
    
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

@end
