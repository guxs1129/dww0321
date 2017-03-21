//
//  PrivateSettingTableViewCell.h
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivateSettingTableViewCell : UITableViewCell

@property (strong, nonatomic) void(^didClickRightButtonBlock)();
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

@end
