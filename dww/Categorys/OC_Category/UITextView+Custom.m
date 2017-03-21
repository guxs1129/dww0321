//
//  UITextView+Custom.m
//  dww
//
//  Created by Shadow.G on 16/12/25.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "UITextView+Custom.h"
#import <objc/runtime.h>

@implementation UITextView (Custom)

/* 最大输入值 */
- (void)setMaxLength:(NSUInteger)maxLength
{
    objc_setAssociatedObject(self, @selector(maxLength), @(maxLength), OBJC_ASSOCIATION_ASSIGN);
}
- (NSUInteger)maxLength
{
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

/* 提示用户输入的标语 */
- (void)setPlaceHolder:(NSString *)placeHolder
{
    if ([placeHolder isEqualToString:self.placeHolder]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextDidChangeNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    objc_setAssociatedObject(self, @selector(placeHolder), placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}
- (NSString *)placeHolder
{
    return objc_getAssociatedObject(self, _cmd);
}

/* 标语文本的颜色 */
- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    objc_setAssociatedObject(self, @selector(placeHolderTextColor), placeHolderTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}
- (UIColor *)placeHolderTextColor
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - Notifications

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}

- (void)dealloc {
    self.placeHolder = nil;
    self.placeHolderTextColor = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void) setLineSpacing:(CGFloat)spacing text:(NSString *)text
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text attributes:self.typingAttributes];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:spacing];//调整行间距
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedStr;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if([self.text length] == 0 && self.placeHolder) {
        CGRect placeHolderRect = CGRectMake(5.0f,
                                            7.0f,
                                            rect.size.width,
                                            rect.size.height);
        
        [self.placeHolderTextColor set];
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_0) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragraphStyle.alignment = self.textAlignment;
            
            [self.placeHolder drawInRect:placeHolderRect
                          withAttributes:@{ NSFontAttributeName : self.font ? self.font : [UIFont systemFontOfSize:12],
                                            NSForegroundColorAttributeName : self.placeHolderTextColor ? self.placeHolderTextColor : [UIColor lightGrayColor],
                                            NSParagraphStyleAttributeName : paragraphStyle }];
        }
        else {
            [self.placeHolder drawInRect:placeHolderRect
                                withFont:self.font
                           lineBreakMode:NSLineBreakByTruncatingTail
                               alignment:self.textAlignment];
        }
    }
}

@end
