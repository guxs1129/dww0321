//
//  UIButton+Bootstrap.m
//  东方赢家
//
//  按钮样式扩展
//  Created by dfzq on 16/7/4.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import "UIButton+Bootstrap.h"

@implementation UIButton (Bootstrap)

// 基础方法构建
-(void)bootstrapStyle{
    self.layer.borderWidth = 1;
    //self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

-(void)defaultStyle{
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:[UIColor colorWithHexString:@"0x3760EF"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithHexString:@"0x3724EF"] forState:UIControlStateHighlighted];
}

-(void)primaryStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithHexString:@"0x3bbd79"];
    self.layer.borderColor = [[UIColor colorWithHexString:@"0x3bbd79"] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x28a464"]] forState:UIControlStateHighlighted];
}

-(void)successStyle{
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x3bbc79"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x3bbc79" andAlpha:0.5]] forState:UIControlStateDisabled];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x32a067"]] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

-(void)infoStyle{
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x4E90BF"]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x4E90BF" andAlpha:0.5]] forState:UIControlStateDisabled];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x4E90BF"]] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

-(void)warningStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithHexString:@"0xff5847"];
    self.layer.borderColor = [[UIColor colorWithHexString:@"0xff5847"] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xef4837"]] forState:UIControlStateHighlighted];
}

-(void)dangerStyle{
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:217/255.0 green:83/255.0 blue:79/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:63/255.0 blue:58/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:210/255.0 green:48/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)orangeStyle{
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor colorWithRed:1.000 green:0.427 blue:0.000 alpha:1.000] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:1.000 green:0.427 blue:0.000 alpha:1.000]] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xFF521A"]] forState:UIControlStateHighlighted];
}

//  颜色转换为背景图片
- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    const  SEL selArray[] = {@selector(bootstrapStyle), @selector(defaultStyle), @selector(primaryStyle), @selector(successStyle), @selector(infoStyle), @selector(warningStyle), @selector(dangerStyle), @selector(orangeStyle)};
    if ([btn respondsToSelector:selArray[style]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [btn performSelector:selArray[style]];
#pragma clang diagnostic pop
    }
    return btn;
}

+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector{
    UIButton *btn = [self buttonWithStyle:style andTitle:title andFrame:rect];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title{
    return [self buttonWithStyle:style andTitle:title andFrame:CGRectMake(0, 0, 44, 24)];
}

- (UIButton *)addAwesomeIcon:(NSString *)code selectedAwesomeIcon:(NSString *)selectedCode title:(NSString *)title{
    // 未选中的ICON
    FAKFontAwesome *awesomeIcon = [FAKFontAwesome iconWithCode:code size:self.titleLabel.font.pointSize];
    [awesomeIcon addAttribute:NSForegroundColorAttributeName value:self.titleLabel.textColor];
    NSMutableAttributedString *awesomeMas = [[awesomeIcon attributedString] mutableCopy];
    [awesomeMas appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: self.titleLabel.textColor}]];
    
    // 选中的ICON
    FAKFontAwesome *awesomeSelectedIcon = [FAKFontAwesome iconWithCode:selectedCode size:self.titleLabel.font.pointSize];
    [awesomeSelectedIcon addAttribute:NSForegroundColorAttributeName value:self.titleLabel.textColor];
    NSMutableAttributedString *awesomeSelectedMas = [[awesomeSelectedIcon attributedString] mutableCopy];
    [awesomeSelectedMas appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: self.titleLabel.textColor}]];
    
    [self setAttributedTitle:awesomeMas forState:UIControlStateNormal];
    [self setAttributedTitle:awesomeSelectedMas forState:UIControlStateSelected];
    return self;
}

- (UIButton *)addAwesomeIcon:(NSString *)code selectedAwesomeIcon:(NSString *)selectedCode awesomeIconAttrs:(NSDictionary *)awesomeIconAttrs title:(NSString *)title titleAttrs:(NSDictionary *)titleAttrs {
    UIButton *button = ({
        UIButton *_button = [UIButton new];
        _button.titleLabel.textAlignment = NSTextAlignmentLeft;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        {
            FAKFontAwesome *awesomeIcon = [FAKFontAwesome iconWithCode:code size:13];
            [awesomeIcon addAttribute:NSForegroundColorAttributeName value:self.titleLabel.textColor];
            if(awesomeIconAttrs != nil){
                [awesomeIcon addAttributes:awesomeIconAttrs];
            }
            
            NSMutableAttributedString *awesomeMas = [[awesomeIcon attributedString] mutableCopy];
            [awesomeMas appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            [awesomeMas appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:12] }]];
            if (titleAttrs != nil) {
                [awesomeMas setAttributes:titleAttrs range:NSMakeRange(0, title.length)];
            }
            
            [_button setAttributedTitle:awesomeMas forState:UIControlStateNormal];
        }
        _button;
    });
    
    return button;
}

/**
 *  自动登录按钮
 *
 *  @return 自动登录按钮
 */
- (UIButton *)autoLogin
{
    return [self addAwesomeIcon:@"\uf096" selectedAwesomeIcon:@"\uf046" title:@"自动登录"];
}

/**
 *  信息按钮
 *
 *  @return 信息按钮
 */
- (UIButton *)info
{
    return [self addAwesomeIcon:@"\uf05a" selectedAwesomeIcon:@"\uf129" title:@""];
}

/**
 *  协议阅读按钮
 *
 *  @return 协议阅读按钮
 */
- (UIButton *)protocolRead
{
    return [self addAwesomeIcon:@"\uf096" selectedAwesomeIcon:@"\uf046" title:@" 我已经查看相关协议并同意签署"];
}

/**
 *  单选按钮
 *
 *  @return 单选按钮
 */
- (UIButton *)radioButton
{
    return [self addAwesomeIcon:@"\uf10c" selectedAwesomeIcon:@"\uf192" title:@""];
}

/**
 *  多选按钮
 *
 *  @return 多选按钮
 */
- (UIButton *)checkButton
{
    return [self addAwesomeIcon:@"\uf096" selectedAwesomeIcon:@"\uf046" title:@""];
}

@end
