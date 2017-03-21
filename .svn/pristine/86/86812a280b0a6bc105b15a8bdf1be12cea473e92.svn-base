//
//  CompanyHotPositionTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/15.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CompanyHotPositionTableViewCell.h"
#import "NSDate+Utilities.h"

@implementation CompanyHotPositionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resetCellWithData:(NSDictionary *)data
{
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.positionNameLabel.text = NSValueToString(data[@"positionName"]);
      
        self.timeLabel.text = [[NSDate dateWithTimeIntervalSince1970:[NSValueToString(data[@"companyAddtime"]) doubleValue]] stringWithFormat:@"MM月dd日"];
        if ([self.timeLabel.text isEqualToString:[[NSDate date] stringWithFormat:@"MM月dd日"]]) {
            self.timeLabel.text = @"今天";
        }
        self.extraInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@", NSValueToString(data[@"districtCn"]), NSValueToString(data[@"experienceCn"]), NSValueToString(data[@"educationCn"])];
        self.moneyLabel.text = [NSString stringWithFormat:@"%@-%@元/月", NSValueToString(data[@"wageBegin"]), NSValueToString(data[@"wageEnd"])];
    }
}

@end
