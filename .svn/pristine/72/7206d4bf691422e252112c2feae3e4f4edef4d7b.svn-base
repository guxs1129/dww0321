//
//  JiaBaseViewController.h
//  dww
//
//  Created by Shadow.G on 16/12/23.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MP.h"
#import "RealReachability.h"

@protocol BaseViewControllerDataSource <NSObject>

@optional

-(NSMutableAttributedString *)setTitle;
-(UIButton *)set_leftButton;
-(UIButton *)set_rightButton;
-(UIColor *)set_colorBackground;
-(CGFloat)set_navigationHeight;
-(UIView *)set_bottomView;
-(UIImage *)navBackgroundImage;
-(BOOL)hideNavigationBottomLine;
-(UIImage *)set_leftBarButtonItemWithImage;
-(UIImage *)set_rightBarButtonItemWithImage;

@end

@protocol BaseViewControllerDelegate <NSObject>

@optional

-(void)left_button_event:(UIButton *)sender;
-(void)right_button_event:(UIButton *)sender;
-(void)title_click_event:(UIView *)sender;

@end

@interface JiaBaseViewController : UIViewController<BaseViewControllerDataSource, BaseViewControllerDelegate>
@property (assign, nonatomic) NSInteger netWorkStatus;
@property (assign, nonatomic) BOOL isDarkBackButton;
@property (assign, nonatomic) BOOL isRootVC;
// 设置NavigationBar的Y轴
-(void)changeNavigationBarTranslationY:(CGFloat)translationY;
// 设置标题
-(void)set_Title:(NSMutableAttributedString *)title;

BOOL validInfo(NSString *str);
NSString *trimming(NSString *str);

@end
