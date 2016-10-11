//
//  NNTopic.h
//  百思不得姐
//
//  Created by iOS on 16/9/28.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NNComment;


@interface NNTopic : NSObject

/** ID */
@property (nonatomic, copy) NSString *ID;

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;

/** 文字内容 */
@property (nonatomic, copy) NSString *text;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** 是否为新浪加v用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;

/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 最热评论 */
@property (nonatomic, strong) NNComment *top_cmt;

/** 小图片的URL  */
@property (nonatomic, copy) NSString *small_image;

/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;

/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

/** 帖子类型 */
@property (nonatomic, assign) NNTopicType type;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;

/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/**
 *  额外的辅助属性
 */

/** cell高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;

/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;

/** 视频控件的frame  */
@property (nonatomic, assign, readonly) CGRect videoF;

/** 视频的播放地址 */
@property (nonatomic, copy) NSString *videoURL;


@end
