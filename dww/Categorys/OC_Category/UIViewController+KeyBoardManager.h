//
//  UIViewController+KeyBoardManager.h
//  Zhaowaibao
//
//  Created by Shadow.G on 16/8/31.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KeyBoardManager)

-(void)setupForKeyboardWithScrolledView:(UIScrollView *)view clickedView:(UIView *)clickedView;
-(void)uploadKeyBoardManager;

@end
