//
//  RecruitmentJobExperienceTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "RecruitmentJobExperienceTableViewCell.h"

#define kDefaultEditButtonWidth 52
 #define LINESPACE 10
@implementation RecruitmentJobExperienceTableViewCell

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
        self.timeLabel.text = [NSString stringWithFormat:@"%@.%@-%@.%@", NSValueToString(data[@"startyear"]),NSValueToString(data[@"startmonth"]), NSValueToString(data[@"endyear"]),NSValueToString(data[@"endmonth"])];
        self.titleLabel.text = [NSString stringWithFormat:@"%@ / %@", NSValueToString(data[@"companyname"]), NSValueToString(data[@"jobs"])];
        self.jobContentLabel.text = NSValueToString(data[@"achievements"]);
        [self.jobContentLabel setLineSpacing:8 labelText:self.jobContentLabel.text];
    }
}

@end
