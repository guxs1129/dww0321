//
//  SWDatePickerAppearance.m
//  dww
//
//  Created by Shadow. G on 2017/1/4.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "SWDatePickerAppearance.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define DATE_PICKER_HEIGHT 216.0f
#define TOOLVIEW_HEIGHT 40.0f
#define BACK_HEIGHT TOOLVIEW_HEIGHT + DATE_PICKER_HEIGHT

typedef void(^dateBlock)(NSDate *);

@interface SWDatePickerAppearance ()

@property (nonatomic, strong) SWDatePicker *datePicker;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) DatePickerMode dataPickerMode;

@property (nonatomic, copy) dateBlock dateBlock;

@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *currentChooseDate;

@end
@implementation SWDatePickerAppearance

- (instancetype)initWithDatePickerMode:(DatePickerMode)dataPickerMode currentDate:(NSDate *)currentDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate completeBlock:(void (^)(NSDate *date))completeBlock {
    self = [super init];
    if (self) {
        _dataPickerMode = dataPickerMode;
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dateBlock = completeBlock;
        _maxDate = maxDate;
        _minDate = minDate;
        _currentChooseDate = currentDate;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, BACK_HEIGHT)];
    _backView.backgroundColor = [UIColor whiteColor];
    _datePicker = [[SWDatePicker alloc]initWithDatePickerMode:_dataPickerMode MinDate:_minDate MaxDate:_maxDate];
    _datePicker.frame = CGRectMake(0, TOOLVIEW_HEIGHT, kScreenWidth, DATE_PICKER_HEIGHT);
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 8, 80, 40)];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:16/255.0f green:109/255.0f blue:255/255.0f alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 80, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:16/255.0f green:109/255.0f blue:255/255.0f alpha:1] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:cancelBtn];
    [self.backView addSubview:_datePicker];
    [self.backView addSubview:btn];
    [self addSubview:self.backView];
    [_datePicker selectDate:_currentChooseDate];
}

- (void)done {
    if (_dateBlock) {
        _dateBlock(_datePicker.date);
    }
    [self hide];
}

- (void)cancel
{
    [self hide];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.superview endEditing:YES];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:0.25 animations:^{
        _backView.frame = CGRectMake(0, kScreenHeight - (BACK_HEIGHT), kScreenWidth, BACK_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
}

-(void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        _backView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, BACK_HEIGHT);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
