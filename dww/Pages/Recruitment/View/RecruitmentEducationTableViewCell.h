//
//  RecruitmentEducationTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecruitmentEducationTableViewCell : UITableViewCell

@property (assign, nonatomic) BOOL isEditing;
@property (copy, nonatomic) void(^didClickEditButtonBlock)();

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eidtButtonWidth;
@property (strong, nonatomic) IBOutlet UILabel *schoolInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *extraInfoLabel;

- (void)configCellWithData:(NSDictionary *)data;

@end
