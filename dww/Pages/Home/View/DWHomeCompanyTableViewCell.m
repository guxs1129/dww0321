//
//  DWHomeCompanyTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/15.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "DWHomeCompanyTableViewCell.h"

@implementation DWHomeCompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetCellWithData:(NSDictionary *)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.companyNameLabel.text = NSValueToString(data[@"imgCompanyidLocal"][@"companyname"]);
        self.companyIntroduceLabel.text = NSValueToString(data[@"imgCompanyidLocal"][@"companydesc"]);
        [Tool imageView:self.companyAvatarImageView configImageWithUrl:NSValueToString(data[@"imgCompanyidLocal"][@"companylogoLocal"]) placeholderImageName:@""];
        self.jobPositionCountLabel.text = [NSString stringWithFormat:@"%@个", NSValueToString(data[@"imgCompanyidLocal"][@"jobPositionCount"])];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.jobPositionCountLabel.text];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0XEA4436"] range:NSMakeRange(0, attributedStr.length - 1)];
        self.jobPositionCountLabel.attributedText = attributedStr;
        [self.companyIntroduceLabel setLineSpacing:3 labelText:self.companyIntroduceLabel.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
