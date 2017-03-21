//
//  NSValueTransformer+Extension.m
//  东方赢家
//
//  Created by dfzq on 16/7/19.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import "NSValueTransformer+Extension.h"

@implementation NSValueTransformer (Extension)

/**
 *  将字典项转化成枚举值类型
 *
 *  @param dictionary 字典项
 *
 *  @return 映射关系
 */
+ (NSValueTransformer *)valueMappingTransformerWithDictionary:(NSDictionary *)dictionary {
    return [self mtl_valueMappingTransformerWithDictionary:dictionary defaultValue:@(unKnown) reverseDefaultValue:@(unKnown)];
}

@end
