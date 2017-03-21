//
//  DWHomeCompanyTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/15.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWHomeCompanyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *companyIntroduceLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobPositionCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *companyAvatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;


- (void)resetCellWithData:(NSDictionary *)data;

@end
