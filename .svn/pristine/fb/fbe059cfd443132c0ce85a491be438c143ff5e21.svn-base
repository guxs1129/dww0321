//
//  DWAreaDataManager.h
//  dww
//
//  Created by Shadow. G on 2016/12/28.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Utilities.h"
#import "NSDate+Extension.h"

#define kCityIDKey @"id"
#define kCityNameKey @"categoryname"
#define kCitySpellKey @"spell"
#define kDateFormatString @"yyyy.MM.dd"
@interface DWAreaDataManager : NSObject


/**
 *
 * 暂不考虑效率 后期可替换缓存方案
 *
 */

#pragma mark --- 缓存地址

// 所有城市的缓存地址
+ (NSString *)cachePathOfAllCities;
// 热门城市的缓存地址
+ (NSString *)cachePathOfHotCities;


#pragma mark --- 公共方法
// 根据服务器更新时间判断是否需要缓存
+ (BOOL)cacheUpdateIfNeedWith:(NSString *)lastUpdateTime
                    cachePath:(NSString *)cachePath;

// 保存最新的城市列表数据到本地
+ (BOOL)saveCityListToCache:(NSArray *)cityList
             lastUpdateTime:(NSString *)lastUpdateTime
                  cachePath:(NSString *)cachePath
             withCompletion:(void(^)())block;

// 获取所有排序后城市的缓存数据
+(NSArray *)getAllCitiesDataWithSorted;

// 获取未排序的所有城市的缓存数据
+(NSArray *)getAllCitiesData;

// 获取排序后热门城市的缓存数据
+(NSArray *)getHotCitiesDataWithSorted;

// 获取未排序的热门城市的缓存数据
+(NSArray *)getHotCitiesData;

// 根据城市名获取城市ID
+(NSString *)getCityIDWithCityName:(NSString *)cityName;

// 根据城市ID获取城市名
+(NSString *)getCityNameWithCityID:(NSString *)cityID;

#pragma mark --- 汉字转拼音
+ (NSString *)chineseCharacterConvertToPhonetic:(NSString *)chineseCharacter;

#pragma mark --- 拼音转换并排序
/**
 *
 *  @param originalData 原数据
 *  @param firstSortKey 首选排序key
 *  @param secondSortKey 次选排序key
 *  @param defaultSortValue 默认序列值
 *  @return NSArray 排序后的数据
 */
+ (NSArray *)nameSortWithOriginalDataSource:(NSArray <NSDictionary *>*)originalData
                               firstSortKey:(NSString *)firstSortKey
                              secondSortKey:(NSString *)secondSortKey
                           defaultSortValue:(NSString *)defaultSortValue;
@end
