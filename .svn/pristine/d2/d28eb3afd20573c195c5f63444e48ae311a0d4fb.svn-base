//
//  UITextField+Additions.m
//  东方赢家
//
//  对文本框的扩展
//  Created by dfzq on 16/7/1.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import "UITextField+Additions.h"

static char maxLengthAssociateKey;

@implementation UITextField (Additions)

/**
 *  为文本框设置最大输入值
 *
 *  @param maxLength 最大值
 *
 *  @return 返回一个当前文本框实例
 */
- (UITextField *)setMaxLength:(NSInteger)maxLength {
    BOOL isSetMaxLengthFlag = objc_getAssociatedObject(self, &maxLengthAssociateKey);
    if (!isSetMaxLengthFlag) {
        RAC(self, text) = [self.rac_textSignal setMaxLength:maxLength];
        //    // 同时关闭当前响应者
        //    if (![self isExclusiveTouch]) {
        //        [self resignFirstResponder];
        //    }
    }
    objc_setAssociatedObject(self, &maxLengthAssociateKey, @(YES), OBJC_ASSOCIATION_ASSIGN);
    return self;
}
@end
