//
//  NNCommentCell.m
//  百思不得姐
//
//  Created by iOS on 16/10/1.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNCommentCell.h"
#import "UIImageView+WebCache.h"
#import "NNComment.h"
#import "NNUser.h"

@interface NNCommentCell ()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/**
 *  点赞数量
 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
/**
 *  音频按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end
@implementation NNCommentCell


- (BOOL)canBecomeFirstResponder {

    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {

    return NO;
}
- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    //    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
    //    self.profileImageView.layer.masksToBounds = YES;
}

- (void)setComment:(NNComment *)comment {

    _comment = comment;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.profileImageView setHeader:comment.user.profile_image];
    
    self.sexView.image = [comment.user.sex isEqualToString:NNUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    
    self.contentLabel.text = comment.content;
    
    self.userNameLabel.text = comment.user.username;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    
    if (comment.voiceURL.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voice_time] forState:UIControlStateNormal];
    } else {
    
        self.voiceButton.hidden = YES;
    }
}


@end
