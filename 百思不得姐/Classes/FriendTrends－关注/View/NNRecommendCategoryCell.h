//
//  NNRecommendCategoryCell.h
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNRecommendCategory;

@interface NNRecommendCategoryCell : UITableViewCell
/** 类别模型 */
@property (nonatomic, strong) NNRecommendCategory *category;
@end
