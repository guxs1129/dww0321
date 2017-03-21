//
//  SystemMessageModel.h
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DWSystemMessageModel : JSONModel

@property (nonatomic, getter=isShowDetail) BOOL showDetail;
@property (nonatomic, getter=isShowRedRoundView) BOOL showRedRoundView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *date;

@end
