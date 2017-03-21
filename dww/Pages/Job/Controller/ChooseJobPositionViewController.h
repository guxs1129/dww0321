//
//  ChooseJobPositionViewController.h
//  dww
//
//  Created by Shadow. G on 2017/1/9.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface ChooseJobPositionViewController : JiaBaseViewController

@property (nonatomic, strong) NSString *industryID;
@property (nonatomic, strong) NSString *firstJobPositionIDs; // 用于数据回显的一级职能IDs 用","分割
@property (nonatomic, strong) NSString *secondJobPositionIDs; // 用于数据回显的二级职能IDs 用","分割
@property (nonatomic, assign) NSUInteger maxSelectedCount;
@property (nonatomic, copy) void(^completeChoosePositionBlock)(NSArray *selectedData);

@end
