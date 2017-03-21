//
//  UIWebView+ChangeBaseStringAttributes.h
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (ChangeBaseStringAttributes)

/**
 * 改变内容外联初始字体属性
 * textColor example "#666666"
 **/
- (NSString *)changeBaseStringAttributesWithHtmlString:(NSString *)htmlString fontSize:(CGFloat)fontSize textColorStr:(NSString *)colorString;

@end
