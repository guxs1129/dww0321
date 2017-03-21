//
//  CustomPageControl.m
//  Haoye_lvpai
//
//  Created by wt on 15/4/9.
//  Copyright (c) 2015年 lianghuigui. All rights reserved.
//

#import "CustomPageControl.h"

@interface CustomPageControl ()

@property (nonatomic, retain) UIImage *normalImage;
@property (nonatomic, retain) UIImage *currentImage;

@end

@implementation CustomPageControl


- (id)initWithFrame:(CGRect)frame withNormalImage:(UIImage *)normalImage currentImage:(UIImage *)currentImage pageCount:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.normalImage = normalImage;
        self.currentImage = currentImage;
        self.pageCount = count;
        [self resetView];
        [self resetCurrentPageIndex:0];
    }
    return self;
}

- (void)resetView {

    self.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < self.pageCount; i++) {
        CGFloat imageViewWidth = 5;
        CGFloat imageViewHeight = 5;
        CGFloat itemSpace = 8;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - _pageCount * imageViewWidth - (_pageCount - 1) * itemSpace) / 2 + i * imageViewWidth + i * itemSpace, 0, imageViewWidth, imageViewHeight)];
        imageView.tag = 100 + i;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = imageView.frame.size.height / 2;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.backgroundColor = [UIColor redColor];
        imageView.image = self.normalImage;
        [self addSubview:imageView];
        
    }
}

- (void)resetCurrentPageIndex:(int)currentIndex {
    [self resetCurrentPageIndex:currentIndex currentColor:[UIColor colorWithHexString:@"0XFFA200"] normalColor:[UIColor whiteColor] currentBorderColor:[UIColor colorWithHexString:@"0XFFA200"] normalBorderColor:[UIColor whiteColor]];
}

- (void)resetCurrentPageIndex:(int)currentIndex currentColor:(UIColor *)currentColor normalColor:(UIColor *)normalColor currentBorderColor:(UIColor *)currentBorderColor normalBorderColor:(UIColor *)normalBorderColor
{
    self.currentIndex = currentIndex;
    for (UIImageView *imageView in self.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
//            imageView.layer.borderWidth = 0.5;
            if ((imageView.tag - 100) == currentIndex) {
                imageView.image = self.currentImage;
//                imageView.backgroundColor = currentColor;
//                imageView.layer.borderColor = currentBorderColor.CGColor;
            } else {
                imageView.image = self.normalImage;
//                imageView.backgroundColor = normalColor;
//                imageView.layer.borderColor = normalBorderColor.CGColor;
            }
        }
    }

}
@end
