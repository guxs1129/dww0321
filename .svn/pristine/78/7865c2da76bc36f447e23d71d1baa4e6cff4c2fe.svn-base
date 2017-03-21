//
//  UIViewController+KeyBoardManager.m
//  Zhaowaibao
//
//  Created by Shadow.G on 16/8/31.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "UIViewController+KeyBoardManager.h"
#import <objc/runtime.h>

CGFloat clickedViewMinY;
CGFloat clickViewHeight;

@interface UIViewController ()

@property (nonatomic, strong) NSMutableArray *observers;

@end

@implementation UIViewController (KeyBoardManager)


- (void)setObservers:(NSMutableArray *)observers
{
    objc_setAssociatedObject(self, @selector(observers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)observers
{
    return objc_getAssociatedObject(self, @selector(observers));
}

// 计算需要滑动的高度
- (CGFloat)getNeedScrolledHeightWithClickedView:(UIView *)clickedView scrolledView:(UIScrollView *)scrolledView keyboardHeight:(CGFloat)keyboardHeight
{
    if (clickedView.superview == scrolledView) {
        CGFloat spaceHeight = scrolledView
        .frame.size.height + scrolledView.contentOffset.y - (clickedViewMinY + clickViewHeight);
        
        return spaceHeight < keyboardHeight ? (keyboardHeight - spaceHeight) : 0;
    } else
    {
        if (![clickedView.superview isKindOfClass:[UIView class]]) {
            return 0;
        }
        clickedViewMinY += clickedView.superview.frame.origin.y;
       return [self getNeedScrolledHeightWithClickedView:clickedView.superview scrolledView:scrolledView keyboardHeight:keyboardHeight];
    }
}

- (void)setupForKeyboardWithScrolledView:(UIScrollView *)view clickedView:(UIView *)clickedView
{
    [self uploadKeyBoardManager];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    if (!self.observers) {
        self.observers = [NSMutableArray arrayWithCapacity:1];
    }
    
    __weak UIViewController *weakSelf = self;
    __weak UIScrollView *weakView = view;

    CGPoint weakViewContentOffset = weakView.contentOffset;
    __block CGFloat keyboardHeight = 0;
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    
    id keyboardShowObserver = [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *noti){
                    [self.view addGestureRecognizer:singleTapGR];
                    if ([[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height > keyboardHeight) {
                        keyboardHeight = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
                        clickedViewMinY = clickedView.frame.origin.y;
                        clickViewHeight = clickedView.frame.size.height;
                        [weakView setContentOffset:CGPointMake(weakViewContentOffset.x, weakViewContentOffset.y + [self getNeedScrolledHeightWithClickedView:clickedView scrolledView:view keyboardHeight:keyboardHeight]) animated:YES];
                        
                    }
                    
                }];
   id keyboardHideObserver = [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *noti){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                    [weakView setContentOffset:weakViewContentOffset animated:YES];
                    keyboardHeight = 0;
                }];
    [self.observers addObject:keyboardHideObserver];
    [self.observers addObject:keyboardShowObserver];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

- (void)uploadKeyBoardManager
{
    if (self.observers && [self.observers count] > 0) {
        [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[NSNotificationCenter defaultCenter] removeObserver:obj];
        }];
        
        [self.observers removeAllObjects];
    }
    
}
@end

