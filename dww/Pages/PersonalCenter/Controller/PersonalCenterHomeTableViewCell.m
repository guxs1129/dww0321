//
//  PersonalCenterHomeTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "PersonalCenterHomeTableViewCell.h"

@implementation PersonalCenterHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self layoutIfNeeded];
    self.numberCountLabel.layer.cornerRadius = self.numberCountLabel.frame.size.height / 2;
    self.numberCountLabel.clipsToBounds = YES;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
