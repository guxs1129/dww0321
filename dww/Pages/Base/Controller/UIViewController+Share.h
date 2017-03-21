//
//  UIViewController+Share.h
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "UMSocialData.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialConfig.h"

#import "UMSocialSnsService.h"

@interface UIViewController (Share)<UMSocialUIDelegate>
// 快速分享
- (void)snsSocialWithText:(NSString *)text url:(NSString *)url imageUrl:(NSString *)imageUrl;

// 自定义分享
- (void)customShareWithText:(NSString *)text imageUrl:(NSString *)imageUrl title:(NSString *)title clickUrl:(NSString *)clickUrl shareToSnsName:(NSString *)snsName;

@end
