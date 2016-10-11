//
//  NNRecommendTagCell.m
//  百思不得姐
//
//  Created by iOS on 16/9/27.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNRecommendTagCell.h"
#import "NNRecommendTag.h"
#import "UIImageView+WebCache.h"


@interface NNRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end

@implementation NNRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommendTag:(NNRecommendTag *)recommendTag {

    _recommendTag = recommendTag;
    
     // 设置头像
//    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.imageListImageView setHeader:recommendTag.image_list];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅 ", recommendTag.sub_number];
    } else {
    
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
    
}

- (void)setFrame:(CGRect)frame {

    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
