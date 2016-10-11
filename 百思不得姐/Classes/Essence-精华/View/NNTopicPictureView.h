//
//  NNTopicPictureView.h
//  百思不得姐
//
//  Created by iOS on 16/9/29.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNTopic;

@interface NNTopicPictureView : UIView

+ (instancetype)pictureView;

/** 帖子数据 */
@property (nonatomic, strong) NNTopic *topic;

@end
