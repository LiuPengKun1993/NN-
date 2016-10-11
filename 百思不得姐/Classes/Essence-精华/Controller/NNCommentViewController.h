//
//  NNCommentViewController.h
//  百思不得姐
//
//  Created by iOS on 16/10/1.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNTopic;

@interface NNCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) NNTopic *topic;

@end
