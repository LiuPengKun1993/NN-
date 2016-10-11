//
//  NNRecommendUser.h
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;

/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, assign) NSInteger fans_count;

/** 粉丝数 */
@property (nonatomic, copy) NSString *screen_name;

@end
