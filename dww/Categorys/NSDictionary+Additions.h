//
//  NSDictionary+Additions.h
//  东方赢家
//
//  NSDictionary(扩展类)
//  Created by dfzq on 16/6/3.
//  Copyright © 2016年 Orientsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

/**
 *  字典转化为json
 *
 *  @return json字符串
 */
- (NSString *)jsonSerialization;

/**
 *  字典转化为json
 *
 *  @param pretty 是否格式化输出(0-否 1-是)
 *
 *  @return json字符串（已格式化）
 */
- (NSString *)jsonSerialization:(BOOL *)pretty;

/**
 *  过滤掉空的字典项
 *
 *  @return 过滤字典
 */
- (NSDictionary *)filterEmpty;

/**
 *  将字典转化为QueryString
 *
 *  @return 返回QueryString
 */
-(NSString *) urlEncodedKeyValueString;

@end
