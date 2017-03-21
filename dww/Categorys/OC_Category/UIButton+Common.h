//
//  UIButton+Common.h
//  东方赢家
//
//  按钮扩展
//  Created by dfzq on 16/7/5.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (Common)

- (void)frameToFitTitle;
/**
 *  为按钮添加查询动画
 */
- (void)addQueryAnimate;

// 开始请求时，UIActivityIndicatorView提示
- (void)startQueryAnimate;
- (void)stopQueryAnimate;

@end
