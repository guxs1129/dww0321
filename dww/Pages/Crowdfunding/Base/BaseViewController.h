//
//  BaseViewController.h
//  eService
//
//  Created by 顾新生 on 2016/12/19.
//  Copyright © 2016年 guxinsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)setupNavi;
-(void)setupSubviews;
-(void)pushVCWithClass:(Class)class;
@end
