//
//  Page2HeaderView.m
//  dww
//
//  Created by 顾新生 on 2017/3/21.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "Page2HeaderView.h"
@interface Page2HeaderView()<HXAdvantismentViewDelegate>

@end
@implementation Page2HeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews{
    self.advanceView = [[HXAdvantismentView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, ScreenSizeWidth * 100 / 320)];
    self.advanceView.delegate = self;
    self.advanceView.timeInteval = 4.0f;
    self.advanceView.isAutoScroll = YES;
    [self addSubview:self.advanceView];
    self.advanceView.imagesUrlArray = @[@"banner_default"].mutableCopy;
    
    self.backgroundColor=[UIColor redColor];
}

#pragma mark --- HXAdvantismentViewDelegate ---
    // 点击轮播图当前图片执行
- (void)didClickPage:(HXAdvantismentView *)view atIndex:(NSInteger)index
{
    NSLog(@"index:%ld", (long)index);
    
}

@end
