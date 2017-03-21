//
//  JobPositionTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2016/12/29.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "JobPositionTableViewCell.h"
#import "NSDate+Utilities.h"

@implementation JobPositionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetCellWithData:(NSDictionary *)data
{
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    NSDictionary * imgPositionidLocal = data;
  
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        
        
        self.positionNameLabel.text = NSValueToString(imgPositionidLocal[@"positionName"]);
        self.timeLabel.text = [[NSDate dateWithTimeIntervalSince1970:[NSValueToString(imgPositionidLocal[@"companyAddtime"]) doubleValue]] stringWithFormat:@"MM月dd日"];
        if ([self.timeLabel.text isEqualToString:[[NSDate date] stringWithFormat:@"MM月dd日"]]) {
            self.timeLabel.text = @"今天";
        }
        self.moneyLabel.text = [NSString stringWithFormat:@"%@-%@元/月", NSValueToString(imgPositionidLocal[@"wageBegin"]), NSValueToString(imgPositionidLocal[@"wageEnd"])];
        if (imgPositionidLocal[@"companyIDLocal"] && [imgPositionidLocal[@"companyIDLocal"] isKindOfClass:[NSDictionary class]]) {
            [Tool imageView:self.iconImageView configImageWithUrl:NSValueToString(imgPositionidLocal[@"companyIDLocal"][@"companylogoLocal"]) placeholderImageName:@""];
            self.companyLabel.text = NSValueToString(imgPositionidLocal[@"companyIDLocal"][@"companyname"]);
           
        }
//
        self.extraInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@", NSValueToString(imgPositionidLocal[@"districtCn"]), NSValueToString(imgPositionidLocal[@"experienceCn"]), NSValueToString(imgPositionidLocal[@"educationCn"])];
    
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
