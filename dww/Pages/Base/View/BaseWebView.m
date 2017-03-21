//
//  BaseWebView.m
//  10000care
//
//  Created by Shadow.G on 16/3/24.
//  Copyright © 2016年 haoxi. All rights reserved.
//

#import "BaseWebView.h"
#import "regex.h"

@interface BaseWebView ()<UIWebViewDelegate>

@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, strong) NSString *webContent;
@property (nonatomic)  BOOL isLoadingFinished;

@end
@implementation BaseWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.delegate = self;
//    self.userInteractionEnabled = NO;
    self.scrollView.scrollEnabled = NO;
    self.dataDetectorTypes = UIDataDetectorTypeLink;
//    self.scalesPageToFit = YES;
 
    //这里一定要设置为NO
    [self setScalesPageToFit:NO];
    
    
    //第一次加载先隐藏webview
    [self setHidden:YES];
    
//    self.delegate = self;
    return self;
}

- (void)loadRequestWithUrlOrContentString:(NSString *)request
{
    if ([self isWebSite:request]) {
        self.requestUrl = request;
        NSURL * url=[NSURL URLWithString:request];
        NSURLRequest * rquest=[NSURLRequest requestWithURL:url];
        [self loadRequest:rquest];
       
    } else
    {
        
        
        request = [request stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        
        request = [request stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        request = [request stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
//        request = [request stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
//        NSString *htmlFormat = @"<!DOCTYPE html> <html lang=\"cn\"> <head> <meta charset=\"utf-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\" initial-scale=1, maximum-scale=1, user-scalable=no\"> </head> <body> %@ </body> </html>";
//        NSString *meta = [NSString stringWithFormat:@"<head><meta name=\"viewport\" content=\" initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"></head>"];
//        NSString *htmlContent = [NSString stringWithFormat:htmlFormat,request];
        NSString *htmlContent = request;
        self.webContent = htmlContent;
        [self loadHTMLString:[NSString stringWithFormat:@"%@", htmlContent] baseURL:nil];
        
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    [self resetWebViewFrame];
}

- (void)resetWebViewFrame
{
    CGRect frame = self.frame;
    //
    //    if (self.requestUrl) {
    NSString *fitHeight = [self stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    NSString *fitWidth = [self stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"];
    
    //            frame.size.height = [fitHeight floatValue] *  frame.size.width / [fitWidth floatValue];
    //    } else
    //    {
    //    NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"];
    //        NSString *fitWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.clientWidth"];
    //        frame.size.height = [fitHeight floatValue];
    
    
    //    }
    
    
    frame.size.height = MIN(self.scrollView.subviews.firstObject.frame.size.height, [fitHeight floatValue] *  frame.size.width / [fitWidth floatValue]);
   
    self.frame = frame;
    if (_finishLoadAction) {
        _finishLoadAction(self);
    }
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
//    [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
 
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
//        NSURL *url = [request URL];
//        if([[UIApplication sharedApplication]canOpenURL:url])
//        {
//            [[UIApplication sharedApplication]openURL:url];
//        }
//        return NO;
        if ([self isSpecialfileWithFileType:[[request URL] pathExtension]]) {
            [[UIApplication sharedApplication] openURL:request.URL];
            return NO;
        }
        else if ([[[request URL] scheme] isEqualToString:@"mailto"])
        {
            [[UIApplication sharedApplication] openURL:request.URL];
            return NO;
        }
        
    }
    return YES;
}

- (BOOL)isSpecialfileWithFileType:(NSString *)fileType
{
    if ([fileType isEqualToString:@"doc"]) {
        return YES;
    }
    else if ([fileType isEqualToString:@"pdf"])
    {
        return YES;
    }
    else if ([fileType isEqualToString:@"docx"])
    {
        return YES;
    }
    else if ([fileType isEqualToString:@"wps"])
    {
        return YES;
    }
    else if ([fileType isEqualToString:@"xls"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//  
//    [MBProgressHUD hideAllHUDsForView:KEYWINDOW animated:YES];
//    
//    CGRect frame = webView.frame;
////    
////    if (self.requestUrl) {
////        NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
////        NSString *fitWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"];
////
////        frame.size.height = [fitHeight floatValue] * [fitWidth floatValue] / frame.size.width;
////    } else
////    {
//        NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"];
////        NSString *fitWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.clientWidth"];
////        frame.size.height = [fitHeight floatValue];
//
//
////    }
//  
//   
//    frame.size.height = MIN(self.scrollView.subviews.firstObject.frame.size.height, [fitHeight floatValue]);
//    frame.size.width = ScreenSizeWidth;
//  
//    webView.frame = frame;
//    //修改服务器页面的meta的值
////    NSString *meta = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\" initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"></head>"];
////    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \" initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\""];
//        //js获取body宽度
////        NSString *bodyWidth= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth "];
////    
////        int widthOfBody = [bodyWidth intValue];
////    
////    //计算要缩放的比例
////    CGFloat initialScale = self.frame.size.width/widthOfBody;
////    //将</head>替换为meta+head
////    NSString *stringForReplace = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content =\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\"></head>",initialScale];
////    [webView stringByEvaluatingJavaScriptFromString:stringForReplace];
//    
////    webView.scrollView.scrollEnabled = NO;
//    if (_finishLoadAction) {
//        _finishLoadAction(self);
//    }
//    
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    //修改服务器页面的meta的值
//    NSString *meta = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\" initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"></head>"];
//    [webView stringByEvaluatingJavaScriptFromString:meta];
    [self resetWebViewFrame];
    webView.scrollView.scrollEnabled = NO;
    if (_finishLoadAction) {
        _finishLoadAction(self);
    }

    //若已经加载完成，则显示webView并return
    if (_isLoadingFinished) {
        
//    [MBProgressHUD hideAllHUDsForView:self.superview animated:YES];
    [self setHidden:NO];
 
    return;
    }

    
    //js获取body宽度
    NSString *bodyWidth= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth"];
    
    int widthOfBody = [bodyWidth intValue];
    
    //获取实际要显示的html
    NSString *html = [self htmlAdjustWithPageWidth:widthOfBody
                                              html:self.webContent
                                           webView:webView];
    
    //设置为已经加载完成
    _isLoadingFinished = YES;
    //加载实际要现实的html
    [self loadRequestWithUrlOrContentString:html];
}

//获取宽度已经适配于webView的html。这里的原始html也可以通过js从webView里获取
- (NSString *)htmlAdjustWithPageWidth:(CGFloat )pageWidth
                                 html:(NSString *)html
                              webView:(UIWebView *)webView
{
    NSMutableString *str = [NSMutableString stringWithString:html];
    //计算要缩放的比例
    CGFloat initialScale = webView.frame.size.width/pageWidth;
    //将</head>替换为meta+head
    NSString *stringForReplace = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=no\"></head>",initialScale];
    
    NSRange range =  NSMakeRange(0, str.length);
    //替换
    [str replaceOccurrencesOfString:@"</head>" withString:stringForReplace options:NSLiteralSearch range:range];
    return str;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [MBProgressHUD showError:@"加载失败" toView:KEYWINDOW];
//    [MBProgressHUD hideAllHUDsForView:self.superview animated:YES];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview) {
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        
    } else {
         [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    }
}
- (void)dealloc
{
   
}

- (BOOL)isWebSite:(NSString *)str
{
    return [[self class] regExpMatch:@"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+" stringReg:str];
}

+ (BOOL)regExpMatch:(NSString*)pattern stringReg:(NSString*)str
{
    if(!str)
    {
        return NO;
    }
    regex_t reg;
    regmatch_t sub[10];
    int status = regcomp(&reg, [pattern UTF8String], REG_EXTENDED);
    if( status )
        return NO;
    
    status=regexec( &reg, [str UTF8String], 10, sub, 0);
    
    regfree(&reg);
    
    if( status == REG_NOMATCH)
        return NO;
    else if( status )
        return NO;
    
    return YES;
}



@end
