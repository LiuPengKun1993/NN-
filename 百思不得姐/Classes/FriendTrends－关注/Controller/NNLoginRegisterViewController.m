//
//  NNLoginRegisterViewController.m
//  百思不得姐
//
//  Created by iOS on 16/9/27.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNLoginRegisterViewController.h"
#import "NNVerticalButton.h"
#import <objc/runtime.h>

@interface NNLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftlineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightlineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NNVerticalButton *sinaBtn;
@property (weak, nonatomic) IBOutlet NNVerticalButton *QQBtn;
@property (weak, nonatomic) IBOutlet NNVerticalButton *tencentBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *gorgetBtn;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UILabel *quickBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@end

@implementation NNLoginRegisterViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.topConstraint.constant = -250;
    self.leftlineWidth.constant = 0;
    self.rightlineWidth.constant = 0;
    
    self.gorgetBtn.layer.mask = [[CALayer alloc] init];
    self.quickBtn.layer.mask = [[CALayer alloc] init];
    self.registerBtn.layer.mask = [[CALayer alloc] init];
}


- (IBAction)showLoginOrRegister:(UIButton *)button{
    
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
    } else { // 显示登录界面
    
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:.25 animations:^{
        [self.viewIfLoaded layoutIfNeeded];
    }];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    self.topConstraint.constant = 40;
    self.leftlineWidth.constant = 103;
    self.rightlineWidth.constant = 103;

    
    [UIView animateWithDuration:1.0 delay:.5 usingSpringWithDamping:.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        //忘记密码动画
        [self setUpAnimationWithStartRect:CGRectMake(0, 0, 0, CGRectGetHeight(self.gorgetBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.gorgetBtn.frame), CGRectGetHeight(self.gorgetBtn.frame)) object:self.gorgetBtn duration:.5];
        //注册按钮动画
        [self setUpAnimationWithStartRect:CGRectMake(- (CGRectGetWidth(self.registerBtn.frame)), 0, 0, CGRectGetHeight(self.registerBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.registerBtn.frame), CGRectGetHeight(self.registerBtn.frame)) object:self.registerBtn duration:.5];
        
        
    }];
    
    //快速登录动画
    [self setUpAnimationWithStartRect:CGRectMake(self.quickBtn.width/ 2, 0, 0, CGRectGetHeight(self.quickBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.quickBtn.frame), CGRectGetHeight(self.quickBtn.frame)) object:self.quickBtn duration:.5];
    
    [UIView animateWithDuration:.1 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.QQBtn.transform = CGAffineTransformMakeScale(.01, .01);
        self.sinaBtn.transform = CGAffineTransformMakeScale(.01, .01);
        self.tencentBtn.transform = CGAffineTransformMakeScale(.01, .01);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:1.5 usingSpringWithDamping:.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
            self.QQBtn.transform = CGAffineTransformIdentity;
            self.sinaBtn.transform = CGAffineTransformIdentity;
            self.tencentBtn.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}

//设置动画
- (void)setUpAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect object:(UIView *)view duration:(NSTimeInterval)duration {
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:startRect];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:endRect];
    
    CAShapeLayer *quickMask = [[CAShapeLayer alloc] init];
    quickMask.path = endPath.CGPath;
    quickMask.fillColor = [UIColor whiteColor].CGColor;
    view.layer.mask = quickMask;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = duration;
    animation.beginTime = CACurrentMediaTime();
    animation.fromValue = (id)beginPath.CGPath;
    animation.toValue = (id)(endPath.CGPath);
    [quickMask addAnimation:animation forKey:@"path"];
    
}

//关闭控制器
- (IBAction)closeBtn:(UIButton *)sender {
    
//    [UIApplication sharedApplication].statusBarStyle = UISearchBarStyleDefault;
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];

}
@end
