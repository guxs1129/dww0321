//
//  DWTabBarControllerConfig.h
//  dww
//
//  Created by Shadow.G on 16/12/23.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

#define kTabBarSelectedIndexChangeNotification @"CYLTabBarSelectedIndexDidChangeNotification"
@interface DWTabBarControllerConfig : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;

@end
