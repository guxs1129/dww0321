//
//  BaseWebView.h
//  10000care
//
//  Created by Shadow.G on 16/3/24.
//  Copyright © 2016年 haoxi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^webViewDidFinishLoadAction)(UIWebView *);

@interface BaseWebView : UIWebView

@property (nonatomic, copy) webViewDidFinishLoadAction finishLoadAction;

- (void)loadRequestWithUrlOrContentString:(NSString *)request;

@end
