//
//  UIView+NNExtension.h
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NNExtension)

/** size */
@property (nonatomic, assign) CGSize size;
/** 宽度 */
@property (nonatomic, assign) CGFloat width;
/** 高度 */
@property (nonatomic, assign) CGFloat height;
/** x值 */
@property (nonatomic, assign) CGFloat x;
/** y值 */
@property (nonatomic, assign) CGFloat y;

/** 中心x */
@property (nonatomic, assign) CGFloat centerX;

/** 中心y */
@property (nonatomic, assign) CGFloat centerY;


/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
@end
