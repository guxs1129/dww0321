//
//  Tool.m
//  AnXin
//
//  Created by wt on 14-2-28.
//  Copyright (c) 2014年 wt. All rights reserved.
//

#import "Tool.h"
#import "CommonCrypto/CommonDigest.h"
#import "UIImageView+WebCache.h"
#import "Config.h"
#import <sys/utsname.h>

// Standard library
#include <stdint.h>
#include <stdio.h>

// Core Foundation
#include <CoreFoundation/CoreFoundation.h>

// Cryptography
#include <CommonCrypto/CommonDigest.h>

//---------------------------------------------------------
// Function definition
//---------------------------------------------------------

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,
                                      size_t chunkSizeForReadingData) {
    
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,
                      (const void *)buffer,
                      (CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,
                                       (const char *)hash,
                                       kCFStringEncodingUTF8);
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}


@implementation Tool




//直接上代码
+(NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}
/*
 *
 *      
 
 一天内的，显示HH:mm;
 
 昨天，显示昨天；
 
 一周之内的，显示星期*；
 
 一周之前的，显示年月日;
 
 *
 */
+(NSString *)getDaysFromBeginTime:(NSString *)beginDateStr{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:beginDateStr];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * beginStr = [dateFormatter stringFromDate:date];
    
    NSTimeInterval late=[[dateFormatter dateFromString:beginStr] timeIntervalSince1970];
    
    
    
    
    NSDate* dat = [NSDate date];
    NSString * currentStr  = [dateFormatter stringFromDate:dat];
    NSDate * currentDate = [dateFormatter dateFromString:currentStr];
    NSTimeInterval now=[currentDate timeIntervalSince1970];
    NSString *timeStr=nil;
    
    NSTimeInterval seconds=now-late;
    
    NSInteger day = seconds/3600/24;
    
    
    
    if (day<1) {
        if (beginDateStr.length > 14) {
            timeStr = [beginDateStr substringFromIndex:11];
            timeStr = [timeStr substringToIndex:5];

        }
    }else if (day>=1 && day<2){
        if (beginDateStr.length>14) {
            timeStr = [beginDateStr substringFromIndex:11];
            timeStr = [timeStr substringToIndex:5];
            timeStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
    }else if (day>2 && day <= 7){
        timeStr = [self getStringTimeAndWeekFormDate:date];
    }else{
        
        timeStr = [beginDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        if (timeStr.length >=16) {
            timeStr = [timeStr substringToIndex:16];
        }
    }

    
    return timeStr;
}

+(NSString *)getDaysFromBeginTimeOny:(NSString *)beginDateStr{

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:beginDateStr];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * beginStr = [dateFormatter stringFromDate:date];
    
    NSTimeInterval late=[[dateFormatter dateFromString:beginStr] timeIntervalSince1970];
    
    
    
    
    NSDate* dat = [NSDate date];
    NSString * currentStr  = [dateFormatter stringFromDate:dat];
    NSDate * currentDate = [dateFormatter dateFromString:currentStr];
    NSTimeInterval now=[currentDate timeIntervalSince1970];
    NSString *timeStr=nil;
    
    NSTimeInterval seconds=now-late;
    
    NSInteger day = seconds/3600/24;
    
    
    
    if (day<1) {
        if (beginDateStr.length > 14) {
            timeStr = [beginDateStr substringFromIndex:11];
            timeStr = [timeStr substringToIndex:5];
            
        }
    }else if (day>=1 && day<2){
        if (beginDateStr.length>14) {
            timeStr = [beginDateStr substringFromIndex:11];
            timeStr = [timeStr substringToIndex:5];
            timeStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
    }else if (day>2 && day <= 7){
        timeStr = [[self getStringTimeAndWeekFormDate:date] substringToIndex:4];
    }else{
        
        timeStr = [beginDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        if (timeStr.length >=16) {
            timeStr = [timeStr substringToIndex:10];
        }
    }
    
    
    return timeStr;

}
+(BOOL)judgeLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6&&[pass length]<=12){
        NSString * regex = @"^[0-9A-Za-z]{6,12}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextAddRoundRect(context, rect, cornerRadius);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;

}

void CGContextAddRoundRect(CGContextRef context,CGRect rect,CGFloat radius){
    float x1=rect.origin.x;
    float y1=rect.origin.y;
    float x2=x1+rect.size.width;
    float y2=y1;
    float x3=x2;
    float y3=y1+rect.size.height;
    float x4=x1;
    float y4=y3;
    CGContextMoveToPoint(context, x1, y1+radius);
    CGContextAddArcToPoint(context, x1, y1, x1+radius, y1, radius);
    
    CGContextAddArcToPoint(context, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(context, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(context, x4, y4, x4, y4-radius, radius);
    
    CGContextClosePath(context);
    CGContextFillPath(context);
}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



+ (NSString*)md5:(NSString *)inputStr {
    const char *cStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
//MD5文件加密
+(NSString *)md5FileData:(NSData *)fileData{
    
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [[NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    digest[0], digest[1],
                    digest[2], digest[3],
                    digest[4], digest[5],
                    digest[6], digest[7],
                    digest[8], digest[9],
                    digest[10], digest[11],
                    digest[12], digest[13],
                    digest[14], digest[15]] lowercaseString];
    return s;
    
}

+ (NSString *)computeMD5HashOfFileInPath:(NSString *) filePath
{
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)filePath, FileHashDefaultChunkSizeForReadingData);
}

+ (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//判空操作的代码
+ (NSString*)strOrEmpty:(NSString*)str{
	return (str==nil?@"":str);
}

// 数据文件路径
+ (NSString *)dataFilePath:(NSString *)str {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:str];
}

//判断电话号码
+ (BOOL)validatePhone:(NSString *)phone {
    NSString *emailRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:phone];
}

//判断email
+ (BOOL)validateEmail:(NSString *)email {
//    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//判断是否是汉字
+ (BOOL)isOrChinese:(NSString *)chinese{
    
    NSString * textStr=@"^[\u4e00-\u9fa5]+$";//[\u4e00-\u9fa5]+
    NSPredicate * chineseTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", textStr];
    return [chineseTest evaluateWithObject:chinese];
}

// 判断用户名
+ (BOOL)validateUserName:(NSString *)userName{
    
    //    NSString * textStr=@"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+$"; // 以字母汉字开头
    NSString * textStr=@"[a-zA-Z0-9\u4e00-\u9fa5]+$";
    NSPredicate * userNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", textStr];
    return [userNameTest evaluateWithObject:userName];
}

//密码
+ (BOOL)validatePassword:(NSString *)passWord
{
    
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


+ (NSDate*)getShortDateFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:str];
}

+ (NSDate*)getDateFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:str];
}

+ (NSDate*)getDateAndTimeFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter dateFromString:str];
}

+ (NSDate*)getTimeFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    return [formatter dateFromString:str];
}


+ (NSString*)getStringFormDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

+ (NSString*)getStringFormDateAndTime:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}
+ (NSString*)getStringMonthAndDayFormDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    return [formatter stringFromDate:date];
}

+ (NSString*)getStringTimeAndWeekFormDate:(NSDate*)date {
    if (!date) {
        return nil;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:date];

    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSMutableString *string = [NSMutableString string];
    
    switch (weekday) {
        case 1:
            [string appendString:@"星期日 "];
            break;
        case 2:
            [string appendString:@"星期一 "];
            break;
        case 3:
            [string appendString:@"星期二 "];
            break;
        case 4:
            [string appendString:@"星期三 "];
            break;
        case 5:
            [string appendString:@"星期四 "];
            break;
        case 6:
            [string appendString:@"星期五 "];
            break;
        case 7:
            [string appendString:@"星期六 "];
            break;

        default:
            break;
    }
    [string appendString:[formatter stringFromDate:date]];

    return string;
}

+ (NSString*)getShortStringTimeAndWeekFormDate:(NSDate*)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:[formatter stringFromDate:date]];
    switch (weekday) {
        case 1:
            [string appendString:@"(周日)"];
            break;
        case 2:
            [string appendString:@"(周一)"];
            break;
        case 3:
            [string appendString:@"(周二)"];
            break;
        case 4:
            [string appendString:@"(周三)"];
            break;
        case 5:
            [string appendString:@"(周四)"];
            break;
        case 6:
            [string appendString:@"(周五)"];
            break;
        case 7:
            [string appendString:@"(周六)"];
            break;
            
        default:
            break;
    }
    return string;
}



+ (NSString*)arrayChangeToString:(NSArray*)array withSplit:(NSString*)split {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0 ; i < array.count; i++) {
        [string appendString:[array objectAtIndex:i]];
        if (i != array.count - 1) {
            [string appendString:split];
        }
    }
    return string;
}

+ (NSArray*)changeStringToArray:(NSString*)string {
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@","];
    return [string componentsSeparatedByCharactersInSet:characterSet];
}

+ (NSString *)stringFromDic:(NSDictionary *)theDic
{
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [theDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [tmpDic setObject:obj forKey:[NSString stringWithFormat:@"%@", key]];
        
    }];
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmpDic options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError != nil) return nil;
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (NSString *)jsonStringFromArray:(NSArray *)theArray;
{
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:1];

    [theArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tmpArray addObject:[obj mutableCopy]];
    }];
    NSError *parseError = nil;
    
    @try {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmpArray options:NSJSONWritingPrettyPrinted error:&parseError];
        if (parseError != nil) return nil;
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}
+ (NSArray *)arrayFromJsonString:(NSString *)theString;
{
    @try {
        NSError *err                          = nil;
        NSData *responseData = [theString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray * jsonArr = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        return jsonArr;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

+ (NSDictionary *)dictionaryFromJsonString:(NSString *)theString;
{
    @try {
        NSError *err                          = nil;
        NSData *responseData = [theString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        return jsonDic;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

+ (UIColor *) getColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}


+ (void)imageView:(UIImageView *)imageView configImageWithUrl:(NSString *)url placeholderImageName:(NSString *)placeholderImageName
{
    __weak typeof(imageView)weakImageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:NSValueToString(placeholderImageName)] options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageUrl) {
        if (!image && error) {
            weakImageView.image = [UIImage imageNamed:NSValueToString(placeholderImageName)];
        }
        //        [weakImageView animateIn:weakImageView];
        
    }];
    
}

//获得设备型号
+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7s Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator4/4s";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}
@end
