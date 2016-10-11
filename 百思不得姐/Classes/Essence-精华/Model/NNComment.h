//
//  NNComment.h
//  百思不得姐
//
//  Created by iOS on 16/10/1.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NNUser;

@interface NNComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voice_time;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceURL;

/** 被赞的数量 */
@property (nonatomic, assign) NSInteger like_count;

/** 评论文字的内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic, strong) NNUser *user;
@end
