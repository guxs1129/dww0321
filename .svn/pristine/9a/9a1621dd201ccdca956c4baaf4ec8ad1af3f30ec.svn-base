//
//  UIView+Image.m
//  SOMSAPPForPad
//
//  Created by 顾新生 on 2016/12/12.
//  Copyright © 2016年 guxinsheng. All rights reserved.
//

#import "UIView+Image.h"

@implementation UIView (Image)
- (UIImage *)saveImageWithScale:(float)scale{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
