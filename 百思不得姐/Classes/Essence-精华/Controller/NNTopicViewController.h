//
//  NNTopicViewController.h
//  百思不得姐
//
//  Created by iOS on 16/9/28.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NNTopicViewController : UITableViewController

/** 帖子类型（交给子类去实现） */
@property (nonatomic, assign) NNTopicType type;

@end
