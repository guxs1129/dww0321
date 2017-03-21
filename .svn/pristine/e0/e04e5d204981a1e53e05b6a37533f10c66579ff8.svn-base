//
//  JobPositionSearchViewController.h
//  dww
//
//  Created by Shadow. G on 2016/12/29.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "PYSearchViewController.h"

#define kSearchTypeAllwords @"keyword_contents" // 全文
#define kSearchTypePosition @"keyword"   // 职位
#define kSearchTypeCompany @"keyword_company"  // 公司
@interface JobPositionSearchViewController : PYSearchViewController

 // 用于数据回显
@property (nonatomic, strong) NSString *industryID;
@property (nonatomic, strong) NSString *jobPositionIDs;
@property (nonatomic, strong) NSString *jobFirstPositionIDs;
@property (nonatomic, strong) NSString *jobIndustryName;
@property (nonatomic, strong) NSString *jobPositionName;

@property (strong, nonatomic) IBOutlet UIView *chooseIndustryView;
@property (strong, nonatomic) IBOutlet UIView *chooseJobPositionView;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic) NSMutableDictionary *exparams; // 选中的行业和职能ID
@property (copy, nonatomic) void(^completeBlock)(NSDictionary *params, NSString *industryID, NSString *firstPositionIDs, NSString * secondPositionIDs, NSString *jobIndustryName , NSString *jobPositionName);
@property (strong, nonatomic) NSString *searchType; // 默认全文

+ (JobPositionSearchViewController *)searchViewControllerWithHotSearches:(NSArray<NSString *> *)hotSearches searchBarPlaceholder:(NSString *)placeholder didSearchBlock:(PYDidSearchBlock)block;

@end
