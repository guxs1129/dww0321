//
//  UIButton+Bootstrap.h
//  东方赢家
//
//  按钮样式扩展
//  Created by dfzq on 16/7/4.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    StrapBootstrapStyle = 0,
    StrapDefaultStyle,
    StrapPrimaryStyle,
    StrapSuccessStyle,
    StrapInfoStyle,
    StrapWarningStyle,
    StrapDangerStyle,
    StrapOrangeStyle
} StrapButtonStyle;

@interface UIButton (Bootstrap)

-(void)bootstrapStyle;
-(void)defaultStyle;
-(void)primaryStyle;
-(void)successStyle;
-(void)infoStyle;
-(void)warningStyle;
-(void)dangerStyle;
-(void)orangeStyle;
- (UIImage *) buttonImageFromColor:(UIColor *)color ;
+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title;
+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect;
+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector;

// fontAwesome icon
- (UIButton *)addAwesomeIcon:(NSString *)code selectedAwesomeIcon:(NSString *)selectedCode title:(NSString *)title;

- (UIButton *)addAwesomeIcon:(NSString *)code selectedAwesomeIcon:(NSString *)selectedCode awesomeIconAttrs:(NSDictionary *)awesomeIconAttrs title:(NSString *)title titleAttrs:(NSDictionary *)titleAttrs;

/**
 *  自动登录按钮
 *
 *  @return 自动登录按钮
 */
- (UIButton *)autoLogin;

/**
 *  信息按钮
 *
 *  @return 信息按钮
 */
- (UIButton *)info;

/**
 *  协议阅读按钮
 *
 *  @return 协议阅读按钮
 */
- (UIButton *)protocolRead;

/**
 *  单选按钮
 *
 *  @return 单选按钮
 */
- (UIButton *)radioButton;

/**
 *  多选按钮
 *
 *  @return 多选按钮
 */
- (UIButton *)checkButton;

@end
