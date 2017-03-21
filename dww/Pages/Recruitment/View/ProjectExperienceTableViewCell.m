//
//  ProjectExperienceTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "ProjectExperienceTableViewCell.h"

#define kDefaultEditButtonWidth 52
@implementation ProjectExperienceTableViewCell

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
        self.projectNameLabel.text = [NSString stringWithFormat:@"项目名称 :  %@", NSValueToString(data[@"projectname"])];
        self.projectResponsibilityLabel.text = [NSString stringWithFormat:@"项目职责 :  %@", NSValueToString(data[@"projectRole"])];
        self.projectContentLabel.text = NSValueToString(data[@"projectDesc"]);
        [self.projectContentLabel setLineSpacing:8 labelText:self.projectContentLabel.text];
    }
}


@end
