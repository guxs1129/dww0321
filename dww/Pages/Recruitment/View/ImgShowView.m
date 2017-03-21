//
//  ImgShowView.m
//  canzhaopin
//
//  Created by lianghuigui on 16/3/28.
//  Copyright © 2016年 lianghuigui. All rights reserved.
//

#import "ImgShowView.h"
#import <UIImageView+WebCache.h>
@implementation ImgShowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        _iMgView = [[UIImageView alloc] init];
        _iMgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iMgView];
        
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];


    }
    
    return self;
}
-(void)loadImgView{
    
    [_iMgView sd_setImageWithURL:[NSURL URLWithString:_imgUrlStr] placeholderImage:[UIImage imageNamed:@"defaultShow"]];
    _iMgView.frame=self.bounds;//CGRectMake(0, 0, _iMgView.image.size.width, _iMgView.image.size.height);
    [self addSubview:_iMgView];
    
    CGFloat img_width = _iMgView.image.size.width;
    CGFloat scale = img_width > _iMgView.frame.size.width ? img_width/_iMgView.frame.size.width:1.0;
     self.maximumZoomScale=scale;
     //设置最小伸缩比例
     self.minimumZoomScale=1.0;
    self.contentSize=CGSizeMake(self.bounds.size.width, self.bounds.size.height);

    
}
-(void)handleDoubleTap:(UIGestureRecognizer *)tap{

    CGPoint touchPoint = [tap locationInView:self];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return _iMgView;
}

@end
