//
//  NNSquare.h
//  百思不得姐
//
//  Created by iOS on 16/10/2.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNSquare : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *icon;

/** 标题文字 */
@property (nonatomic, copy) NSString *name;

/** 链接 */
@property (nonatomic, copy) NSString *url;

/** ID */
@property (nonatomic, assign) NSInteger ID;

@end
