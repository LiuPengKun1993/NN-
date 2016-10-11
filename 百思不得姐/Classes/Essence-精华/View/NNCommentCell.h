//
//  NNCommentCell.h
//  百思不得姐
//
//  Created by iOS on 16/10/1.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNComment;

@interface NNCommentCell : UITableViewCell

/** 评论 */
@property (nonatomic, strong) NNComment *comment;

@end
