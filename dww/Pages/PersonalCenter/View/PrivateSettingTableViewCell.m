//
//  PrivateSettingTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "PrivateSettingTableViewCell.h"

@implementation PrivateSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)clickRightButtonAction:(id)sender {
    
    if (self.didClickRightButtonBlock) {
        self.didClickRightButtonBlock();
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
