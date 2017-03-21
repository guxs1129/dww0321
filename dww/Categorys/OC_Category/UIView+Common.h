//
//  UIView+Common.h
//  东方赢家
//
//  Created by dfzq on 16/7/5.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EaseLoadingView, EaseBlankPageView;

// 空白页面相关类型
typedef NS_ENUM(NSUInteger, EaseBlankPageType) {
    EaseBlankPageTypeDefault = 0,               // 默认空白页
    EaseBlankPageTypeAuthFail,                  // 登录认证失效，请去登录
    EaseBlankPageTypeResourceNotFound,          // 资源没有找到，404错误
    EaseBlankPageTypeUnknownError,              // http未知错误
    EaseBlankPageTypeNoQuestions,               // 未获取到题目
    EaseBlankPageTypeProtocolNotFound,          // 协议没有找到，业务异常
    EaseBlankPageTypeLoadFail,                  // 资源加载失败
    EaseBlankPageTypeRequestTimeout,            // 请求超时
    EaseBlankPageTypeNoRecruitment,             // 没有简历
    EaseBlankPageTypeNosendResumeJob,            //没有投递任何职位
    EaseBlankPageTypeNoPersonlookResume,             //暂无HR浏览您的简历
    EaseBlankPageTypeNoPersonDownLoadResume,             //暂无HR下载您的简历
    EaseBlankPageTypeFavYoulikeJob,                 //快去收藏您喜欢的职位吧！
    EaseBlankPageTypeBookingJob,                 //职位订阅器
    EaseBlankPageTypeNoPositionSubscriber,      // 没有职位订阅器
};

// 对UIView的扩展类
@interface UIView (Common)

- (void)doCircleFrame;

- (void)setSubScrollsToTop:(BOOL)scrollsToTop;

#pragma mark LoadingView
@property (nonatomic, strong) EaseLoadingView *loadingView;
- (void)beginLoading;
- (void)endLoading;

#pragma mark BlankPageView
@property (nonatomic, strong) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block customButtonBlock:(void(^)(UIButton *sender))customButtonBlock;

#pragma mark Line
// 添加上划线
+ (UIView *)addSeparatorLineBelowView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin;
+ (UIView *)addSeparatorLineBelowView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin leftPadding:(CGFloat)leftPadding rightPadding:(CGFloat)rightPadding;

// 添加下划线
+ (UIView *)addSeparatorLineUnderView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin;
+ (UIView *)addSeparatorLineUnderView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin leftPadding:(CGFloat)leftPadding rightPadding:(CGFloat)rightPadding;

@end

// 新增UIView的加载动画图层
@interface EaseLoadingView : UIView

@property (nonatomic, strong) UIImageView *logoLoopView;            // 循环的Logo视图层
@property (nonatomic, strong) UIImageView *shadowView;              // 底部循环收缩变化的阴影层
@property (nonatomic, strong) UILabel * loadingLabel;               // 加载特效时显示的文字
@property (assign, nonatomic, readonly) BOOL isLoading;             // 是否加载中的控制变量，防止重复被执行

/**
 *  开始动画
 */
- (void)startAnimating;
/**
 *  结束动画，释放资源
 */
- (void)stopAnimating;

@end

// 新增BlankPage图层实现
@interface EaseBlankPageView : UIView

@property (nonatomic, strong) UIImageView *blankSceneImageView;     // 定义不同场景对应的场景图片(设计上通过枚举类型来加载不同的图片图层)
@property (nonatomic, strong) UILabel *tipLabel;                    // 定义不同场景对应的提示文字
@property (nonatomic, strong) void(^reloadButtonBlock)(id sender);  // 重新加载按钮触发的块函数引用
@property (nonatomic, strong) void(^customButtonBlock)(UIButton * sender);  // 自定义按钮触发的块函数引用
@property (strong, nonatomic) UIButton *reloadButton;               // 重新加载按钮

@property (strong, nonatomic) UIButton *customButton;               // 自定义功能按钮

/**
 *  根据不同的场景显示不同的BlankPage视图
 *
 *  @param blankPageType 空白页枚举类型，可自由在上方进行扩展
 *  @param hasData       通讯层有无获取到数据
 *  @param hasError      通讯层是否发生非业务异常或错误
 *  @param btnBlock      空白页中按钮所触发的块函数，没有可不定义
 */
- (void)configWithType:(EaseBlankPageType)blankPageType
               hasData:(BOOL)hasData
              hasError:(BOOL)hasError
     reloadButtonBlock:(void(^)(id sender))btnBlock
     customButtonBlock:(void(^)(UIButton *sender))customButtonBlock;

@end
