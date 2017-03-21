//
//  AddRecruitmentSkillTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "AddRecruitmentSkillTableViewCell.h"

@implementation AddRecruitmentSkillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.valueTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.valueTextField.placeholder attributes:@{NSForegroundColorAttributeName : LIGHTTEXTCOLOR}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickSubValueButtonAction:(id)sender {
    if (self.didClickSubValueButtonBlock) {
        self.didClickSubValueButtonBlock();
    }
}

- (void)setModel:(AddRecruitmentSkillModel *)model
{
    if (model) {
        _model = model;
        self.valueTextField.text = NSValueToString(model.value);
        if ([NSValueToString(model.subValue) length] > 0) {
            [self.subValueButton setTitle:NSValueToString(model.subValue) forState:UIControlStateNormal];
            [self.subValueButton setTitleColor:DARKTEXTCOLOR forState:UIControlStateNormal];
        } else
        {
            [self.subValueButton setTitle:@"请选择熟练程度" forState:UIControlStateNormal];
            [self.subValueButton setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        }
        self.valueTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.valueTextField.placeholder attributes:@{NSForegroundColorAttributeName : LIGHTTEXTCOLOR}];
    }
}

@end
