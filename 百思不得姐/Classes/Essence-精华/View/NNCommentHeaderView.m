//
//  NNCommentHeaderView.m
//  百思不得姐
//
//  Created by iOS on 16/10/1.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNCommentHeaderView.h"

@interface NNCommentHeaderView ()


/** 文字标签 */
@property (nonatomic, strong) UILabel *label;
@end

@implementation NNCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {

    static NSString *ID = @"header";
    
    NNCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        header = [[NNCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = NNGlobalBg;
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = NNRGBColor(67, 67, 67);
        label.width = 200;
        label.x = NNTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {

    _title = [title copy];
    self.label.text = title;
}

@end
