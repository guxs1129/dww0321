//
//  UIButton+Common.m
//  东方赢家
//
//  按钮扩展
//  Created by dfzq on 16/7/5.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import "UIButton+Common.h"
#import "NSString+Additions.h"

@interface UIButton ()
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation UIButton (Common)

- (void)frameToFitTitle{
    CGRect frame = self.frame;
    CGFloat titleWidth = [self.titleLabel.text getWidthWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(kScreen_Width, frame.size.height)];
    frame.size.width = titleWidth;
    [self setFrame:frame];
}



#pragma mark -
#pragma mark UIActivityIndicatorView 提示
// 通过关联属性实现
static char EAActivityIndicatorKey;
- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator{
    objc_setAssociatedObject(self, &EAActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIActivityIndicatorView *)activityIndicator{
    return objc_getAssociatedObject(self, &EAActivityIndicatorKey);
}

- (void)startQueryAnimate{
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.hidesWhenStopped = YES;
        [self addSubview:self.activityIndicator];
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    [self.activityIndicator startAnimating];
    //self.enabled = NO;
}

- (void)stopQueryAnimate{
    [self.activityIndicator stopAnimating];
    //self.enabled = YES;
}

@end
