//
//  AppDelegate.m
//  dww
//
//  Created by Shadow.G on 16/12/19.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "AppDelegate.h"
#import "DWTabBarControllerConfig.h"
#import "DWNavigationControllerConfig.h"
#import "HaoConnect.h"
#import "MBProgressHUD+MP.h"
#import "DWAreaDataManager.h"
#import "UMSocialData.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialConfig.h"
#import "UMSocialSnsService.h"
#import "UMSocialSinaSSOHandler.h"
#import "WXApi.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)appExit
{
    [[DWUserDataManager standardUserDefaults] exitLogin];
    [HaoConnect setCurrentUserInfo:@"" :@"" :@""];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]init];
    [Bugly startWithAppId:@"6ca209c278"];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [DWTabBarControllerConfig sharedInstance].tabBarController;
//    [DWNavigationControllerConfig setupNavigationBarAppearanceConfig];
    // 判断是否需要更新缓存, 具体策略待定
    if ([DWAreaDataManager cacheUpdateIfNeedWith:[[NSDate date] stringWithFormat:kDateFormatString] cachePath:[DWAreaDataManager cachePathOfHotCities]]) {
        
        [self requestHotCitiesDataWithCompleteBlock:^(BOOL isNeedUpdateAllCitiesCache) {
            if (isNeedUpdateAllCitiesCache) {
                [self requestCitiesListDataWithCompleteBlock:^{
                    
                }];
            }
        }];
        
    }
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMENGSDKKEY];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址  801555504  moren:wxd930ea5d5a258f4f
    [UMSocialWechatHandler setWXAppId:WXAPPID appSecret:WXAPPSECRECT url:@""];
    [WXApi registerApp:WXAPPID withDescription:@"大文网"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:SINAAPPKEY
                                              secret:SINAAPPSECRECT
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接  demo:appid-100424468  c7394704798a158208a74ab60104f0ba
    [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKEY url:@""];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];

    [self.window makeKeyAndVisible];
    return YES;
}

// 缓存地区数据

- (void)requestCitiesListDataWithCompleteBlock:(void(^)())block
{
    [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"2",@"g_r_a_d_e",
               nil];
    [HaoConnect request:@"pub_category_district/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:kKeyWindow animated:YES];
        if (result.isResultsOK) {
            
            [DWAreaDataManager saveCityListToCache:result.results lastUpdateTime:[[NSDate date] stringWithFormat:kDateFormatString] cachePath:[DWAreaDataManager cachePathOfAllCities] withCompletion:^{
                
                if (block) {
                    block();
                }
                
            }];
            
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:kKeyWindow animated:YES];
    }];
    
}

- (void)requestHotCitiesDataWithCompleteBlock:(void(^)(BOOL isNeedUpdateAllCitiesCache))completeBlock
{
    [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"1",@"hotcity",
               @"1",@"g_r_a_d_e",
               nil];
    [HaoConnect request:@"pub_category_district/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:kKeyWindow animated:YES];
        if (result.isResultsOK) {
            
            if ([DWAreaDataManager cacheUpdateIfNeedWith:[[NSDate date] stringWithFormat:kDateFormatString] cachePath:[DWAreaDataManager cachePathOfHotCities]]) {
                
                [DWAreaDataManager saveCityListToCache:result.results lastUpdateTime:[[NSDate date] stringWithFormat:kDateFormatString] cachePath:[DWAreaDataManager cachePathOfHotCities] withCompletion:^{
                    if (completeBlock) {
                        completeBlock(YES);
                    }
                }];
            } else
            {
                if (completeBlock) {
                    completeBlock(NO);
                }
            }
            
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:kKeyWindow animated:YES];
    }];
}


/*
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return [UMSocialSnsService handleOpenURL:url];
    
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [self application:app handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self application:application handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
     [UMSocialSnsService applicationDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
