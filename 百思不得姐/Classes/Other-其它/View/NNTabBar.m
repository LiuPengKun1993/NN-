//
//  NNTabBar.m
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNTabBar.h"
#import "NNPublishViewController.h"

@interface NNTabBar ()

/** 自定义按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation NNTabBar
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        // 设置 tabBar 背景色
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publichClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publichClick {

    NNPublishViewController *publish = [[NNPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
//    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(width * .5, height * .5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIControl *button in self.subviews) {
        
//        if (![button isKindOfClass:NSClassFromString(@"UITabbarButton")]) continue;
        if (![button isKindOfClass:[UIControl class]] || (button == self.publishButton)) continue;
        {
            // 计算按钮的x值
            CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            // 增加索引
            index ++;
            
            if (added == NO) {
                [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        added = YES;
    }
}

- (void)buttonClick
{
    // 发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:NNTabBarDidSelectNotification object:nil userInfo:nil];
}
@end
