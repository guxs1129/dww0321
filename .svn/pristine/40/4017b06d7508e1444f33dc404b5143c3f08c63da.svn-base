//
//  UIViewController+Login.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "UIViewController+Login.h"
#import "DWLoginViewController.h"

@implementation UIViewController (Login)

- (BOOL)needLogin
{
    return ![[DWUserDataManager standardUserDefaults] isLogin];
}

- (void)goLogin
{
    [self goLoginWithAnimation:YES];
}

- (void)goLoginWithAnimation:(BOOL)animation
{
    [self goLoginWithAnimation:animation completeAction:nil];
}

- (void)goLoginWithAnimation:(BOOL)animation completeAction:(void(^)())completeAction
{
    DWLoginViewController *loginVC = [[DWLoginViewController alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    if (completeAction) {
        loginVC.completeLoginBlock = [completeAction copy];
    }
    RTRootNavigationController *navigationController = [[RTRootNavigationController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}


@end
