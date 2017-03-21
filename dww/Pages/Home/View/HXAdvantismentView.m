//
//  HXAdvantismentView.m
//  Haoye_lvpai
//
//  Created by 高蒙 on 15/12/2.
//  Copyright © 2015年 Clyde. All rights reserved.
//
#define kViewWidth self.bounds.size.width
#define kViewHeight self.bounds.size.height


#import "HXAdvantismentView.h"
#import "UIImageView+WebCache.h"
//#import "UIView+AnimateIn.h"

@interface HXAdvantismentView ()<UIScrollViewDelegate>

// 前一张图片的view
@property (strong, nonatomic) UIView *firstView;
// 当前图片的view
@property (strong, nonatomic) UIView *middleView;
// 后一张图片的view
@property (strong, nonatomic) UIView *lastView;
// 点击手势
@property (strong, nonatomic) UITapGestureRecognizer *tap;


// 是否滚动
@property (assign, nonatomic) BOOL isDragging;


@end
@implementation HXAdvantismentView

- (void)dealloc
{
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpLayout];
    }
    return self;
}

- (void)setUpLayout
{
    // 默认定时器秒数
    self.timeInteval = 2;
    self.scrollView.backgroundColor = [UIColor blackColor];
    // 设置scrollView的属性
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kViewWidth * 3, kViewHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.pagingEnabled = YES;
//    _scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollView];
    
    
    
    // 设置轻拍手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    _tap.numberOfTapsRequired = 1;
    _tap.numberOfTouchesRequired = 1;
    [_scrollView addGestureRecognizer:_tap];
}


- (void)startTimer
{
     _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:_timeInteval target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
}


- (void)handleTap
{
    if ([self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [self.delegate didClickPage:self atIndex:_currentPage];
    }
}


//- (void)setImageArray:(NSMutableArray *)imageArray
//{
//    if (imageArray) {
//        _imageArray = imageArray;
//        _currentPage = 0;
//
//    }
//    [self reloadData];
//}

- (void)setImagesUrlArray:(NSMutableArray *)imagesUrlArray
{
    if (imagesUrlArray && imagesUrlArray.count > 0) {
        _imagesUrlArray = imagesUrlArray;
        _currentPage = 0;
//        NSMutableArray *imagesArray = [NSMutableArray array];
//        for (int i=0; i<[_imagesUrlArray count]; i++) {
        
//            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
//            imageView.contentMode=UIViewContentModeScaleAspectFill;
//            //        imageVC.contentMode=UIViewContentModeScaleToFill;
//            imageView.clipsToBounds = YES;
//            imageView.tag=1000+i;
            //        imageVC.image=[UIImage imageNamed:@"banner"];
//            __weak typeof(imageView)weakImageView = imageView;
//            [imageView setImageWithURL:[NSURL URLWithString:[imagesUrlArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"default_img"] options:SDWebImageRetryFailed|SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                if (!image && error) {
//                    weakImageView.image = [UIImage imageNamed:@"image_error"];
//                }
//            }];
//            [imagesArray addObject:imageView];
        
        
//        }
//        _imageArray = imagesArray;
        
        if (!_firstView) {
            _firstView = [self createImageView];
        }
        if (!_middleView) {
            _middleView = [self createImageView];
        }
        if (!_lastView) {
            _lastView = [self createImageView];
        }
        
        [self reloadData];
        // 手动滑动时暂停定时器
        if (self.isAutoScroll == YES) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
            [self startTimer];

        }
        
    }
}

- (UIImageView *)createImageView
{
    UIImageView *tmpView = [[UIImageView alloc] init];
    tmpView.contentMode = UIViewContentModeScaleAspectFill;
    tmpView.clipsToBounds = YES;
    return tmpView;
}

- (CustomPageControl *)pageControl
{
    if (!_pageControl && _imagesUrlArray.count > 0) {
        // 设置pageControl的属性
        //    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kViewHeight - 30, kViewWidth, 30)];
        _pageControl = [[CustomPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20, ScreenSizeWidth, 20) withNormalImage:[UIImage imageWithColor:[UIColor lightGrayColor]] currentImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0XFFA200"]] pageCount:(int)_imagesUrlArray.count];
        _pageControl.backgroundColor = [UIColor clearColor];
        //    _pageControl.userInteractionEnabled = NO;
        //    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        //    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];

    }
    return _pageControl;
}

- (void)imageView:(UIImageView *)imageView configImageWithIndex:(NSString *)url
{
    __weak typeof(imageView)weakImageView = imageView;
    if ([url hasPrefix:@"http"]) {
        [imageView setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"common_blankView"] options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (!image && error) {
                //            weakImageView.image = [UIImage imageNamed:@"image_error"];
            }
            
        }];
    } else
    {
        imageView.image = [UIImage imageNamed:url];
    }
    
    
}



- (void)reloadData
{
    // 先移除之前的视图
    [_firstView removeFromSuperview];
    [_middleView removeFromSuperview];
    [_lastView removeFromSuperview];
    [_pageControl removeFromSuperview];
    
    if (self.imagesUrlArray.count == 1) {
        self.scrollView.scrollEnabled = NO;
        [self imageView:(UIImageView *)_firstView configImageWithIndex:_imagesUrlArray.lastObject];
        [self imageView:(UIImageView *)_middleView configImageWithIndex:_imagesUrlArray.lastObject];
        [self imageView:(UIImageView *)_lastView configImageWithIndex:_imagesUrlArray.lastObject];

    } else
    {
        // 判断当前页是不是第一页
        if (_currentPage == 0) {
            //        _firstView = [_imageArray lastObject];
            //        _middleView = [_imageArray objectAtIndex:_currentPage];
            //        _lastView = [_imageArray objectAtIndex:_currentPage + 1];
            [self imageView:(UIImageView *)_firstView configImageWithIndex:_imagesUrlArray.lastObject];
            [self imageView:(UIImageView *)_middleView configImageWithIndex:[_imagesUrlArray objectAtIndex:_currentPage]];
            [self imageView:(UIImageView *)_lastView configImageWithIndex:[_imagesUrlArray objectAtIndex:_currentPage + 1]];
            
        }
        // 判断当前页是不是最后一页
        else if (_currentPage == _imagesUrlArray.count - 1)
        {
            //        _firstView = [_imageArray objectAtIndex:_currentPage - 1];
            //        _middleView = [_imageArray objectAtIndex:_currentPage];
            //        _lastView = [_imageArray firstObject];
            
            [self imageView:(UIImageView *)_firstView configImageWithIndex:[_imagesUrlArray objectAtIndex:_currentPage - 1 ]];
            [self imageView:(UIImageView *)_middleView configImageWithIndex:[_imagesUrlArray objectAtIndex:_currentPage]];
            [self imageView:(UIImageView *)_lastView configImageWithIndex:[_imagesUrlArray firstObject]];
        }
        else
        {
            //        _firstView = [_imageArray objectAtIndex:_currentPage - 1];
            //        _middleView = [_imageArray objectAtIndex:_currentPage];
            //        _lastView = [_imageArray objectAtIndex:_currentPage + 1];
            
            [self imageView:(UIImageView *)_firstView configImageWithIndex:[_imagesUrlArray objectAtIndex:_currentPage - 1 ]];
            [self imageView:(UIImageView *)_middleView configImageWithIndex:[_imagesUrlArray objectAtIndex:_currentPage]];
            [self imageView:(UIImageView *)_lastView configImageWithIndex:[_imagesUrlArray objectAtIndex:_currentPage + 1]];
            
        }

    }
    
    // 设置三个view的frame,加到scrollview上
    _firstView.frame = CGRectMake(0, 0, kViewWidth, kViewHeight);
    _middleView.frame = CGRectMake(kViewWidth, 0, kViewWidth, kViewHeight);
    _lastView.frame = CGRectMake(kViewWidth * 2, 0, kViewWidth, kViewHeight);
    
    [_scrollView addSubview:_firstView];
    [_scrollView addSubview:_middleView];
    [_scrollView addSubview:_lastView];
    [self addSubview:self.pageControl];
    
    // 设置当前的分页
    [_pageControl resetCurrentPageIndex:(int)_currentPage];
    
    // 获取前一张的背景,设置_scrollview的背景颜色
    UIImageView *currentView = (UIImageView *)self.imageArray[_currentPage];
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:currentView.image];
    
    // 第一次进入,不需要切换的动画,直接设置默认的为currentPage的image
    if (_isFirst) {
        if (!self.isDragging) {
            _scrollView.contentOffset = CGPointMake(0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(kViewWidth, 0);
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            _scrollView.contentOffset = CGPointMake(kViewWidth, 0);
            self.isDragging = NO;
        }
    }else {
        _scrollView.contentOffset = CGPointMake(kViewWidth, 0);
        self.isDragging = NO;
        _isFirst = YES;
    }
    
}


- (void)setTimeInteval:(NSInteger)timeInteval
{
    if (timeInteval) {
         _timeInteval = timeInteval;
    }
   
}


#pragma mark  UIScrollViewDelegate

// scrollview 停止滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (self.isAutoScroll == YES) {
        // 手动滑动时暂停定时器
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
        [self startTimer];
    }
    // 得到当前页数
    float x = _scrollView.contentOffset.x / kViewWidth;
    
    // 往前翻
    if (x <= 0) {
        if (_currentPage - 1 < 0) {
            if (_imagesUrlArray.count > 0) {
                _currentPage = _imagesUrlArray.count - 1;
            } else
            {
                _currentPage = 0;
            }
        } else {
            _currentPage --;
        }
    }
    
    // 往后翻
    if (x >= 2) {
        if (_currentPage == _imagesUrlArray.count - 1) {
            _currentPage = 0;
        } else {
            _currentPage ++;
        }
    }
    
    self.isDragging = YES;
    [self reloadData];
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll
{
    _isAutoScroll = isAutoScroll;
    
    if (isAutoScroll) {
        if (!_autoScrollTimer) {
            [self startTimer];
        }
    } else {
        if (_autoScrollTimer.isValid) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
    }
}

#pragma mark 展示下一页
- (void)autoShowNextImage
{
    // 判断当前是否是最后一页
    if (_currentPage == _imagesUrlArray.count - 1) {
        _currentPage = 0;
    }else {
        _currentPage ++;
    }
    
    [self reloadData];
}


@end
