//
//  AddRecruitmentSkillTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRecruitmentSkillModel.h"

@interface AddRecruitmentSkillTableViewCell : UITableViewCell

@property (strong, nonatomic) AddRecruitmentSkillModel *model;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *valueTextField;
@property (strong, nonatomic) IBOutlet UIButton *subValueButton;

@property (strong, nonatomic) void(^didClickSubValueButtonBlock)();

@end
