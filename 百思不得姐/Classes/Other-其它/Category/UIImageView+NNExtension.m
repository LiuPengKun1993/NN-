//
//  UIImageView+NNExtension.m
//  百思不得姐
//
//  Created by iOS on 16/10/2.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "UIImageView+NNExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (NNExtension)

- (void)setHeader:(NSString *)url {

    UIImage *placeHolder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeHolder;
    }];
}

@end
