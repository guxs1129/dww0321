//
//  SWPopView.h
//  Zhaowaibao
//
//  Created by Shadow.G on 16/9/26.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWPopViewDelegate <NSObject>

- (void)selectIndexPathRow:(NSInteger )index;

@end

@interface SWPopView : UIView

// backGoundView
@property (nonatomic, strong) UIView  * _Nonnull backGoundView;
// titles
@property (nonatomic, strong) NSArray * _Nonnull dataArray;
// images
@property (nonatomic, strong) NSArray * _Nonnull images;
// height
@property (nonatomic, assign) CGFloat row_height;
// font
@property (nonatomic, assign) CGFloat fontSize;
// textColor
@property (nonatomic, strong) UIColor * _Nonnull titleTextColor;

// delegate
@property (nonatomic, assign) id<SWPopViewDelegate>_Nonnull delegate;

// 初始化方法
- (instancetype _Nonnull)initWithOrigin:(CGPoint)origin
                                  width:(CGFloat)width
                                 height:(CGFloat)height
                        backgroundColor:(UIColor * _Nonnull)backgroundColor
                            borderColor:(UIColor * _Nonnull)borderColor;
- (void)popView;
- (void)dismiss;
- (void)reloadData;

@end
