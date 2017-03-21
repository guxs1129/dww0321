//
//  UIWebView+ChangeBaseStringAttributes.m
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "UIWebView+ChangeBaseStringAttributes.h"

@implementation UIWebView (ChangeBaseStringAttributes)

- (NSString *)changeBaseStringAttributesWithHtmlString:(NSString *)htmlString fontSize:(CGFloat)fontSize textColorStr:(NSString *)colorString
{
    if (!htmlString || [htmlString isKindOfClass:[NSNull class]]) {
        return @"";
    }
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    NSString *htmlFormat = [NSString stringWithFormat:@"<!DOCTYPE html> <html lang=\"cn\"> <head> <meta charset=\"utf-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\"> <style>body,div,p,span,font,a{font-size:%fpx;color:%@;}img{max-width: %@; width:auto; height:auto;}</style> </head> <body> %@ </body> </html>", fontSize, colorString, @"100%", htmlString];

    return htmlFormat;
}

@end
