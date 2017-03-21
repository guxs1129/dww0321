//
//  EditRecruitmentExtraInfoTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "EditRecruitmentExtraInfoTableViewCell.h"

@implementation EditRecruitmentExtraInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickEditButtonAction:(id)sender {
    if (self.didClickEditButtonBlock) {
        self.didClickEditButtonBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithData:(NSDictionary *)data
{
    
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.languageLevelLabel.text = [NSString stringWithFormat:@"语言程度 :  %@", NSValueToString(data[@"languageDesc"])];
        self.skillLevelLabel.text = [NSString stringWithFormat:@"掌握技能 :  %@", NSValueToString(data[@"skillDesc"])];
        self.selfDescriptionLabel.text = NSValueToString(data[@"selfDesc"]);
        [self.selfDescriptionLabel setLineSpacing:8 labelText:self.selfDescriptionLabel.text];
    }
}

@end
