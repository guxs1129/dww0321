//
//  SWLocationManager.h
//  dww
//
//  Created by Shadow. G on 2016/12/29.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


typedef void(^CLLocationDidChangeBlock)(BOOL getOK, NSString *lat, NSString *lng, NSString *errorMsg, NSString *cityName);
@interface SWLocationManager : NSObject

@property (nonatomic, strong) NSString *lat; // 定位的维度
@property (nonatomic, strong) NSString *lng; // 定位的经度
@property (nonatomic, strong) NSString *cityName; // 定位的城市

+ (instancetype)sharedInstance;
/**
 *开始定位
 */
- (void)startLocationWithBlock:(CLLocationDidChangeBlock)block;

// 获取当前城市
- (void)getCurrentCityNameWithlocation:(CLLocation *)location completeBlock:(void(^)(NSString *city))completeBlock;

@end
