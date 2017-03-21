//
//  AddSelfDescriptionViewController.h
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface AddSelfDescriptionViewController : JiaBaseViewController

@property (nonatomic, copy) void(^completeChooseBlock)(NSString *description);
@property (strong, nonatomic) NSString *req_selfContent; // 自我描述
@property (nonatomic, strong) NSString *resumeID;

@end
