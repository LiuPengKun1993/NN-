//
//  NNMeFooterView.h
//  百思不得姐
//
//  Created by iOS on 16/10/2.
//  Copyright © 2016年 YMWM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNMeFooterView;
@protocol NNMeFooterViewDelegate <NSObject>

@optional

- (void)MeFooterViewDidLoadDate:(NNMeFooterView *)MeFooterView;

@end

@interface NNMeFooterView : UIView

/** 代理 */
@property (nonatomic, weak) id<NNMeFooterViewDelegate> delegate;

@end
