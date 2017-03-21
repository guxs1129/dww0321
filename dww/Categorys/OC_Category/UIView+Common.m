//
//  UIView+Common.m
//  东方赢家
//
//  Created by dfzq on 16/7/5.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import "UIView+Common.h"
#define ANIMATION_DURATION_SECS 0.5f
#define ANIMATION_TRANSLATEY_VALUE 35.0f

@implementation UIView (Common)
static char LoadingViewKey, BlankPageViewKey;

- (void)doCircleFrame{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
}

- (void)setSubScrollsToTop:(BOOL)scrollsToTop{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)obj setScrollEnabled:scrollsToTop];
            *stop = YES;
        }
    }];
}

#pragma mark LoadingView
- (EaseLoadingView *)loadingView {
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)setLoadingView:(EaseLoadingView *)loadingView {
    [self willChangeValueForKey:@"LoadingViewKey"];
    // 引用类型声明
    objc_setAssociatedObject(self, &LoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (void)beginLoading {
    //TODO blank Page
    
    if (!self.loadingView) {
        self.loadingView = [[EaseLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.loadingView startAnimating];
}

- (void)endLoading {
    if (self.loadingView) {
        [self.loadingView stopAnimating];
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
}

#pragma mark BlankPageView
- (EaseBlankPageView *)blankPageView {
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)setBlankPageView:(EaseBlankPageView *)blankPageView {
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block customButtonBlock:(void(^)(UIButton *sender))customButtonBlock {
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    } else {
        if (!self.blankPageView) {
            self.blankPageView = [[EaseBlankPageView alloc] init];
        }
        self.blankPageView.hidden = NO;
        // 只针对tableView进行图层叠加
        [self.blankPageContainer addSubview:self.blankPageView];
        self.blankPageContainer.bounds = CGRectMake(0, 0, self.blankPageContainer.bounds.size.width, self.blankPageContainer.bounds.size.height);
        [self.blankPageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
        }];
        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block customButtonBlock:customButtonBlock];
    }
}

- (UIView *)blankPageContainer {
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

#pragma mark - Line
+ (UIView *)addSeparatorLineBelowView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin {
    UIView *line = [UIView new];
    //line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    line.backgroundColor = kLineDefaultBg;
    [view addSubview:line];
    
    line.sd_layout
    .leftSpaceToView(view, kMargin)
    .rightSpaceToView(view, kMargin)
    .heightIs(1)
    .topSpaceToView(siblingSubview, margin);
    
    return line;
}

+ (UIView *)addSeparatorLineBelowView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin leftPadding:(CGFloat)leftPadding rightPadding:(CGFloat)rightPadding {
    UIView *line = [self addSeparatorLineBelowView:siblingSubview insertSubview:view margin:margin];
    line.sd_layout.leftSpaceToView(view, leftPadding).rightSpaceToView(view, rightPadding);
    return line;
}

+ (UIView *)addSeparatorLineUnderView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin {
    UIView *line = [UIView new];
    //line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    line.backgroundColor = kLineDefaultBg;
    [view addSubview:line];
    
    line.sd_layout
    .leftSpaceToView(view, kMargin)
    .rightSpaceToView(view, kMargin)
    .heightIs(1)
    .bottomSpaceToView(siblingSubview, margin);
    
    return line;
}

+ (UIView *)addSeparatorLineUnderView:(UIView *)siblingSubview insertSubview:(UIView *)view margin:(CGFloat)margin leftPadding:(CGFloat)leftPadding rightPadding:(CGFloat)rightPadding {
    UIView *line = [self addSeparatorLineUnderView:siblingSubview insertSubview:view margin:margin];
    line.sd_layout.leftSpaceToView(view, leftPadding).rightSpaceToView(view, rightPadding);
    return line;
}

@end



@interface EaseLoadingView ()
// 从Y轴开始偏移
@property (nonatomic, assign) CGFloat fromTranslateY;
// 偏移至Y轴某点结束
@property (nonatomic, assign) CGFloat toTranslateY;
// 从开始比例开始变化
@property (nonatomic, assign) CGFloat fromScaleValue;
// 变化至结束比例
@property (nonatomic, assign) CGFloat toScaleValue;
// 循环计时器
@property (nonatomic, strong) NSTimer *timer;
// 动画执行步骤
@property (nonatomic, assign) int animationStep;
@end

@implementation EaseLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 循环旋转的图片图层
        _logoLoopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_circle"]];
        _logoLoopView.contentMode = UIViewContentModeScaleAspectFit;
        [_logoLoopView setCenter:self.center];
        [self addSubview:_logoLoopView];
        
        // 底部阴影效果的图片图层
        _shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_shadow"]];
        _shadowView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_shadowView];
        
        // 加载特效文字说明，点点点如有时间也需要扩展特效
        _loadingLabel = ({
            UILabel *label = [UILabel new];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"加载中...";
            label.textColor = [UIColor grayColor];
            label;
        });
        [self addSubview:_loadingLabel];
        
        // 定义布局
        [_logoLoopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_logoLoopView.mas_bottom).offset(ANIMATION_TRANSLATEY_VALUE);
            make.centerX.equalTo(_logoLoopView.mas_centerX);
        }];
        [_loadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_shadowView.mas_bottom).offset(-5.0);
            make.centerX.equalTo(_logoLoopView.mas_centerX);
            make.width.and.height.mas_equalTo(60);
        }];
        
        _fromTranslateY = CGRectGetMinY(_logoLoopView.frame);
        _toTranslateY = _fromTranslateY + ANIMATION_TRANSLATEY_VALUE - CGRectGetHeight(_shadowView.frame) - 5.0f;
        _fromScaleValue = 0.3f;
        _toScaleValue = 1.0f;
    }
    return self;
}

- (void)startAnimating {
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    [self loadingAnimation];
}

- (void)loadingAnimation {
    _timer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_DURATION_SECS
                                              target:self
                                            selector:@selector(animateNextStep)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)animateNextStep
{
    switch (_animationStep) {
        case 0:
        {
            [self loadingAnimation:_fromTranslateY toValue:_toTranslateY timingFunction:kCAMediaTimingFunctionEaseIn];
            [self scaleAnimation:_fromScaleValue toValue:_toScaleValue timingFunction:kCAMediaTimingFunctionEaseIn];
        }
            break;
        case 1:
        {
            [self loadingAnimation:_toTranslateY toValue:_fromTranslateY timingFunction:kCAMediaTimingFunctionEaseOut];
            [self scaleAnimation:_toScaleValue toValue:_fromScaleValue timingFunction:kCAMediaTimingFunctionEaseOut];
            _animationStep = -1;
        }
            break;
        default:
            break;
    }
    _animationStep++;
}

-(void)loadingAnimation:(float)fromValue toValue:(float)toValue timingFunction:(NSString * const)tf {
    // 位移变化设置，类似于H5中的transform使用
    CABasicAnimation *translateAnimation = [CABasicAnimation animation];
    translateAnimation.keyPath = @"position.y";
    translateAnimation.fromValue = @(fromValue);
    translateAnimation.toValue = @(toValue);
    translateAnimation.duration = ANIMATION_DURATION_SECS;
    translateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:tf];
    
    // 旋转设置
    CABasicAnimation *rotateAnimation = [CABasicAnimation animation];
    rotateAnimation.keyPath = @"transform.rotation";
    rotateAnimation.fromValue = @(0);
    rotateAnimation.toValue = @(M_PI_2);
    rotateAnimation.duration = ANIMATION_DURATION_SECS;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:tf];
    
    // 动画组合
    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    animationGroup.animations = @[translateAnimation, rotateAnimation];
    animationGroup.duration = ANIMATION_DURATION_SECS;
    animationGroup.beginTime = 0;
    animationGroup.fillMode=kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    [_logoLoopView.layer addAnimation:animationGroup forKey:@"boundDFZQEffect"];
}

-(void)scaleAnimation:(float)fromeValue toValue:(float)toValue timingFunction:(NSString * const)tf {
    // 缩放设置
    CABasicAnimation *sanimation = [CABasicAnimation animation];
    sanimation.keyPath = @"transform.scale";
    sanimation.fromValue =@(fromeValue);
    sanimation.toValue = @(toValue);
    sanimation.duration = ANIMATION_DURATION_SECS;
    
    sanimation.fillMode = kCAFillModeForwards;
    sanimation.timingFunction = [CAMediaTimingFunction functionWithName:tf];
    sanimation.removedOnCompletion = NO;
    
    [_shadowView.layer addAnimation:sanimation forKey:@"boundShadowEffect"];
}

- (void)stopAnimating {
    self.hidden = YES;
    _isLoading = NO;
    
    [_timer invalidate];
    _animationStep = 0;
    [_shadowView removeFromSuperview];
    _shadowView = nil;
    [_logoLoopView removeFromSuperview];
    _logoLoopView = nil;
}

@end


@interface EaseBlankPageView ()
{
    NSString *imageName, *tipStr, *customBtnTitle;
}
@property (nonatomic, assign) EaseBlankPageType curType;
@end

@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"0xf7f7f7"];
    }
    return self;
}

- (void)configWithType:(EaseBlankPageType)blankPageType
               hasData:(BOOL)hasData
              hasError:(BOOL)hasError
     reloadButtonBlock:(void(^)(id sender))btnBlock
     customButtonBlock:(void(^)(UIButton *sender))customButtonBlock{
    
    // 有数据时直接删除该图层
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    self.alpha = 1.0;
    
    // 空白场景对应的图片图层
    if (!_blankSceneImageView) {
        _blankSceneImageView = [UIImageView new];
        [self addSubview:_blankSceneImageView];
    }
    
    // 提示文字
    if (!_tipLabel) {
        _tipLabel = ({
            UILabel *label = [UILabel new];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
        [self addSubview:_tipLabel];
    }
    
    // 布局设置
    [_blankSceneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(100 * ScreenSizeHeight / 667);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(_blankSceneImageView.mas_bottom).offset(35);
//        make.height.mas_equalTo(50);
    }];
    
    _reloadButtonBlock = nil;
    if (hasError) {
        // 通讯层异常，非业务场景，例如404，500，网络中断之类的错误
        // 不显示自定义按钮
        if (_customButton) {
            _customButton.hidden = YES;
        }
        if (!_reloadButton) {
            _reloadButton = ({
                UIButton *btn = [UIButton new];
//                [btn setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
                [btn setBackgroundColor:CUSTOMORANGECOLOR];
                btn.layer.cornerRadius = 4;
                [btn setTitle:@"重新加载" forState:UIControlStateNormal];
                [btn setAdjustsImageWhenHighlighted:YES];
                [btn addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                btn;
            });
            [self addSubview:_reloadButton];
            
            [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(_tipLabel.mas_bottom).offset(3);
                make.size.mas_equalTo(CGSizeMake(160, 40));
            }];
        }
        _reloadButton.hidden = NO;
        _reloadButtonBlock = btnBlock;
    }
    // 分场景显示不同的图片图层和提示文字
    else{
        // 该所有场景下是不需要显示重新加载按钮的
        if (_reloadButton) {
            _reloadButton.hidden = YES;
        }
        if (!_customButton) {
            _customButton = ({
                UIButton *btn = [UIButton new];
                [btn setAdjustsImageWhenHighlighted:YES];
                btn.layer.cornerRadius = 2;
                btn.backgroundColor = CUSTOMORANGECOLOR;
                btn.clipsToBounds = YES;
                [btn addTarget:self action:@selector(customButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                btn;
            });
            [self addSubview:_customButton];
            [_customButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(_tipLabel.mas_bottom).offset(62 * ScreenSizeHeight/667);
                make.size.mas_equalTo(CGSizeMake(ScreenSizeWidth * 0.8, 45));
            }];
            _customButton.hidden = NO;
            _customButtonBlock = customButtonBlock;
        }
    }
    
    _curType = blankPageType;
    // 不同场景配置(开发者可根据业务场景自行进行扩展)
    [self showDifferenceImageViewAndTips];
    
    [_blankSceneImageView setImage:[UIImage imageNamed:imageName]];
    NSMutableAttributedString *attributedTip = [[NSMutableAttributedString alloc] initWithString:tipStr attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    [attributedTip addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : DARKTEXTCOLOR} range:NSMakeRange(0, [tipStr componentsSeparatedByString:@"\n"].firstObject.length)];
    _tipLabel.attributedText = attributedTip;
    if (_customButton && customBtnTitle) {
            [_customButton setTitle:customBtnTitle forState:UIControlStateNormal];
    } else
    {
        _customButton.hidden = YES;
    }

}

- (void)reloadButtonClicked:(id)sender{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            self.hidden = YES;
            [self removeFromSuperview];
            _reloadButtonBlock(sender);
        }
    });
}

- (void)customButtonClicked:(UIButton *)customBtn
{
    if (_customButtonBlock) {
        _customButtonBlock(customBtn);
    }
}

/**
 *  不同场景的提示设置
 *  (开发者可根据业务场景自行进行扩展)
 */
- (void)showDifferenceImageViewAndTips {
    switch (_curType) {
        case EaseBlankPageTypeAuthFail:
        {
            imageName = @"common_blankView";
            tipStr = @"无权访问\n请先完成登录";
        }
            break;
        case EaseBlankPageTypeResourceNotFound:
        {
            imageName = @"common_blankView";
            tipStr = @"页面资源跑丢了";
        }
            break;
        case EaseBlankPageTypeUnknownError:
        {
            imageName = @"common_blankView";
            tipStr = @"发生未知错误";
        }
            break;
        case EaseBlankPageTypeNoQuestions:
        {
            imageName = @"common_blankView";
            tipStr = @"未获取到题目列表";
        }
            break;
        case EaseBlankPageTypeProtocolNotFound:
        {
            imageName = @"common_blankView";
            tipStr = @"未找到当前协议文本";
        }
            break;
        case EaseBlankPageTypeLoadFail:
        {
            imageName = @"common_blankView";
            tipStr = @"资源加载失败";
        }
            break;
        case EaseBlankPageTypeRequestTimeout:
        {
            imageName = @"common_blankView";
            tipStr = @"网络请求超时";
        }
            break;
        case EaseBlankPageTypeNoRecruitment:
        {
            imageName = @"common_blankView";
            tipStr = @"暂时还没有简历\n \n创建您的专属简历, 从此刻开始吧!";
            customBtnTitle = @"创建新简历";
        }
            break;
        case EaseBlankPageTypeNosendResumeJob:
        {
            imageName = @"common_blankView";
            tipStr = @"暂时还没有相关内容\n \n您还没有投递任何职位";

        }
            break;
        case EaseBlankPageTypeNoPersonlookResume:
        {
            imageName = @"common_blankView";
            tipStr = @"暂时还没有相关内容\n \n暂无HR浏览您的简历";
            
        }
            break;
        case EaseBlankPageTypeNoPersonDownLoadResume:
        {
            imageName = @"common_blankView";
            tipStr = @"暂时还没有相关内容\n \n暂无HR下载您的简历";
            
        }
            break;
        case EaseBlankPageTypeFavYoulikeJob:
        {
            imageName = @"common_blankView";
            tipStr = @"暂时还没有相关内容\n \n快去收藏您喜欢的职位吧！";
            
        }
            break;
        case EaseBlankPageTypeBookingJob:
        {
            imageName = @"common_blankView";
            tipStr = @"暂时还没有相关内容\n \n我们会根据您的订阅需求，将合适的职位推荐给您";
            customBtnTitle = @"新建职位订阅器";
        }
            break;

            
        default:
        {
            imageName = @"common_blankView";
            tipStr = @"暂时还没有相关内容";
        }
            break;
    }
}

@end
