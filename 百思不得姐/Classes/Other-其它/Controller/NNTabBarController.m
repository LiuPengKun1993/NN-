//
//  NNTabBarController.m
//  百思不得姐
//
//  Created by iOS on 16/9/25.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNTabBarController.h"
#import "NNEssenceViewController.h"
#import "NNNewViewController.h"
#import "NNFriendTrendsViewController.h"
#import "NNMeViewController.h"
#import "NNTabBar.h"
#import "NNNavigationController.h"

@interface NNTabBarController ()

@end

@implementation NNTabBarController

+ (void)initialize {
    
    // 通过 appearance 统一设置所有 UITabBarItem 的文字属性
    // 后面带有 UI_APPEARANCE_SELECTOR 的方法，都可以通过 appearance 设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *items = [UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildVC:[[NNEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selected:@"tabBar_essence_click_icon"];
    [self setUpChildVC:[[NNNewViewController alloc] init] title: @"新帖" image:@"tabBar_new_icon" selected:@"tabBar_new_click_icon"];
    [self setUpChildVC:[[NNFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selected:@"tabBar_friendTrends_click_icon"];
    [self setUpChildVC:[[NNMeViewController alloc] init] title:@"我的" image:@"tabBar_me_icon" selected:@"tabBar_me_click_icon"];
    
    // 更换 tabBar
    [self setValue:[[NNTabBar alloc] init] forKeyPath:@"tabBar"];
}
/**
 *  初始化子控制器
 *
 *  @param VC            控制器
 *  @param title         文字
 *  @param image         图片
 *  @param selectedImage 选中时候的图片
 */
- (void)setUpChildVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selected:(NSString *)selectedImage {

    VC.navigationItem.title = title;
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 颜色通道
    // RGB 颜色对照表
    // 各个控制器的背景色不能提前创建
//    VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/ 100.0 green:arc4random_uniform(100) / 100.0 blue:arc4random_uniform(100) / 100.0 alpha:1.0];
    NNNavigationController *nav = [[NNNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
}



@end
