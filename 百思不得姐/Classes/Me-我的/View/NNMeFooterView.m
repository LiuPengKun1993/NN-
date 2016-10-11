//
//  NNMeFooterView.m
//  百思不得姐
//
//  Created by iOS on 16/10/2.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNMeFooterView.h"
#import "AFNetworking.h"
#import "NNSquare.h"
#import "MJExtension.h"
#import "NNWebViewController.h"
#import "NNSqaureButton.h"

@implementation NNMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *sqaures = [NNSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            for (NNSquare *square in sqaures) {
                [dict setObject:square forKey:square.name];
            }
            
            NSMutableArray *keys = [NSMutableArray arrayWithArray:dict.allValues];
            
            [keys sortUsingComparator:^NSComparisonResult(NNSquare  *obj1, NNSquare  *obj2) {
                return obj2.ID - obj1.ID;
            }];
            
            sqaures = keys;
            
            // 创建方块
            [self createSquares:sqaures];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
        return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures {

    // 一行最多4列
    NSInteger maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = NNScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (NSInteger i = 0; i < sqaures.count; i ++) {
        
        // 创建按钮
        NNSqaureButton *button = [NNSqaureButton buttonWithType:UIButtonTypeCustom];
        
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        NSInteger col = i % maxCols;
        NSInteger row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
}
    // 8个方块, 每行显示4个, 计算行数 8/4 == 2 2
    // 9个方块, 每行显示4个, 计算行数 9/4 == 2 3
    // 7个方块, 每行显示4个, 计算行数 7/4 == 1 2
    
    // 总行数
    //    NSUInteger rows = sqaures.count / maxCols;
    //    if (sqaures.count % maxCols) { // 不能整除, + 1
    //        rows++;
    //    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    
    // 重绘
    [self setNeedsLayout];
    
    if ([self.delegate respondsToSelector:@selector(methodSignatureForSelector:)]) {
        [self.delegate MeFooterViewDidLoadDate:self];
    }
}

- (void)buttonClick:(NNSqaureButton *)button {

    if (![button.square.url hasPrefix:@"http"]) return;
    
    NNWebViewController *web = [[NNWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    // 取出当前的导航控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}


@end
