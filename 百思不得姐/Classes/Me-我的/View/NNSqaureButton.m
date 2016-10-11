//
//  NNSqaureButton.m
//  百思不得姐
//
//  Created by iOS on 16/10/2.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNSqaureButton.h"
#import "NNSquare.h"
#import "UIButton+WebCache.h"

@implementation NNSqaureButton

- (void)setup {

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {

    [self setup];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
     // 调整图片
    self.imageView.y = self.height * .15;
    self.imageView.width = self.width * .5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * .5;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(NNSquare *)square {

    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}


@end
