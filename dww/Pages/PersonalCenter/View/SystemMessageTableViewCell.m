//
//  SystemMessageTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "SystemMessageTableViewCell.h"

#define kDefaultContentBackgroundViewHeight 47
@implementation SystemMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self layoutIfNeeded];
    self.redRoundView.layer.cornerRadius = self.redRoundView.frame.size.height / 2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DWSystemMessageModel *)model
{
    if (model) {
        _model = model;
        self.redRoundView.hidden = !model.showRedRoundView;
        self.titleLabel.text = model.title;
        self.timeLabel.text = model.date;
        self.contentLabel.text = model.message;
        if (model.isShowDetail) {
            CGFloat contentLabelHeight = [model.message getHeightWithFont:self.contentLabel.font constrainedToSize:CGSizeMake(self.contentLabel.frame.size.width, CGFLOAT_MAX)];

            self.contentBackgroundViewHeight.constant = contentLabelHeight + kDefaultContentBackgroundViewHeight;
            self.downArrowView.hidden = YES;
        }else
        {
            self.contentBackgroundViewHeight.constant = 0;
            self.downArrowView.hidden = NO;
        }
    }
}

@end
