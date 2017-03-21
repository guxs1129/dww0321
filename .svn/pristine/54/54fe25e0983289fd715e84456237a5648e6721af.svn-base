//
//  PositionSubscriberTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "PositionSubscriberTableViewCell.h"

@implementation PositionSubscriberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickLeftChooseButtonAction:(id)sender {
    if (self.didClickedLeftChooseButtonBlock) {
        self.didClickedLeftChooseButtonBlock();
    }
}
- (IBAction)clickRightChooseButtonAction:(id)sender {
    if (self.didClickedRightChooseButtonBlock) {
        self.didClickedRightChooseButtonBlock();
    }
}

- (void)setModel:(PositionSubscriberModel *)model
{
    if (model) {
        _model = model;
        self.titleLabel.text = model.title;
        self.starImageView.hidden = !model.isRequired;
        self.leftChooseView.hidden = !model.needShowLeftChooseView;
      
        self.leftChooseButton.userInteractionEnabled = model.needShowLeftChooseView;
        self.rightChooseButton.userInteractionEnabled = YES;
        if (model.needShowLeftChooseView) {
            [self.rightChooseButton setTitle:[NSValueToString(model.subValue) length] > 0 ? NSValueToString(model.subValue) : @"请选择" forState:UIControlStateNormal];
            [self.leftChooseButton setTitle:[NSValueToString(model.value) length] > 0 ? NSValueToString(model.value) : @"请选择" forState:UIControlStateNormal];
            
        } else
        {
           [self.rightChooseButton setTitle:[NSValueToString(model.value) length] > 0 ? NSValueToString(model.value) : @"请选择" forState:UIControlStateNormal];
            
        }
    }
}

@end
