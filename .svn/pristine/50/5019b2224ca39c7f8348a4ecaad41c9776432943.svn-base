//
//  RecruitmentInfoTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/4.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "RecruitmentInfoTableViewCell.h"

@implementation RecruitmentInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark --- btn action

- (IBAction)clickRightChooseButtonAction:(id)sender {
    
    if (self.didClickRightChooseButtonBlock) {
        self.didClickRightChooseButtonBlock();
    }
}
- (IBAction)clickLeftChooseButtonAction:(id)sender {
    
    if (self.didClickLeftChooseButtonBlock) {
        self.didClickLeftChooseButtonBlock();
    }
}
- (IBAction)clickSingleLeftChooseButtonAction:(id)sender {
    self.singleLeftChooseBtn.selected = YES;
    self.singleRightChooseBtn.selected = NO;
    if (self.didClickSingleLeftChooseButtonBlock) {
        self.didClickSingleLeftChooseButtonBlock();
    }
}
- (IBAction)clickSingleRightChooseButtonAction:(id)sender {
    self.singleRightChooseBtn.selected = YES;
    self.singleLeftChooseBtn.selected = NO;
    if (self.didClickSingleRightChooseButtonBlock) {
        self.didClickSingleRightChooseButtonBlock();
    }
}


- (void)setModel:(RecruitmentInfoCellModel *)model
{
    if (model) {
        _model = model;
        self.titleLabel.text = model.title;
        self.starImageView.hidden = !model.isRequired;
        
        if (self.starImageView.hidden) {
            self.starImageViewWidth.constant = 0;
            self.starImageViewRightInset.constant = 0;
        } else
        {
            self.starImageViewWidth.constant = 5;
            self.starImageViewRightInset.constant = 8;
        }
        
        [self.singleLeftChooseBtn setTitle:model.singleChooseLeftButtonTitle forState:UIControlStateNormal];
        [self.singleRightChooseBtn setTitle:model.singleChooseRightButtonTitle forState:UIControlStateNormal];
        [self setupCellAppearanceWithCellType:model];
        self.contentTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.contentTextField.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0X999999"]}];
    }
}

- (void)setupCellAppearanceWithCellType:(RecruitmentInfoCellModel *)cellModel
{
    RecruitmentInfoCellType cellType = cellModel.cellType;
    NSString *cellValue = cellModel.value;
    NSString *cellSubValue = cellModel.subValue;
    self.arrowImageView.hidden = YES;
    switch (cellType) {
        case RecruitmentInfoCellTypeTextField:
        {
            self.contentTextField.hidden = NO;
            self.leftChooseView.hidden = YES;
            self.leftChooseButton.userInteractionEnabled = NO;
            self.rightChooseButton.hidden = YES;
            self.rightChooseButton.userInteractionEnabled = NO;
            self.singleChooseView.hidden = YES;
            self.contentTextField.text = cellValue;
        }
            break;
        case RecruitmentInfoCellTypeSingleChoose:
        {
            self.contentTextField.hidden = YES;
            self.leftChooseView.hidden = YES;
            self.leftChooseButton.userInteractionEnabled = NO;
            self.rightChooseButton.hidden = YES;
            self.rightChooseButton.userInteractionEnabled = NO;
            self.singleChooseView.hidden = NO;
            
        }
            break;
        case RecruitmentInfoCellTypeShowRightChooseView:
        {
            self.contentTextField.hidden = YES;
            self.leftChooseView.hidden = YES;
            self.leftChooseButton.userInteractionEnabled = NO;
            self.rightChooseButton.hidden = NO;
            self.rightChooseButton.userInteractionEnabled = YES;
            self.singleChooseView.hidden = YES;
            self.arrowImageView.hidden = NO;
            [self.rightChooseButton setTitle:[NSValueToString(cellValue) length] >0 ? NSValueToString(cellValue) : @"请选择" forState:UIControlStateNormal];
            if ([NSValueToString(cellValue) length] >0) {
                [self.rightChooseButton setTitleColor:[UIColor colorWithHexString:@"0X333333"] forState:UIControlStateNormal];
            } else
            {
                [self.rightChooseButton setTitleColor:[UIColor colorWithHexString:@"0X999999"] forState:UIControlStateNormal];
            }

        }
            break;
        case RecruitmentInfoCellTypeShowAllChooseView:
        {
            self.contentTextField.hidden = YES;
            self.leftChooseView.hidden = NO;
            self.leftChooseButton.userInteractionEnabled = YES;
            self.rightChooseButton.hidden = NO;
            self.rightChooseButton.userInteractionEnabled = YES;
            self.singleChooseView.hidden = YES;
            self.arrowImageView.hidden = NO;
            if ([NSValueToString(cellValue) length] >0) {
                [self.leftChooseButton setTitleColor:[UIColor colorWithHexString:@"0X333333"] forState:UIControlStateNormal];
            } else
            {
                [self.leftChooseButton setTitleColor:[UIColor colorWithHexString:@"0X999999"] forState:UIControlStateNormal];
            }
            if ([NSValueToString(cellSubValue) length] >0) {
                [self.rightChooseButton setTitleColor:[UIColor colorWithHexString:@"0X333333"] forState:UIControlStateNormal];
            } else
            {
                [self.rightChooseButton setTitleColor:[UIColor colorWithHexString:@"0X999999"] forState:UIControlStateNormal];
            }
            [self.leftChooseButton setTitle:[NSValueToString(cellValue) length] >0 ? NSValueToString(cellValue) : @"请选择" forState:UIControlStateNormal];
            [self.rightChooseButton setTitle:[NSValueToString(cellSubValue) length] >0 ? NSValueToString(cellSubValue) : @"请选择" forState:UIControlStateNormal];
            
        }
            break;
            
        default:
            break;
    }
}
@end
