//
//  SWIndexView.m
//  dww
//
//  Created by Shadow. G on 2016/12/27.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "SWIndexView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SWIndexView ()

//初始数值(计算用到)
@property (nonatomic,unsafe_unretained) CGFloat number;

@end
@implementation SWIndexView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray<NSString *> *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!array || ![array isKindOfClass:[NSArray class]]) {
            return self;
        }
        self.indexArray = [NSArray arrayWithArray:array];
        
    }
    
    return self;
}

- (void)setupItems
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    CGFloat itemHeight = self.frame.size.height / _indexArray.count;
    [_indexArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, idx * itemHeight, self.frame.size.width, itemHeight)];
        indexLabel.text = obj;
        indexLabel.tag = ITEMTAG + idx;
        indexLabel.textAlignment = NSTextAlignmentCenter;
        indexLabel.textColor = self.normalColor ?: STR_COLOR;
        indexLabel.font = FONT_SIZE;
        [self addSubview:indexLabel];
        
        _number = indexLabel.font.pointSize;;
    }];
    
    [self addSubview:self.animationLabel];

}

#pragma mark ---- setter
- (void)setIndexArray:(NSArray *)indexArray
{
    if (!kArrayIsEmpty(indexArray)) {
        _indexArray = indexArray;
        [self setupItems];
    }
}

#pragma mark ---- getter

- (UILabel *)animationLabel
{
    if (!_animationLabel)
    {
        _animationLabel = [[UILabel alloc]initWithFrame:CGRectMake(-WIDTH / 2 + self.frame.size.width/2, 100, 60, 60)];
        _animationLabel.layer.masksToBounds = YES;
        _animationLabel.layer.cornerRadius = 5.0f;
        _animationLabel.backgroundColor = STR_COLOR;
        _animationLabel.textColor = [UIColor whiteColor];
        _animationLabel.alpha = 0;
        _animationLabel.textAlignment = NSTextAlignmentCenter;
        _animationLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _animationLabel;
}

#pragma mark --- animation

-(void)animationWithSection:(NSInteger)section
{
    self.selectedBlock(section, self.indexArray[section]);
    
    _animationLabel.text = self.indexArray[section];
    _animationLabel.alpha = 1.0;
}


#pragma mark --- PanAnimation 

-(void)panAnimationBeginWithToucher:(NSSet<UITouch *> *)touches
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat hh = self.frame.size.height/self.indexArray.count;
    
    for (int i = 0; i < self.indexArray.count; i ++)
    {
        UILabel * label = (UILabel *)[self viewWithTag:ITEMTAG + i];
        if (fabs(label.center.y - point.y) <= ANIMATION_HEIGHT)
        {
            [UIView animateWithDuration:0.2 animations:^{
                
                label.center = CGPointMake(label.bounds.size.width/2 - sqrt(fabs(ANIMATION_HEIGHT * ANIMATION_HEIGHT - fabs(label.center.y - point.y) * fabs(label.center.y - point.y))), label.center.y);
                
                label.font = [UIFont systemFontOfSize:_number + (ANIMATION_HEIGHT - fabs(label.center.y - point.y)) * FONT_RATE];
                
                if (fabs(label.center.y - point.y) * ALPHA_RATE <= 0.08)
                {
                    label.textColor = self.selectedColor ?: MARK_COLOR;
                    label.alpha = 1.0;
                    
                    [self animationWithSection:i];
                    
                    for (int j = 0; j < self.indexArray.count; j ++)
                    {
                        UILabel * label = (UILabel *)[self viewWithTag:ITEMTAG + j];
                        if (i != j)
                        {
                            label.textColor = self.normalColor ?: STR_COLOR;
                            label.alpha = fabs(label.center.y - point.y) * ALPHA_RATE;
                        }
                    }
                }
            }];
            
        }else
        {
            [UIView animateWithDuration:0.2 animations:^
             {
                 label.center = CGPointMake(self.frame.size.width/2, i * hh + hh/2);
                 label.font = FONT_SIZE;
                 label.alpha = 1.0;
             }];
        }
    }
}

-(void)panAnimationFinish
{
    CGFloat hh = self.frame.size.height/self.indexArray.count;
    
    for (int i = 0; i < self.indexArray.count; i ++)
    {
        UILabel * label = (UILabel *)[self viewWithTag:ITEMTAG + i];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            label.center = CGPointMake(self.frame.size.width/2, i * hh + hh/2);
            label.font = FONT_SIZE;
            label.alpha = 1.0;
            label.textColor = self.normalColor ?: STR_COLOR;
        }];
    }
    
    [UIView animateWithDuration:1 animations:^{
        
        self.animationLabel.alpha = 0;
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationBeginWithToucher:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationBeginWithToucher:touches];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationFinish];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationFinish];
}

-(void)selectIndexBlock:(SelectedIndexBlock)block
{
    if (block) {
        self.selectedBlock = [block copy];
    }
}

-(void)dealloc
{
    self.animationLabel = nil;
    self.indexArray = nil;
    self.selectedBlock = nil;
}

@end
