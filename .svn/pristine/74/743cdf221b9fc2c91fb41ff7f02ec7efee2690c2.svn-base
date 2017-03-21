//
//  RecruitmentJobIntensionTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "RecruitmentJobIntensionTableViewCell.h"

@implementation RecruitmentJobIntensionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithData:(NSDictionary *)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.positionLabel.text = [NSString stringWithFormat:@"%@", NSValueToString(data[@"allCategoryLabel"])];
        if (data[@"resumeBaseInfo"] && [data[@"resumeBaseInfo"] isKindOfClass:[NSDictionary class]]) {
            self.wageLabel.text = [NSString stringWithFormat:@"%@ %@~%@元/月", NSValueToString(data[@"resumeBaseInfo"][@"natureCn"]), NSValueToString(data[@"wageBegin"]), NSValueToString(data[@"wageEnd"])];
        }
        self.industryLabel.text = [NSString stringWithFormat:@"期望行业 : %@", NSValueToString(data[@"topClassLabel"])];
        self.cityLabel.text = [NSString stringWithFormat:@"期望城市 : %@", NSValueToString(data[@"sdistrictName"])];
        
    }
}

@end
