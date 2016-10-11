//
//  NNPushGuideView.m
//  百思不得姐
//
//  Created by iOS on 16/9/28.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNPushGuideView.h"

@implementation NNPushGuideView

+ (void)show {

    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 获得沙盒中存储的版本号
    NSString *sanboxVerson = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVerson]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        NNPushGuideView *guideView = [NNPushGuideView guideView];
        
        guideView.frame = window.bounds;
        
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (instancetype) guideView {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close {
    [self removeFromSuperview];
}



@end
