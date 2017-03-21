//
//  JobPositionTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2016/12/29.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobPositionTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *positionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (void)resetCellWithData:(NSDictionary *)data;

@end
