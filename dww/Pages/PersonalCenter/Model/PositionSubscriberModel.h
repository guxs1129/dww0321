//
//  PositionSubscriberModel.h
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PositionSubscriberModel : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *subValue;
@property (nonatomic, getter=isRequired) BOOL required;
@property (nonatomic, getter=isNeedShowLeftChooseView) BOOL needShowLeftChooseView;

@end
