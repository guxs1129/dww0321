//
//  TYAttributedLabel+Bootstrap.h
//  东方赢家
//
//  TYAttributedLabel样式扩展
//  Created by dfzq on 16/7/15.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import <TYAttributedLabel/TYAttributedLabel.h>

// TYAttributedLabel样式
typedef NS_OPTIONS (NSInteger, StrapTYAttributedLabelStyle){
    StrapTYAttributedLabelBootstrapStyle = 0,
    StrapTYAttributedLabelDefaultStyle,
    StrapTYAttributedLabelDangerStyle
};

@interface TYAttributedLabel (Bootstrap)

- (void)bootstrapStyle;
- (void)defaultStyle;
- (void)dangerStyle;

+ (TYAttributedLabel *)labelWithStyle:(StrapTYAttributedLabelStyle)style andText:(NSString *)text andFrame:(CGRect)rect;

@end
