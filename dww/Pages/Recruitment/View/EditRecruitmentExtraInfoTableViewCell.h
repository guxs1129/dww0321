//
//  EditRecruitmentExtraInfoTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditRecruitmentExtraInfoTableViewCell : UITableViewCell

@property (copy, nonatomic) void(^didClickEditButtonBlock)();
@property (strong, nonatomic) IBOutlet UILabel *languageLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *skillLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *selfDescriptionLabel;
- (void)configCellWithData:(NSDictionary *)data;


@end
