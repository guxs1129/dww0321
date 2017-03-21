//
//  JobPositionChooseCityViewController.h
//  dww
//
//  Created by Shadow. G on 2016/12/26.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "JiaBaseViewController.h"

typedef void(^completeChooseCity)(NSString *cityName, NSString *cityID);
@interface JobPositionChooseCityViewController : JiaBaseViewController
@property(nonatomic,assign)BOOL isorNotShowQuanGuo;//是否显示全国
-(void)setCompleteChooseCityBlock:(completeChooseCity)block;

@end
