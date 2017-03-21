//
//  NSString+Additions.m
//  东方赢家
//
//  NSString(扩展类)
//  Created by dfzq on 16/6/5.
//  Copyright © 2016年 Orientsec. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

/**
 *  判断字符串是否是空字符
 *
 *  @return 返回是否
 */
- (BOOL)isBlank {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
   
    // 为@""情况
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

/**
 *  去除空格
 *
 *  @return 返回一个去除空格的字符串
 */
- (NSString *)trim {
    if([self isBlank])
        return self;
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 *  实现js上的substr功能，截取字符串
 *
 *  @param from 起始索引
 *  @param to   截取的长度
 *
 *  @return 返回截取后的字符串
 */
- (NSString *)substrFrom:(NSInteger)from To:(NSInteger)to {
    NSRange range = NSMakeRange(from, to);
    @try {
        return [self substringWithRange:range];
    } @catch (NSException *exception) {
        return nil;
    }
}



/**
 *  判断手机号码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidPhone {
    NSString *emailRegex = @"(^1\\d{10}$)";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/**
 *  判断身份证是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidIdentityCard {
    return NO;
}

/**
 *  判断短信验证码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidMobileTelCode{
    
    return self.length==6;
}

/**
 *  判断短信验证码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidPhoneCode {
    return self.length == mobileTelCodeLength;
}

/**
 *  判断手机密码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidPhonePassword {
    return self.length >= 6 && self.length <= 15;
}

/**
 *  判断资金账号是否符合规范(8-12位且纯数字)
 *
 *  @return 是否规范
 */
- (BOOL)isValidFundAccount {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    int val;
    return self.length >= 8 && self.length <= 12 && [scanner scanInt:&val] && [scanner isAtEnd];
}

/**
 *  判断资金账号密码是否符合规范(6-8位不控制字符格式)
 *
 *  @return 是否规范
 */
- (BOOL)isValidFundAccountPassword {
    return self.length >= 6 && self.length <= 8;
}

/**
 *  获取相对元素的自身字体大小
 *
 *  @param font 字体
 *  @param size 相对元素的大小
 *
 *  @return @float
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

/**
 *  获取相对元素的自身字体宽度
 *
 *  @param font 字体
 *  @param size 相对元素的大小
 *
 *  @return @float
 */
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

/**
 *  获取相对元素的自身字体高度
 *
 *  @param font 字体
 *  @param size 相对元素的大小
 *
 *  @return @float
 */
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self getSizeWithFont:font constrainedToSize:size].height;
}

- (NSData *) stringToHexData
{
    int len = [self length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}

@end
