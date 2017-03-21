//
//  SWPopView.m
//  Zhaowaibao
//
//  Created by Shadow.G on 16/9/26.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "SWPopView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Length 5
#define Length2 15

@interface SWPopView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CAShapeLayer *triangleLayer;

@end
@implementation SWPopView

- (instancetype _Nonnull)initWithOrigin:(CGPoint)origin
                                  width:(CGFloat)width
                                 height:(CGFloat)height
                        backgroundColor:(UIColor * _Nonnull)backgroundColor
                            borderColor:(UIColor * _Nonnull)borderColor
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 箭头的位置
        self.origin = origin;
        // 视图的宽度
        self.width = width;
        // 视图的高度
        self.height = height;
        
        self.backGoundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, width, height)];
        self.backGoundView.backgroundColor = backgroundColor;
        if (borderColor && [borderColor isKindOfClass:[UIColor class]]) {
            self.backGoundView.layer.borderColor = borderColor.CGColor;
        }
        self.backGoundView.layer.borderWidth = 0.5;
        self.backGoundView.layer.cornerRadius = 5;
        
        [self addSubview:self.backGoundView];
        // 添加tableview
        [self.backGoundView addSubview:self.tableView];
        // 添加箭头
        [self addTriangleLayer];
    }
    return self;
}

- (void)addTriangleLayer
{
 
    // Drawing code
    self.triangleLayer = [CAShapeLayer new];
    
    self.triangleLayer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, Length)];
    [path addLineToPoint:CGPointMake(Length*2 /3, 0)];
    [path addLineToPoint:CGPointMake(Length, Length)];
    self.triangleLayer.path = path.CGPath;
    self.triangleLayer.lineWidth = 0.5;
    self.triangleLayer.fillColor = self.backGoundView.backgroundColor.CGColor;
    self.triangleLayer.strokeColor = self.backGoundView.layer.borderColor;
    self.triangleLayer.frame = CGRectMake(CGRectGetMinX(self.backGoundView.frame) - self.backGoundView.frame.size.width /1.6, self.origin.y, Length, Length + 1);
    
    // line
    CAShapeLayer *lineLayer = [CAShapeLayer new];
    lineLayer.frame = CGRectMake(0, self.triangleLayer.frame.size.height - 1, self.triangleLayer.frame.size.width, 1);
    lineLayer.backgroundColor = self.backGoundView.backgroundColor.CGColor;
    [self.triangleLayer addSublayer:lineLayer];
    
    [self.layer addSublayer:self.triangleLayer];

}


#pragma mark - popView
- (void)popView
{
    // 同步显示 子控件(views)和(self)
    NSArray *results = [self.backGoundView subviews];
    for (UIView *view in results) {
        [view setHidden:YES];
    }
    UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
    [windowView addSubview:self];
    self.backGoundView.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
    CGFloat origin_x = self.origin.x + Length2;
    CGFloat origin_y = self.origin.y + Length;
    CGFloat size_width = -self.width;
    CGFloat size_height = self.height;
    [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
}


#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![[touches anyObject].view isEqual:self.backGoundView]) {
        [self dismiss];
    }
    
}

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark -
- (void)dismiss
{
    /**
     *  删除 在backGroundView 上的子控件
     */
    NSArray *results = [self.backGoundView subviews];
    
    for (UIView *view in results) {
        
        [view removeFromSuperview];
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        //
        self.backGoundView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
        self.triangleLayer.opacity = 0;
    } completion:^(BOOL finished) {
        //
        [self removeFromSuperview];
    }];
}
#pragma mark -
- (void)startAnimateView_x:(CGFloat) x
                        _y:(CGFloat) y
              origin_width:(CGFloat) width
             origin_height:(CGFloat) height
{
    [UIView animateWithDuration:0.25 animations:^{
        self.backGoundView.frame = CGRectMake(x, y, width, height);
        self.triangleLayer.opacity = 1.0;
    }completion:^(BOOL finished) {
        NSArray *results = [self.backGoundView subviews];
        for (UIView *view in results) {
            [view setHidden:NO];
        }
    }];
}
#pragma mark -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backGoundView.frame.size.width , self.backGoundView.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.row_height == 0) {
        return 44;
    }else{
        return self.row_height;
    }
}

#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"pullDownCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        CALayer *lineLayer = [CALayer layer];
        lineLayer.backgroundColor = self.backGoundView.layer.borderColor;
        CGFloat lineY = self.row_height == 0 ? (44 +  0.5) : (self.row_height + 0.5);
        lineLayer.frame = CGRectMake(10, lineY, self.width - 20, 0.5);
        [cell.contentView.layer addSublayer:lineLayer];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(cell.separatorInset.top, 10, cell.separatorInset.bottom, 10);
    
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:self.fontSize];
    cell.textLabel.textColor = self.titleTextColor;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndexPathRow:)]) {
        [self.delegate selectIndexPathRow:indexPath.row];
    }
}


@end
