//
//  NSDictionary+Additions.m
//  东方赢家
//
//  NSDictionary(扩展类)
//  Created by dfzq on 16/6/3.
//  Copyright © 2016年 Orientsec. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

/**
 *  字典转化为json
 *
 *  @return json字符串
 */
- (NSString *)jsonSerialization {
    return [self jsonSerialization:NO];
}

- (NSString *)jsonSerialization:(BOOL *)pretty {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:YES    // non-pretty printing
                                                     error:&error];
    if (error) {
        
        NSLog(@"JSON Parsing Error: %@", error);
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**
 *  过滤掉空的字典项
 *
 *  @return 过滤字典
 */
- (NSDictionary *)filterEmpty
{
    if([self count] > 0){
        NSMutableDictionary *filterDic = [NSMutableDictionary dictionary];
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if(![obj isEqual:[NSNull null]]){
                [filterDic setObject:obj forKey:key];
            }
        }];
        return filterDic;
    } else {
        return self;
    }
}


@end
