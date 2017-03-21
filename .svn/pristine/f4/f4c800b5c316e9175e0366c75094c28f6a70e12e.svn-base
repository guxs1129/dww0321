//
//  SWLocationManager.m
//  dww
//
//  Created by Shadow. G on 2016/12/29.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "SWLocationManager.h"

@interface SWLocationManager ()<CLLocationManagerDelegate>

{
    
    CLLocationManager * locationManager;
    
}
@property (nonatomic, assign) BOOL isAuth; // 定位授权是否被用户允许或者不允许  default it's NO
@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, copy) CLLocationDidChangeBlock locationDidChangeBlock;

@end
@implementation SWLocationManager

+ (instancetype)sharedInstance
{
    static SWLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SWLocationManager alloc] init];
    });
    return manager;
}

/**
 *开始定位
 */
- (void)startLocationWithBlock:(CLLocationDidChangeBlock)block
{
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [locationManager requestWhenInUseAuthorization];
        }
    }
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    self.locationDidChangeBlock = block;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        while (!self.isAuth) {
//            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        }
//        block(self.result, self.lat, self.lng, self.errorMsg, self.cityName);
//    });
}


#pragma mark --- 代理方法

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        self.errorMsg = @"访问被拒绝";
    }
    
    if ([error code] == kCLErrorLocationUnknown) {
        self.errorMsg = @"无法获取位置信息";
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.result   = YES;
    self.lat      = [NSString stringWithFormat:@"%f", manager.location.coordinate.latitude];
    self.lng      = [NSString stringWithFormat:@"%f", manager.location.coordinate.longitude];
    [self getCurrentCityNameWithlocation:manager.location completeBlock:^(NSString *city) {
        self.cityName = city;
    }];
    self.errorMsg = nil;
    self.locationDidChangeBlock(self.result, self.lat, self.lng, self.errorMsg, self.cityName);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [locationManager requestWhenInUseAuthorization];
            }
            
            self.isAuth = NO;
            
            break;
        }
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            self.result   = NO;
            self.lat      = nil;
            self.lng      = nil;
            self.cityName = nil;
            self.errorMsg = @"授权失败";
            self.isAuth   = YES;
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            CGFloat latF = manager.location.coordinate.latitude;
            CGFloat lngF = manager.location.coordinate.longitude;
            NSString *lat = [NSString stringWithFormat:@"%f", latF];
            NSString *lng = [NSString stringWithFormat:@"%f", lngF];
            
            if (latF == 0.0 && lngF == 0.0)
            {
                self.result   = NO;
                self.lat      = nil;
                self.lng      = nil;
                self.cityName = nil;
                self.errorMsg = @"获取失败";
                self.isAuth   = YES;
            }
            else
            {
                self.result   = YES;
                self.lat      = lat;
                self.lng      = lng;
                self.errorMsg = nil;
                [self getCurrentCityNameWithlocation:manager.location completeBlock:^(NSString *city) {
                    self.cityName = city;
                    self.isAuth = YES;
                }];
            }

        }
            break;
        default:
            break;
    }
    self.locationDidChangeBlock(self.result, self.lat, self.lng, self.errorMsg, self.cityName);
}

// 获取城市
- (void)getCurrentCityNameWithlocation:(CLLocation *)location completeBlock:(void(^)(NSString *city))completeBlock
{
    __block NSString *city = @"";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            
            // 获取城市
            city = placemark.locality;
            if (!city) {
                // 四大直辖市的城市信息可能无法通过locality获得, 通过获取省份的方法来获取
                city = placemark.administrativeArea;
            }
        } else if (error == nil && [placemarks count] > 0)
        {
            NSLog(@"没有结果返回");
        } else if (error != nil)
        {
            NSLog(@"错误原因: %@" , error);
        }

        completeBlock(city);
    }];
    
}

- (void)dealloc
{
     [locationManager stopUpdatingLocation];
}


@end
