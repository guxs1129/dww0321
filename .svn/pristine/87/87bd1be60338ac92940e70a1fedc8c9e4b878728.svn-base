//
//  DWNavigationControllerConfig.m
//  dww
//
//  Created by Shadow.G on 16/12/23.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "DWNavigationControllerConfig.h"

@implementation DWNavigationControllerConfig

+ (void)setupNavigationBarAppearanceConfig
{
    
    // title attributes
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : [UIColor blackColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif

    }
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
    // background color
//    [navigationBarAppearance setBackgroundColor:kNavBackgroundColor];
    [navigationBarAppearance setBarTintColor:kNavBackgroundColor];
    
    /*translucent 导航栏是否半透明*/
    [navigationBarAppearance setTranslucent:NO];

}

@end
