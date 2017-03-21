//
//  PersonalRecruitmentTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/9.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RecruitmentCellType) {
    RecruitmentCellTypeDownload,
    RecruitmentCellTypeLooking,
};
@interface PersonalRecruitmentTableViewCell : UITableViewCell

@property (copy, nonatomic) void(^didClickDeleteButtonBlock)();
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (assign, nonatomic) RecruitmentCellType cellType;

- (void)configCellWithData:(NSDictionary *)data;

@end
