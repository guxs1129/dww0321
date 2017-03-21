//
//  HXAdvantismentView.h
//  Haoye_lvpai
//
//  Created by 高蒙 on 15/12/2.
//  Copyright © 2015年 Clyde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"

@class HXAdvantismentView;
@protocol HXAdvantismentViewDelegate <NSObject>

// 点击轮播图当前图片执行
- (void)didClickPage:(HXAdvantismentView *)view atIndex:(NSInteger)index;

@end
@interface HXAdvantismentView : UIView

/** 当前页数*/
@property (assign, nonatomic) NSInteger currentPage;
/** 图片 url 数组*/
@property (strong, nonatomic) NSMutableArray *imagesUrlArray;
/** 图片数组*/
@property (strong, nonatomic) NSMutableArray *imageArray;
/** 滚动视图*/
@property (strong, nonatomic, readonly) UIScrollView *scrollView;
/** 页数控制器*/
@property(nonatomic,strong) CustomPageControl *pageControl;
// 定时器
@property (strong, nonatomic) NSTimer *autoScrollTimer;
/** 定时器秒数*/
@property (assign, nonatomic) NSInteger timeInteval;
/** 代理*/
@property (assign, nonatomic) id<HXAdvantismentViewDelegate> delegate;
/** 是否开启自动轮播*/
@property (assign, nonatomic) BOOL isAutoScroll;
/** 是否第一次进入*/
@property (assign, nonatomic) BOOL isFirst;

@end
