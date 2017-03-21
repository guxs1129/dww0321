//
//  AddLanguageLevelViewController.h
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface AddLanguageLevelViewController : JiaBaseViewController

@property (nonatomic, strong) NSArray *languages; // 用于数据回显
@property (nonatomic, copy) void(^completeChooseBlock)(NSArray<NSDictionary *>* selectedArray);
@property (nonatomic, strong) NSString *resumeID;

@end
