//
//  UIImage+Color.m
//  iSmartOffice
//
//  Created by 顾新生 on 16/3/25.
//  Copyright © 2016年 dumplingproject. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+(instancetype)imageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0, 0, kScreen_Width, 64);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return img;
}
@end
