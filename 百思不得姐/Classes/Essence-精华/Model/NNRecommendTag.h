//
//  NNRecommendTag.h
//  百思不得姐
//
//  Created by iOS on 16/9/27.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNRecommendTag : NSObject

/** 图片 */
@property (nonatomic, strong) NSString *image_list;

/** 名字 */
@property (nonatomic, strong) NSString  *theme_name;

/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
