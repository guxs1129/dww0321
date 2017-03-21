//
//  Tool.h
//  AnXin
//
//  Created by wt on 14-2-28.
//  Copyright (c) 2014年 wt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <CoreFoundation/CoreFoundation.h>

// In bytes
#define FileHashDefaultChunkSizeForReadingData 4096


// Extern
#if defined(__cplusplus)
#define FILEMD5HASH_EXTERN extern "C"
#else
#define FILEMD5HASH_EXTERN extern
#endif

//---------------------------------------------------------
// Function declaration
//---------------------------------------------------------

FILEMD5HASH_EXTERN CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,
                                                         size_t chunkSizeForReadingData);


@interface Tool : NSObject

+(NSString *)countNumAndChangeformat:(NSString *)num;

+(NSString *)getDaysFromBeginTime:(NSString *)beginDateStr;

+(NSString *)getDaysFromBeginTimeOny:(NSString *)beginDateStr;
+(BOOL)judgeLegal:(NSString *)pass;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
/**
 *  MD5加密
 */
+ (NSString *)md5:(NSString *)inputStr;
+(NSString *)md5FileData:(NSData *)fileData;
/**
 *  MD5文件加密
 */
+(NSString *)computeMD5HashOfFileInPath:(NSString *) filePath;

/**
 * 文件大小
 */
+ (long long)fileSizeAtPath:(NSString*) filePath;

/**
 *  判断字符串是否为空
 */
+ (NSString*)strOrEmpty:(NSString*)str;

/**
 *  数据文件路径
 */
+ (NSString *)dataFilePath:(NSString *)_str;

/**
 *  判断电话号码
 */
+ (BOOL)validatePhone:(NSString *)phone;

/**
 *  判断email
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  判断是否是汉字
 */
+ (BOOL)isOrChinese:(NSString *)chinese;
+ (BOOL)validateUserName:(NSString *)userName;
+ (BOOL)validatePassword:(NSString *)passWord;

/**
 *  时间格式
 */
+ (NSDate*)getShortDateFormString:(NSString*)str;
+ (NSDate*)getDateFormString:(NSString*)str;

+ (NSDate*)getDateAndTimeFormString:(NSString*)str;
+ (NSDate*)getTimeFormString:(NSString*)str;

+ (NSString*)getStringFormDate:(NSDate*)date;
+ (NSString*)getStringFormDateAndTime:(NSDate*)date;
+ (NSString*)getStringTimeAndWeekFormDate:(NSDate*)date;

+ (NSString*)getStringMonthAndDayFormDate:(NSDate*)date;
+ (NSString*)getShortStringTimeAndWeekFormDate:(NSDate*)date;

// 数组格式化成字符串
+ (NSString*)arrayChangeToString:(NSArray*)array withSplit:(NSString*)split;
+ (NSString *)stringFromDic:(NSDictionary *)theDic;

+ (NSString *)jsonStringFromArray:(NSArray *)theArray;
+ (NSArray *)arrayFromJsonString:(NSString *)theString;
+ (NSDictionary *)dictionaryFromJsonString:(NSString *)theString;

+ (NSArray*)changeStringToArray:(NSString*)string;
+ (UIColor *) getColor:(NSString *)str;

+ (void)imageView:(UIImageView *)imageView configImageWithUrl:(NSString *)url placeholderImageName:(NSString *)placeholderImageName;

// 具体设备型号
+ (NSString*)deviceVersion;

@end
