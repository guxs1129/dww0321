//
//  TYAttributedLabel+Bootstrap.m
//  东方赢家
//
//  TYAttributedLabel样式扩展
//  Created by dfzq on 16/7/15.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import "TYAttributedLabel+Bootstrap.h"

@implementation TYAttributedLabel (Bootstrap)

- (void)bootstrapStyle{
    self.characterSpacing = 0;
    self.linesSpacing = 4;
    [self setFont:[UIFont systemFontOfSize:12]];
    [self setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)defaultStyle{
    [self bootstrapStyle];
    [self setTextColor:[UIColor colorWithHexString:@"0x9A9A9A"]];
}

- (void)dangerStyle{
    [self bootstrapStyle];
    [self setTextColor:[UIColor colorWithHexString:@"0xCC0000"]];
}

+ (TYAttributedLabel *)labelWithStyle:(StrapTYAttributedLabelStyle)style andText:(NSString *)text andFrame:(CGRect)rect{
    TYAttributedLabel *label = [[TYAttributedLabel alloc] initWithFrame:rect];
    [label setText:text];
    const SEL selArray[] = {
        @selector(bootstrapStyle),
        @selector(defaultStyle),
        @selector(dangerStyle)
    };
    if ([label respondsToSelector:selArray[style]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [label performSelector:selArray[style]];
#pragma clang diagnostic pop
    }
    return label;
}

@end
