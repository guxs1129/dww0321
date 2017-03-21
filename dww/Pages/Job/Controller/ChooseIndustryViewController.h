//
//  ChooseIndustryViewController.h
//  dww
//
//  Created by Shadow. G on 2017/1/9.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface ChooseIndustryViewController : JiaBaseViewController

@property (nonatomic, strong) NSString *industryID; // 用于数据回显的ID
@property (nonatomic, strong) void(^completeChooseBlock)(NSString *industryName, NSString *industryID);

@end
