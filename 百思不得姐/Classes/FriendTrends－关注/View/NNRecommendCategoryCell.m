//
//  NNRecommendCategoryCell.m
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNRecommendCategoryCell.h"
#import "NNRecommendCategory.h"

@interface NNRecommendCategoryCell()
/**
 *  选中时显示的指示器控件
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation NNRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = NNRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = NNRGBColor(219, 21, 26);
    
    // 当cell的selection为None时, cell被选中时, 内部的子控件就不会进入高亮状态
//    self.textLabel.highlightedTextColor = NNRGBColor(219, 21, 26);
    //    self.textLabel.textColor = NNRGBColor(78, 78, 78);
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;
    
}
/**
 *   可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : NNRGBColor(78, 78, 78);
    
}

- (void)setCategory:(NNRecommendCategory *)category {

    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}



@end
