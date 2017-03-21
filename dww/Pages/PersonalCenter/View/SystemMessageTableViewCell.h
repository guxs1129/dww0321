//
//  SystemMessageTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWSystemMessageModel.h"

@interface SystemMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) DWSystemMessageModel *model;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *redRoundView;
@property (strong, nonatomic) IBOutlet UIImageView *downArrowView;
@property (strong, nonatomic) IBOutlet UIView *contentBackgroundView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentBackgroundViewHeight;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
