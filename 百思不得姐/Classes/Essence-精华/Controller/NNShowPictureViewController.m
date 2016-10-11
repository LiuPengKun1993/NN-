//
//  NNShowPictureViewController.m
//  百思不得姐
//
//  Created by iOS on 16/9/29.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNShowPictureViewController.h"
#import "NNTopic.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "NNProgressView.h"

@interface NNShowPictureViewController()

@property (weak, nonatomic) IBOutlet NNProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) UIImageView *imageView;


@end

@implementation NNShowPictureViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW = NNScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > NNScreenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
    
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = NNScreenH * .5;
    }
    
     // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
