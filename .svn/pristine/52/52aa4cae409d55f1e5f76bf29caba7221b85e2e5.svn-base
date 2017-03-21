//
//  NSString+Additions.h
//  东方赢家
//
//  NSString(扩展类)
//  Created by dfzq on 16/6/5.
//  Copyright © 2016年 Orientsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

/**
 *  判断字符串是否是空字符
 *
 *  @return 返回是否
 */
- (BOOL)isBlank;

/**
 *  去除空格
 *
 *  @return 返回一个去除空格的字符串
 */
- (NSString *)trim;

/**
 *  实现js上的substr功能，截取字符串
 *
 *  @param from 起始索引
 *  @param to   截取的长度
 *
 *  @return 返回截取后的字符串
 */
- (NSString *)substrFrom:(NSInteger)from To:(NSInteger)to;

/**
 *  判断手机号码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidPhone;

/**
 *  判断身份证是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidIdentityCard;

/**
 *  判断短信验证码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidMobileTelCode;


/**
 *  判断手机密码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidPhonePassword;

/**
 *  判断资金账号是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidFundAccount;

/**
 *  判断资金账号密码是否符合规范
 *
 *  @return 是否规范
 */
- (BOOL)isValidFundAccountPassword;

/**
 *  获取相对元素的自身字体大小
 *
 *  @param font 字体
 *  @param size 相对元素的大小
 *
 *  @return @float
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  获取相对元素的自身字体宽度
 *
 *  @param font 字体
 *  @param size 相对元素的大小
 *
 *  @return @float
 */
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  获取相对元素的自身字体高度
 *
 *  @param font 字体
 *  @param size 相对元素的大小
 *
 *  @return @float
 */
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (NSData *) stringToHexData;

@end
