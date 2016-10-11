//
//  NNRecommendUserCell.m
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNRecommendUserCell.h"
#import "NNRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface NNRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation NNRecommendUserCell

- (void)setUser:(NNRecommendUser *)user {

    _user = user;
    self.screenNameLabel.text = user.screen_name;
//    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    NSString *subNumber = nil;
    if (user.fans_count < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人关注 ", user.fans_count];
    } else {
        
        subNumber = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = subNumber;
    
    // 设置头像
//    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    // 圆角
    [self.headerImageView setHeader:user.header];
}

@end
