//
//  UIImage+Thumb.m
//  iSmartOffice
//
//  Created by 顾新生 on 16/3/29.
//  Copyright © 2016年 dumplingproject. All rights reserved.
//

#import "UIImage+Thumb.h"

@implementation UIImage (Thumb)
+(UIImage *)createThumbFromImage:(UIImage *)largeImg size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [largeImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *thumb=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumb;
}

+(UIImage *)createScaleImage:(UIImage *)largeImg{
    CGSize originSize=largeImg.size;
    CGFloat ratio=originSize.width/originSize.height;//确定图像哪边最短
    CGFloat scale;
    if (ratio<1.0) {//宽最短
        scale=originSize.width/150;
    }else{//长最短
        scale=originSize.height/150;
    }
    CGSize newSize=CGSizeMake(originSize.width/scale, originSize.height/scale);
    
    return [self createThumbFromImage:largeImg size:newSize];
    
}

@end
