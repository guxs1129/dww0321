//
//  SystemMessageModel.h
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SystemMessageModel : JSONModel

@property (nonatomic, getter=isShowDetail) BOOL showDetail;
@property (nonatomic, getter=isShowRedRoundView) BOOL showRedRoundView;
@property (nonatomic, strong) NSString *title;

@end
