//
//  PersonalJobPositionTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PersonalJobPositionCellType) {
    PersonalJobPositionCellTypeCollection,
    PersonalJobPositionCellTypeSending,
};

@interface PersonalJobPositionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@property (copy, nonatomic) void(^didClickLeftButtonBlock)(UIButton *leftButton);
@property (copy, nonatomic) void(^didClickRightButtonBlock)();
@property (assign, nonatomic) PersonalJobPositionCellType cellType;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UILabel *payLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *bottomLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomRightButton;

- (void)configCellWithData:(NSDictionary *)data;

@end
