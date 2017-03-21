//
//  PrivateSettingViewController.h
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface PrivateSettingViewController : JiaBaseViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *display; // 1 可见 0 不可见

@end
