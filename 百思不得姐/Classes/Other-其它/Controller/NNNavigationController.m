//
//  NNNavigationController.m
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNNavigationController.h"


@implementation NNNavigationController
/**
 *  当第一次使用这个类的时候调用一次
 */
+ (void)initialize {

    // 当导航栏用在 NNNavigationController 中，appearance设置才会生效
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}


- (void)viewDidLoad {
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

//    self.navigationBar.tintColor = [UIColor blackColor];
}
/**
 *  可以在这个方法中拦截所有 push 进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.childViewControllers.count > 0) { //如果 push 进来的不是第一个控制器
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, - 10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    /**
     *   这句super 的push要放在后面，让viewController可以覆盖上面设置的leftBarButtonItem
     */
    [super pushViewController:viewController animated:animated];
    
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

- (void)back {

    [self popViewControllerAnimated:YES];
}
@end
