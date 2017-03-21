//
//  DWUserDataManager.m
//  dww
//
//  Created by Shadow. G on 2017/1/6.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "DWUserDataManager.h"

@implementation DWUserDataManager

- (BOOL)isLogin
{
    if (self.userID == nil || self.checkcode == nil) {
        return NO;
    } else
    {
        return YES;
    }
}

- (void)exitLogin
{
    self.userID = nil;
    self.logintime = nil;
    self.checkcode = nil;
    self.userName = nil;
}

@end
