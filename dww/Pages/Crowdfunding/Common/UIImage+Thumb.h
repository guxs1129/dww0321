//
//  UIImage+Thumb.h
//  iSmartOffice
//
//  Created by 顾新生 on 16/3/29.
//  Copyright © 2016年 dumplingproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Thumb)
+(UIImage *)createThumbFromImage:(UIImage *)largeImg size:(CGSize)size;
+(UIImage *)createScaleImage:(UIImage *)largeImg;
@end
