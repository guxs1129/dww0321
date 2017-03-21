//
//  RecruitmentInfoCellModel.h
//  dww
//
//  Created by Shadow. G on 2017/1/4.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RecruitmentInfoCellType) {
    RecruitmentInfoCellTypeShowRightChooseView,
    RecruitmentInfoCellTypeShowAllChooseView,
    RecruitmentInfoCellTypeTextField,
    RecruitmentInfoCellTypeSingleChoose
};
@interface RecruitmentInfoCellModel : NSObject

@property (nonatomic) RecruitmentInfoCellType cellType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *subValue;
@property (nonatomic, getter=isRequired) BOOL required;
@property (nonatomic, strong) NSString *singleChooseLeftButtonTitle;
@property (nonatomic, strong) NSString *singleChooseRightButtonTitle;

@end
