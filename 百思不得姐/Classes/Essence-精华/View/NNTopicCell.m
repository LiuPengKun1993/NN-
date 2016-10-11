//
//  NNTopicCell.m
//  百思不得姐
//
//  Created by iOS on 16/9/28.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNTopicCell.h"
#import "NNTopic.h"
#import "UIImageView+WebCache.h"
#import "NNTopicPictureView.h"
#import "NNTopicVoiceView.h"
#import "NNTopicVideoView.h"
#import "NNComment.h"
#import "NNUser.h"

@interface NNTopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;

/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;

/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片帖子中间的内容 */
@property (nonatomic, weak)  NNTopicPictureView *pictureView;

/** 声音帖子中间的内容 */
@property (nonatomic, strong) NNTopicVoiceView *voiceView;

/** 视频帖子中间的内容 */
@property (nonatomic, strong) NNTopicVideoView *videoView;

/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;



@end

@implementation NNTopicCell

+ (instancetype)cell {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (NNTopicPictureView *)pictureView {

    if (!_pictureView) {
        NNTopicPictureView *pictureView = [NNTopicPictureView pictureView];
        
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (NNTopicVoiceView *)voiceView {

    if (!_voiceView) {
        NNTopicVoiceView *voiceView = [NNTopicVoiceView voiceView];
        
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (NNTopicVideoView *)videoView {

    if (!_videoView) {
        NNTopicVideoView *videoView = [NNTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
//    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
//    self.profileImageView.layer.masksToBounds = YES;
}

- (void)setTopic:(NNTopic *)topic {

    _topic = topic;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 圆形
    [self.profileImageView setHeader:topic.profile_image];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.creatTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == NNTopicTypePicture) { // 图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == NNTopicTypeVoice) { // 声音帖子
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == NNTopicTypeVideo) { // 视频帖子
    
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else { // 段子帖子
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    // 处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
    
        self.topCmtView.hidden = YES;
    }
    
}


/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {

    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        
    } else if (count > 0) {
    
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = NNTopicCellMargin;
    frame.size.width -= 2 * NNTopicCellMargin;
//    frame.size.height -= NNTopicCellMargin;
    frame.size.height = self.topic.cellHeight - NNTopicCellMargin;
    frame.origin.y += NNTopicCellMargin;
    
    [super setFrame:frame];
}


- (IBAction)focusBtn {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:save];
    [alert addAction:cancle];
    [alert addAction:report];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
