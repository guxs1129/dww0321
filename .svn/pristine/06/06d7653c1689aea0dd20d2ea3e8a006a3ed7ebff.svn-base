//
//  ProjectExperienceTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectExperienceTableViewCell : UITableViewCell

@property (assign, nonatomic) BOOL isEditing;
@property (copy, nonatomic) void(^didClickEditButtonBlock)();

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eidtButtonWidth;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectResponsibilityLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectContentLabel;

- (void)configCellWithData:(NSDictionary *)data;

@end
