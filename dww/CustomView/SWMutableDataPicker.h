//
//  SWMutableDataPicker.h
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWMutableDataPicker : UIView

/**
 * 获取第二列数据列表的key
 */
@property (nonatomic, strong) NSString *secondComponentDataSourceKey;
/**
 * 获取第三列数据列表的key
 */
@property (nonatomic, strong) NSString *thirdComponentDataSourceKey;

/**
 * 获取第一列每行数据的key
 */
@property (nonatomic, strong) NSString *rowValueInFirstComponentKey;
/**
 * 获取第二列每行数据的key
 */
@property (nonatomic, strong) NSString *rowValueInSecondComponentKey;
/**
 * 获取第三列每行数据的key
 */
@property (nonatomic, strong) NSString *rowValueInThirdComponentKey;

@property (nonatomic,copy) void (^completion)(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent);


- (void)showPickerWithDataSource:(NSArray *)dataSource firstComponentSelectedValue:(NSString *)firstValue secondComponentSelectedValue:(NSString *)secondValue thirdComponentSelectedValue:(NSString *)thirdValue;

@end
