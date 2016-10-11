//
//  NNRecommendCategory.m
//  百思不得姐
//
//  Created by iOS on 16/9/26.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import "NNRecommendCategory.h"
#import "MJExtension.h"

@implementation NNRecommendCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users {

    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
