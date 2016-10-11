//
//  UIBarButtonItem+NNExtension.h
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NNExtension)
+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightIamge target:(id)target action:(SEL)action;
@end
