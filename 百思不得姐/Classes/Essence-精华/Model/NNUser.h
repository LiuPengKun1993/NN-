//
//  NNUser.h
//  百思不得姐
//
//  Created by iOS on 16/10/1.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;

/** 性别 */
@property (nonatomic, copy) NSString *sex;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
