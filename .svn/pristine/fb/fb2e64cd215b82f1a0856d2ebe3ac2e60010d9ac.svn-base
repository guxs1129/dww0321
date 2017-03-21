//
//  SWIndexView.h
//  dww
//
//  Created by Shadow. G on 2016/12/27.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

// 字体变化率
#define FONT_RATE 1/8.000
// 透明度变化率
#define ALPHA_RATE 1/80.0000
// 初始状态索引颜色
#define STR_COLOR [[UIColor blackColor] colorWithAlphaComponent:0.8]
// 选中状态索引颜色
#define MARK_COLOR [UIColor blackColor]
// 初始状态索引大小
#define FONT_SIZE [UIFont systemFontOfSize:10]
// 索引label的tag值(防止冲突)
#define ITEMTAG 233333
// 圆的半径
#define ANIMATION_HEIGHT 80

typedef void(^SelectedIndexBlock)(NSInteger section, NSString *title);

@interface SWIndexView : UIView

// 动画视图（可自定义）
@property (nonatomic, strong) UILabel *animationLabel;
// 索引数组
@property (nonatomic, strong) NSArray *indexArray;
// 滑动回调block
@property (nonatomic, copy) SelectedIndexBlock selectedBlock;


/**
 * 正常状态下索引的颜色
 */
@property (nonatomic, strong) UIColor *normalColor;
/**
 * 选中状态下索引的颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;
/**
 *  index滑动反馈
 */
-(void)selectIndexBlock:(SelectedIndexBlock)block;

/**
 *  初始化
 */
- (instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray<NSString *> *)array;

@end
