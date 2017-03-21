//
//  PersonalJobPositionTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "PersonalJobPositionTableViewCell.h"

@implementation PersonalJobPositionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (IBAction)clickLeftButtonAction:(id)sender {
    if (self.didClickLeftButtonBlock) {
        self.didClickLeftButtonBlock(self.bottomLeftButton);
    }
}

- (IBAction)clickRightButtonAction:(id)sender {
    if (self.didClickRightButtonBlock) {
        self.didClickRightButtonBlock();
    }
}

- (void)configCellWithData:(NSDictionary *)data
{
    if (self.cellType == PersonalJobPositionCellTypeSending) {
        [self.bottomLeftButton setTitle:@"已投递" forState:UIControlStateNormal];
        self.bottomLeftButton.userInteractionEnabled = NO;
        [self.bottomRightButton setTitle:@"删除记录" forState:UIControlStateNormal];
    } else if (self.cellType == PersonalJobPositionCellTypeCollection)
    {
        [self.bottomLeftButton setTitle:@"收藏" forState:UIControlStateNormal];
        [self.bottomLeftButton setTitle:@"取消收藏" forState:UIControlStateSelected];
        [self.bottomRightButton setTitle:@"投递简历" forState:UIControlStateNormal];
        [self.bottomRightButton setTitle:@"已投递" forState:UIControlStateSelected];
        
    }
    
    
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.positionLabel.text = NSValueToString(data[@"positionName"]);
        if (self.cellType == PersonalJobPositionCellTypeSending) {
            self.timeLabel.text = [NSString stringWithFormat:@"投递于 : %@", data[@"applyAddtimeLabel"]];
        } else if (self.cellType == PersonalJobPositionCellTypeCollection)
        {
            self.timeLabel.text = [NSString stringWithFormat:@"收藏于 : %@", data[@"addtimeLabel"]];
            
        }
        
        NSDictionary *positionLocal = data[@"positionLocal"];
        if (positionLocal && [positionLocal isKindOfClass:[NSDictionary class]]) {
            self.companyLabel.text = NSValueToString(positionLocal[@"companyname"]);
            self.payLabel.text = [NSString stringWithFormat:@"%@-%@元/月", NSValueToString(positionLocal[@"wageBegin"]), NSValueToString(positionLocal[@"wageEnd"])];
            
            if (self.cellType == PersonalJobPositionCellTypeCollection) {
                self.bottomLeftButton.selected = [NSValueToString(positionLocal[@"isFavorite"]) boolValue];
                self.bottomRightButton.selected = [NSValueToString(positionLocal[@"isApply"]) boolValue];
                [self.bottomRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                if (self.bottomRightButton.selected) {
                    self.bottomRightButton.userInteractionEnabled = NO;
                    [self.bottomRightButton setBackgroundColor:[UIColor colorWithHexString:@"0xd0d0d0"]];
                    [self.bottomRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                } else
                {
                    self.bottomRightButton.userInteractionEnabled = YES;
                    self.bottomRightButton.backgroundColor = CUSTOMORANGECOLOR;
                    [self.bottomRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                }
            }
        }
        NSDictionary *companyLocal = data[@"companyLocal"];
        if (companyLocal && [companyLocal isKindOfClass:[NSDictionary class]]) {
            [Tool imageView:self.iconImageView configImageWithUrl:NSValueToString(companyLocal[@"companylogoLocal"]) placeholderImageName:@""];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
