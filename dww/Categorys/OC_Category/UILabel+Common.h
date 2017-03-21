//
//  UILabel+Common.h
//  东方赢家
//
//  UILabel扩展
//  Created by dfzq on 16/7/14.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width;
- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight;
- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth;
+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

- (void) setLineSpacing:(CGFloat)spacing labelText:(NSString *)text;

@end
