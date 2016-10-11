//
//  NNFriendTrendsViewController.m
//  百思不得姐
//
//  Created by iOS on 16/9/25.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNFriendTrendsViewController.h"
#import "NNRecommendViewController.h"
#import "NNLoginRegisterViewController.h"

@interface NNFriendTrendsViewController ()

@end

@implementation NNFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
  
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage: @"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = NNGlobalBg;
}

- (void)friendsClick {
    NNRecommendViewController *vc = [[NNRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginRegister {
    NNLoginRegisterViewController *VC = [[NNLoginRegisterViewController alloc] init];
    [self presentViewController:VC animated:YES completion:nil];
    
}

@end
