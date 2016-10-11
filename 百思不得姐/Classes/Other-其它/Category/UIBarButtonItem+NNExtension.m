//
//  UIBarButtonItem+NNExtension.m
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "UIBarButtonItem+NNExtension.h"

@implementation UIBarButtonItem (NNExtension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightIamge target:(id)target action:(SEL)action {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightIamge] forState:UIControlStateHighlighted];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentBackgroundImage.size;
    
    return [[self alloc] initWithCustomView:button];
}

@end
