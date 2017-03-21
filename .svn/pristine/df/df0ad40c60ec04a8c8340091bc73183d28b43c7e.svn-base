//
//  RecruitmentEducationTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "RecruitmentEducationTableViewCell.h"

#define kDefaultEditButtonWidth 52
@implementation RecruitmentEducationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickEditButtonAction:(id)sender {
    if (self.isEditing) {
        if (self.didClickEditButtonBlock) {
            self.didClickEditButtonBlock();
        }
    }
}
- (void)configCellWithData:(NSDictionary *)data
{
    if (self.isEditing) {
        self.eidtButtonWidth.constant = kDefaultEditButtonWidth;
    } else{
        self.eidtButtonWidth.constant = 0;
    }
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.schoolInfoLabel.text = [NSString stringWithFormat:@"%@.%@-%@.%@     %@", NSValueToString(data[@"startyear"]),NSValueToString(data[@"startmonth"]), NSValueToString(data[@"endyear"]),NSValueToString(data[@"endmonth"]),NSValueToString(data[@"school"])];
        self.extraInfoLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", NSValueToString(data[@"educationCn"]), NSValueToString(data[@"majorDesc"]), NSValueToString(data[@"eduTypeLabel"])];
        
    }
}

@end
