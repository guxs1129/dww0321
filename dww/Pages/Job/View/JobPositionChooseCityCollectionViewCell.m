//
//  JobPositionChooseCityCollectionViewCell.m
//  dww
//
//  Created by Shadow. G on 2016/12/27.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "JobPositionChooseCityCollectionViewCell.h"
#import "JMRoundedCorner.h"

@implementation JobPositionChooseCityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.contentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.contentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.contentButton.userInteractionEnabled = NO;
        [self.contentButton setTitleColor:[UIColor colorWithHexString:@"0x666666"] forState:UIControlStateNormal];

        [self.contentView addSubview:self.contentButton];
        [self.contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
        }];
        [self layoutIfNeeded];
        [self.contentView jm_setImageWithCornerRadius:CGRectGetHeight(self.frame) / 2 borderColor:[UIColor colorWithHexString:@"0xc0c0c0"] borderWidth:0.5 backgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
