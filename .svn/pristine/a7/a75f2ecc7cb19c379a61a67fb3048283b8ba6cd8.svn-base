//
//  UITableView+Common.m
//  东方赢家
//
//  对tableView扩展
//  Created by dfzq on 16/7/5.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#import "UITableView+Common.h"

@implementation UITableView (Common)

/**
 *  为tableViewCell单元格添加线框
 *
 *  @param cell      单元格
 *  @param indexPath 单元格索引对象
 *  @param leftSpace 左边距距离
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell cellHeight:(CGFloat)cellHeight forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace{
    [self addLineforPlainCell:cell cellHeight:cellHeight forRowAtIndexPath:indexPath withLeftSpace:leftSpace hasSectionLine:YES];
}

/**
 *  为tableViewCell(section模式)单元格添加线框
 *
 *  @param cell           单元格
 *  @param indexPath      单元格索引对象
 *  @param leftSpace      左边距距离
 *  @param hasSectionLine 有无section
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell cellHeight:(CGFloat)cellHeight forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine{

    [cell layoutIfNeeded];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(CGRectMake(0, 0, ScreenSizeWidth, cellHeight), 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    CGColorRef lineColor = [UIColor colorWithHexString:@"0xF0F0F0"].CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    //    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    //    CGColorRef sectionLineColor = self.separatorColor.CGColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}

#pragma mark -
#pragma mark Private Methods
/**
 *  通过CALayer构建线框
 *
 *  @param layer     图层
 *  @param isUp      是否上线框
 *  @param isLong    是否长线框
 *  @param color     图层颜色
 *  @param bounds    图层尺寸
 *  @param leftSpace 左边距长度
 */
- (void)layer:(CALayer *)layer addLineUp:(BOOL)isUp andLong:(BOOL)isLong andColor:(CGColorRef)color andBounds:(CGRect)bounds withLeftSpace:(CGFloat)leftSpace{
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, top;
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
    }else{
        left = leftSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+left, top, bounds.size.width-left, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}

@end
