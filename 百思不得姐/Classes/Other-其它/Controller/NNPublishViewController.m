//
//  NNPublishViewController.m
//  百思不得姐
//
//  Created by iOS on 16/10/3.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNPublishViewController.h"
#import "NNVerticalButton.h"

@interface NNPublishViewController ()

@end

static CGFloat const NNAnimationDelay = .1;
static CGFloat const NNSpringFactor = 10;

@implementation NNPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.userInteractionEnabled = NO;
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (NNScreenH - 2 * buttonH) * .5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (NNScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < images.count; i ++) {
        NNVerticalButton *button = [[NNVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - NNScreenH;
        
        
        
        CASpringAnimation *anim = [CASpringAnimation animationWithKeyPath:@"position.y"];
        
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.speed = NNSpringFactor;
        anim.beginTime = CACurrentMediaTime() + NNAnimationDelay * i;
//        [button animationDidStart:anim];
        [button.layer addAnimation:anim forKey:anim.keyPath];
        
//        // 阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
//        anim.damping = 5;
//        
//        // stiffness 刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
//        anim.stiffness = 100;
//        // mass 质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
//        anim.mass = 1;
//        
//        //  initialVelocity 初始速率，动画视图的初始速度大小
//        // 速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
//        anim.initialVelocity = 0;
//        
//        // settlingDuration 结算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算
//        anim.duration = anim.settlingDuration;
//        //        label.layer.addAnimation(spring, forKey: spring.keyPath);
    }
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    CASpringAnimation *anim = [CASpringAnimation animationWithKeyPath:@"position.y"];
    
    
    
    CGFloat centerX = NNScreenW * .5;
    CGFloat centerEndY = NNScreenH * .2;
    CGFloat centerBeginY = centerEndY - NNScreenH;
    
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * NNAnimationDelay;
    anim.speed = NNSpringFactor;
//    [sloganView animationDidStart:anim];
    [sloganView.layer addAnimation:anim forKey:anim.keyPath];
    
    
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            NNLog(@"发视频");
        } else if (button.tag == 1) {
            NNLog(@"发图片");
        }
    }];
    
}

- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        CASpringAnimation *anim = [CASpringAnimation animationWithKeyPath:@"position.y"];
        CGFloat centerY = subview.centerY + NNScreenH;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * NNAnimationDelay;
//        [subview animationDidStart:anim];
        [subview.layer addAnimation:anim forKey:anim.keyPath];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {

                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
        }
    }
}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}



@end
