//
//  HaoConfig.m
//  HaoxiHttprequest
//
//  Created by lianghuigui on 15/11/29.
//  Copyright © 2015年 lianghuigui. All rights reserved.
//

#import "HaoConfig.h"

@implementation HaoConfig
+(NSString *)getClientInfo{
    
    return @"dww-ios";
}

+(NSString *)getSecretHax{
    
    return @"secret=YnRfGvyfpUPILeYuki";
}

+(NSString *)getApiHost{
    
    BOOL ceshi   = [[NSUserDefaults standardUserDefaults] boolForKey:@"FFFFFFFF"];
    return ceshi ? @"api-dww.haoxitech.com" : @"api.dawennet.com";
    
}

+(NSString *)getHtmlHost
{
    BOOL ceshi   = [[NSUserDefaults standardUserDefaults] boolForKey:@"FFFFFFFF"];
    return ceshi ? @"www-dww.haoxitech.com/" : @"www.dawennet.com/";
}

+(NSString *)getClientVersion{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
@end
