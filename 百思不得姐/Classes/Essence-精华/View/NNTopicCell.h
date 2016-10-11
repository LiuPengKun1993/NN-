//
//  NNTopicCell.h
//  百思不得姐
//
//  Created by iOS on 16/9/28.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNTopic;

@interface NNTopicCell : UITableViewCell

/** 帖子数据 */
@property (nonatomic, strong) NNTopic *topic;

+ (instancetype)cell;

@end
