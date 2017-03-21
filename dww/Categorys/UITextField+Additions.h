//
//  UITextField+Additions.h
//  东方赢家
//
//  对文本框的扩展
//  Created by dfzq on 16/7/1.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Additions)

/**
 *  为文本框设置最大输入值
 *
 *  @param maxLength 最大值
 *
 *  @return 返回一个当前文本框实例
 */
- (UITextField *)setMaxLength:(NSInteger)maxLength;

@end
