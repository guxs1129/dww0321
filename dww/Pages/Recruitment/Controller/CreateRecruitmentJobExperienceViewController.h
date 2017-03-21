//
//  CreateRecruitmentJobExperienceViewController.h
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface CreateRecruitmentJobExperienceViewController : JiaBaseViewController

@property (nonatomic, strong) NSString *resumeID; // 简历主ID
@property (nonatomic, strong) NSString *jobExperienceID; // 工作经历ID
@property (nonatomic, strong) NSDictionary *jobExperienceData; // 展示工作经历时传入
@property (nonatomic, assign) BOOL isEditing; // 是否是编辑模式

@end
