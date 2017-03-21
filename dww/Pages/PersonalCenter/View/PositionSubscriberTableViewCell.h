//
//  PositionSubscriberTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PositionSubscriberModel.h"

@interface PositionSubscriberTableViewCell : UITableViewCell

@property (strong, nonatomic) PositionSubscriberModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *starImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *leftChooseView;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIButton *leftChooseButton;
@property (strong, nonatomic) IBOutlet UIButton *rightChooseButton;
@property (copy, nonatomic) void(^didClickedLeftChooseButtonBlock)();
@property (copy, nonatomic) void(^didClickedRightChooseButtonBlock)();

@end
