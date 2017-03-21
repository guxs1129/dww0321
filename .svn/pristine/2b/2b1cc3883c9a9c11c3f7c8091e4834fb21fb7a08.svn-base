//
//  DWAreaDataManager.m
//  dww
//
//  Created by Shadow. G on 2016/12/28.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "DWAreaDataManager.h"
#import "PinYin4Objc.h"

@implementation DWAreaDataManager

#pragma mark --- 缓存地址

+ (NSString *)docPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (BOOL)cacheFileExistWithCachePath:(NSString *)cachePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:cachePath];
}

// 所有城市的缓存地址
+ (NSString *)cachePathOfAllCities
{
    return [[self docPath] stringByAppendingPathComponent:@"AllCities.Address"];
}
// 热门城市的缓存地址
+ (NSString *)cachePathOfHotCities
{
    return [[self docPath] stringByAppendingPathComponent:@"HotCities.Address"];
}


#pragma mark --- 公共方法
// 根据服务器更新时间判断是否需要缓存
+ (BOOL)cacheUpdateIfNeedWith:(NSString *)lastUpdateTime
                    cachePath:(NSString *)cachePath
{
    BOOL need = YES;
    NSDictionary *cityListDic = nil;
    
    if ((cityListDic = [self getValidCacheFileWithCachePath:cachePath]))
    {
        NSString *_lastUpdateTime = cityListDic[[self lastUpdateTimeKey]];
        
        if (lastUpdateTime.length > 0) {
            
            NSDate *lastUpdate = [NSDate dateWithString:lastUpdateTime format:kDateFormatString];
            NSDate *_lastUpdate = [NSDate dateWithString:_lastUpdateTime format:kDateFormatString];
            if ([lastUpdate daysAfterDate:_lastUpdate] < 3) {
                need = NO;
            }
        }
    }
    return need;
}

+ (NSString *)lastUpdateTimeKey
{
    return @"lastUpdateTime";
}

+ (NSString *)countKeyWithCachePath:(NSString *)cachePath
{
    NSString *key = @"0";
    NSDictionary *cityListDic = nil;
    
    if ((cityListDic = [self getValidCacheFileWithCachePath:cachePath])) {
        for (NSString *_key in [cityListDic allKeys]) {
            if (![_key isEqualToString:[self lastUpdateTimeKey]])
            {
                key = _key;
            }
        }
    }
    
    return key;
}

// 得到一个有效的缓存
+ (NSDictionary *)getValidCacheFileWithCachePath:(NSString *)cachePath
{
    if (![self cacheFileExistWithCachePath:cachePath]) { return nil; }
    
    NSDictionary *cityListDic = [NSDictionary dictionaryWithContentsOfFile:cachePath];
    if (![cityListDic isKindOfClass:[NSDictionary class]] || ![cityListDic allKeys].count) { return nil; }
    
    return cityListDic;
}


// 保存最新的城市列表数据到本地
+ (BOOL)saveCityListToCache:(NSArray *)cityList
             lastUpdateTime:(NSString *)lastUpdateTime
                  cachePath:(NSString *)cachePath
             withCompletion:(void(^)())block;
{
    NSMutableArray *array = @[].mutableCopy;
    for (NSDictionary *dic in cityList)
    {
        NSArray *allKeys = [dic allKeys];
        NSMutableDictionary *tempDic = @{}.mutableCopy;
        for (NSString *key in allKeys)
        {
            [tempDic setObject:NSValueToString(dic[key]) forKey:key];
            if ([NSValueToString(key) isEqualToString:kCityNameKey]) {
                NSString *spellName = [self chineseCharacterConvertToPhonetic:NSValueToString(dic[key])];
                [tempDic setObject:spellName forKey:kCitySpellKey];
            }
        }
        
        [array addObject:tempDic];
    }
    
    NSMutableDictionary *cacheFile = [NSMutableDictionary dictionary];
    [cacheFile setObject:array          forKey:[NSString stringWithFormat:@"%ld", (unsigned long)cityList.count]];
    [cacheFile setObject:lastUpdateTime forKey:[self lastUpdateTimeKey]];
    
    BOOL result = [cacheFile writeToFile:cachePath atomically:YES];
    
    if (block)
    {
        block();
    }
    
    return result;

}

+ (NSArray *)getCitiesListWithCachePath:(NSString *)cachePath
{
    if (![self cacheFileExistWithCachePath:cachePath]) {
        return @[];
    }
    NSDictionary *citiesListDic = nil;
    if (!(citiesListDic = [self getValidCacheFileWithCachePath:cachePath])) {
        return @[];
    }
    
    NSString *citiesDataKey = [self countKeyWithCachePath:cachePath];
    
    return [NSMutableArray arrayWithArray:citiesListDic[citiesDataKey]];
}
// 获取所有排序后城市的缓存数据
+ (NSArray *)getAllCitiesDataWithSorted
{
    return [self nameSortWithOriginalDataSource:[self getAllCitiesData]
                                   firstSortKey:kCitySpellKey
                                  secondSortKey:kCityNameKey
                               defaultSortValue:@"z"];
}

// 获取未排序的所有城市的缓存数据
+ (NSArray<NSDictionary *> *)getAllCitiesData
{
    return [self getCitiesListWithCachePath:[self cachePathOfAllCities]];
}

// 获取排序后热门城市的缓存数据
+ (NSArray *)getHotCitiesDataWithSorted
{
    return [self nameSortWithOriginalDataSource:[self getHotCitiesData]
                                   firstSortKey:kCitySpellKey
                                  secondSortKey:kCityNameKey
                               defaultSortValue:@"z"];
}

// 获取未排序的热门城市的缓存数据
+(NSArray *)getHotCitiesData
{
    return [self getCitiesListWithCachePath:[self cachePathOfHotCities]];
}


// 根据城市名获取城市ID
+(NSString *)getCityIDWithCityName:(NSString *)cityName
{
    NSArray *citiesList = [self getAllCitiesData];
    __block NSString *cityID = nil;
    [citiesList enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[kCityNameKey] isEqualToString:cityName]) {
            cityID = obj[kCityIDKey];
            *stop = YES;
        }
    }];
    return cityID;
}

// 根据城市ID获取城市名
+(NSString *)getCityNameWithCityID:(NSString *)cityID
{
    NSArray *citiesList = [self getAllCitiesData];
    __block NSString *cityName = nil;
    [citiesList enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[kCityIDKey] isEqualToString:cityName]) {
            cityName = obj[kCityNameKey];
            *stop = YES;
        }
    }];
    return cityName;

}

#pragma mark --- 汉字转拼音
+ (NSString *)chineseCharacterConvertToPhonetic:(NSString *)chineseCharacter
{
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeUppercase];
    NSString *phonetic = [PinyinHelper toHanyuPinyinStringWithNSString:chineseCharacter withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    return [phonetic lowercaseString];
}

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
                           defaultSortValue:(NSString *)defaultSortValue
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:1];
    NSMutableDictionary *globalNameDic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSMutableDictionary *lowerDic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSMutableArray *nameArr = [NSMutableArray arrayWithArray:originalData];
    for (int i=0; i<nameArr.count; i++) {
        NSDictionary *dic = [nameArr objectAtIndex:i];
        NSString *nameStr = nil;
        if ([[dic allKeys] containsObject:firstSortKey]) {
            nameStr = [dic objectForKey:firstSortKey];
        }
        if(nameStr==nil || [nameStr isEqualToString:@""])
        {
            if ([[dic allKeys] containsObject:secondSortKey]) {
                nameStr = [dic objectForKey:secondSortKey];
            }
        }
        if(nameStr==nil || [nameStr isEqualToString:@""])
        {
            nameStr = defaultSortValue ? defaultSortValue : @"z";
        }
        NSString *sigleNameStr = [nameStr substringToIndex:1];
        //判断是数字、小写字母还是大写字母
        int intValue = [self convertToInt:sigleNameStr];
        
        switch (intValue) {
            case 1://数字
            {
                if (![lowerDic.allKeys containsObject:@"#"]) {//DO NOT CONTAIN
                    
                    NSMutableArray *pinyinArr = [[NSMutableArray alloc] init];
                    [pinyinArr addObject:dic];
                    [lowerDic setObject:pinyinArr forKey:@"#"];
                }else{//CONTAIN
                    
                    NSMutableArray*pinyinArr = (NSMutableArray *)[lowerDic objectForKey:@"#"];
                    [pinyinArr addObject:dic];
                    
                }
            }
                break;
            case 2://小写字母
            {
                unichar upChar = [self upChar:[sigleNameStr characterAtIndex:0]];
                NSString *tempValue = [NSString stringWithFormat:@"%c",upChar];
                if (![globalNameDic.allKeys containsObject:tempValue]) {//DO NOT CONTAIN
                    
                    NSMutableArray *pinyinArr = [[NSMutableArray alloc] init];
                    [pinyinArr addObject:dic];
                    [globalNameDic setObject:pinyinArr forKey:tempValue];
                }else{//CONTAIN
                    
                    NSMutableArray*pinyinArr = (NSMutableArray *)[globalNameDic objectForKey:tempValue];
                    [pinyinArr addObject:dic];
                    
                }
            }
                break;
            case 3://大写字母
            {
                if (![globalNameDic.allKeys containsObject:sigleNameStr]) {//DO NOT CONTAIN
                    
                    NSMutableArray *pinyinArr = [[NSMutableArray alloc] init];
                    [pinyinArr addObject:dic];
                    [globalNameDic setObject:pinyinArr forKey:sigleNameStr];
                    
                }else{//CONTAIN
                    
                    NSMutableArray*pinyinArr = (NSMutableArray *)[globalNameDic objectForKey:sigleNameStr];
                    [pinyinArr addObject:dic];
                }
            }
                break;
            case 4://其他
            {
                NSString *pinyinStr = [[self chineseCharacterConvertToPhonetic:sigleNameStr] uppercaseString];
                NSString *sigleStr  = [pinyinStr substringToIndex:1];
                NSString *regex     = @"([A-Z])";
                NSPredicate *pred   = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                BOOL isMatch        = [pred evaluateWithObject:sigleStr];
                
                if (isMatch) {
                    if (![globalNameDic.allKeys containsObject:sigleStr]) {//DO NOT CONTAIN
                        
                        NSMutableArray *pinyinArr = [[NSMutableArray alloc] init];
                        [pinyinArr addObject:dic];
                        [globalNameDic setObject:pinyinArr forKey:sigleStr];
                        
                    }else{//CONTAIN
                        
                        NSMutableArray*pinyinArr = (NSMutableArray *)[globalNameDic objectForKey:sigleStr];
                        [pinyinArr addObject:dic];
                    }
                }
                else {
                    if (![lowerDic.allKeys containsObject:@"#"]) {//DO NOT CONTAIN
                        
                        NSMutableArray *pinyinArr = [[NSMutableArray alloc] init];
                        [pinyinArr addObject:dic];
                        [lowerDic setObject:pinyinArr forKey:@"#"];
                    }else{//CONTAIN
                        
                        NSMutableArray*pinyinArr = (NSMutableArray *)[lowerDic objectForKey:@"#"];
                        [pinyinArr addObject:dic];
                        
                    }
                }
            }
                break;
                
            default:
                break;
        }
    }
    NSArray *sortArr = [globalNameDic allKeys];
    sortArr = [sortArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    
    for (NSString *sortStr in sortArr) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[globalNameDic objectForKey:sortStr] forKey:sortStr];
        
        [tempArr addObject:dic];
    }
    //包含数字
    if ([lowerDic allKeys].count > 0) {
        [tempArr insertObject:lowerDic atIndex:0];
    }
    return tempArr;
}

+  (int)convertToInt:(NSString*)strtemp {
    //0为非字符串 1为数字 2为小写字母 3为大写字母 4为汉字
    int numlength = 0;
    if ([strtemp isKindOfClass:[NSNull class]]) {
        return 0;
    }
    NSInteger strLength = strtemp.length;
    
    NSRange range;
    NSString *strP=nil;
    char* p=0;
    int ch=0;
    for (int i=0; i<strLength; i++) {
        range.length = 1;
        range.location = i;
        strP = [strtemp substringWithRange:range];
        p = (char*)[strP cStringUsingEncoding:NSUTF8StringEncoding];
        ch = *p;
        if((ch>=48) && (ch<=57))
            numlength += 1;
        else if((ch>='a') && (ch<='z'))
            numlength += 2;
        else if ((ch>='A') && (ch<='Z'))
            numlength += 3;
        else
            numlength += 4;
    }
    
    return numlength;
    
}

//小写字母转大写
+ (char)upChar:(char)ch
{
    return (char)(ch - ('a' - 'A'));
}


@end
