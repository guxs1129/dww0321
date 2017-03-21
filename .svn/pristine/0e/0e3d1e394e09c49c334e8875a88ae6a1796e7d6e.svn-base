//
//  RecruitmentInfoTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/4.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecruitmentInfoCellModel.h"

@interface RecruitmentInfoTableViewCell : UITableViewCell

@property (strong, nonatomic) RecruitmentInfoCellModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *starImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *separatorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *starImageViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *starImageViewRightInset;
@property (strong, nonatomic) IBOutlet UIButton *rightChooseButton;
@property (strong, nonatomic) IBOutlet UIView *leftChooseView;
@property (strong, nonatomic) IBOutlet UIButton *leftChooseButton;
@property (strong, nonatomic) IBOutlet UITextField *contentTextField;
@property (strong, nonatomic) IBOutlet UIView *singleChooseView;
@property (strong, nonatomic) IBOutlet UIButton *singleLeftChooseBtn;
@property (strong, nonatomic) IBOutlet UIButton *singleRightChooseBtn;

@property (copy, nonatomic) void(^(didClickRightChooseButtonBlock))();
@property (copy, nonatomic) void(^(didClickLeftChooseButtonBlock))();
@property (copy, nonatomic) void(^(didClickSingleRightChooseButtonBlock))();
@property (copy, nonatomic) void(^(didClickSingleLeftChooseButtonBlock))();

@end
