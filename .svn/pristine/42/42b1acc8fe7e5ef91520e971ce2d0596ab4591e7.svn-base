//
//  PersonalRecruitmentTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/9.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "PersonalRecruitmentTableViewCell.h"

@implementation PersonalRecruitmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickDeleteButton:(id)sender {
    if (self.didClickDeleteButtonBlock) {
        self.didClickDeleteButtonBlock();
    }
}

- (void)configCellWithData:(NSDictionary *)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        if (data[@"companyLocal"] && [data[@"companyLocal"] isKindOfClass:[NSDictionary class]]) {
            
            self.companyNameLabel.text = data[@"companyLocal"][@"companyname"];
            [Tool imageView:self.iconImageView configImageWithUrl:data[@"companyLocal"][@"companylogoLocal"] placeholderImageName:@""];
            if (self.cellType == RecruitmentCellTypeLooking) {
                
                self.timeLabel.text = [NSString stringWithFormat:@"最近查看 : %@", NSValueToString(data[@"clickTimeLabel"])];
                self.countLabel.text = [NSString stringWithFormat:@"查看%@次", NSValueToString(data[@"click"])];
                NSMutableAttributedString *attributedCountStr = [[NSMutableAttributedString alloc] initWithString:self.countLabel.text attributes:@{NSForegroundColorAttributeName : LIGHTTEXTCOLOR}];
                if (attributedCountStr.length > 2) {
                    [attributedCountStr addAttribute:NSForegroundColorAttributeName value:CUSTOMREDCOLOR range:NSMakeRange(2, self.countLabel.text.length - 2)];
                }
                self.countLabel.attributedText = attributedCountStr;
                
            } else if (self.cellType == RecruitmentCellTypeDownload)
            {
                self.timeLabel.text = [NSString stringWithFormat:@"最近下载 : %@", NSValueToString(data[@"downTimeLabel"])];
                self.countLabel.text = [NSString stringWithFormat:@"下载%@次", NSValueToString(data[@"down"])];
                NSMutableAttributedString *attributedCountStr = [[NSMutableAttributedString alloc] initWithString:self.countLabel.text attributes:@{NSForegroundColorAttributeName : LIGHTTEXTCOLOR}];
                if (attributedCountStr.length > 2) {
                    [attributedCountStr addAttribute:NSForegroundColorAttributeName value:CUSTOMREDCOLOR range:NSMakeRange(2, self.countLabel.text.length - 2)];
                }
                self.countLabel.attributedText = attributedCountStr;
            }
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
