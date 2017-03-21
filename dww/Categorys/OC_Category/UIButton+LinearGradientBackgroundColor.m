//
//  UIButton+LinearGradientBackgroundColor.m
//  dww
//
//  Created by Shadow. G on 2017/2/10.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "UIButton+LinearGradientBackgroundColor.h"

@interface UIButton ()

@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *endColor;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

@end
@implementation UIButton (LinearGradientBackgroundColor)

- (void)setStartColor:(UIColor *)startColor
{
    objc_setAssociatedObject(self, @selector(startColor), startColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)startColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEndColor:(UIColor *)endColor
{
    objc_setAssociatedObject(self, @selector(endColor), endColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)endColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setStartPoint:(CGPoint)startPoint
{
    objc_setAssociatedObject(self, @selector(startPoint), [NSValue valueWithCGPoint:startPoint], OBJC_ASSOCIATION_ASSIGN);
}

- (CGPoint)startPoint
{
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setEndPoint:(CGPoint)endPoint
{
    objc_setAssociatedObject(self, @selector(endPoint), [NSValue valueWithCGPoint:endPoint], OBJC_ASSOCIATION_ASSIGN);
}

- (CGPoint)endPoint
{
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setLinearGradientBackgroundColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    self.startColor = startColor;
    self.endColor = endColor;
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    [self setBackgroundImage:[self drawLinearGradientImageRect:self.bounds] forState:UIControlStateNormal];
    
}

- (UIImage *)drawLinearGradientImageRect:(CGRect)rect {
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CILinearGradient"];
    CIVector *vector0 = [CIVector vectorWithX:rect.size.width * self.startPoint.x Y:rect.size.height * (1 - self.startPoint.y)];
    CIVector *vector1 = [CIVector vectorWithX:rect.size.width * self.endPoint.x Y:rect.size.height * (1 - self.endPoint.y)];
    [ciFilter setValue:vector0 forKey:@"inputPoint0"];
    [ciFilter setValue:vector1 forKey:@"inputPoint1"];
    [ciFilter setValue:[CIColor colorWithCGColor:self.startColor.CGColor] forKey:@"inputColor0"];
    [ciFilter setValue:[CIColor colorWithCGColor:self.endColor.CGColor] forKey:@"inputColor1"];
    
    CIImage *ciImage = ciFilter.outputImage;
    CIContext *con = [CIContext contextWithOptions:nil];
    CGImageRef resultCGImage = [con createCGImage:ciImage fromRect:rect];
    
    UIImage *resultUIImage = [UIImage imageWithCGImage:resultCGImage];
    CGImageRelease(resultCGImage);
    
    return resultUIImage;
    
}

@end
