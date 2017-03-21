//
//  CreateRecruitmentIobintensionViewController.h
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface CreateRecruitmentJobintensionViewController : JiaBaseViewController

@property (nonatomic, strong) NSString *resumeID; // 简历主ID
@property (nonatomic, strong) NSString *jobIntensionID; // 工作意向ID
@property (nonatomic, strong) NSDictionary *jobIntensionData; // 展示工作意向时传入
@property (nonatomic, assign) BOOL isEditing; // 是否是编辑模式

@end
