//
//  CompanyHotPositionTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/15.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyHotPositionTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *positionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (void)resetCellWithData:(NSDictionary *)data;

@end
