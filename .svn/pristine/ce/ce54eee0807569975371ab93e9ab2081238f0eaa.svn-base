//
//  SWMutableDataPicker.m
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "SWMutableDataPicker.h"

#define kPickerViewHeight 216

@interface SWMutableDataPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *headView;
@property (strong, nonatomic) UIPickerView *pickView;
@property (strong,nonatomic) NSArray *firstAry;//一级数据源
@property (strong,nonatomic) NSArray *secondAry;//二级数据源
@property (strong,nonatomic) NSArray *thirdAry;//三级数据源
@property (nonatomic,assign) NSInteger firstCurrentIndex;//第一行当前位置
@property (nonatomic,assign) NSInteger secondCurrentIndex;//第二行当前位置
@property (nonatomic,assign) NSInteger thirdCurrentIndex;//第三行当前位置

@end
@implementation SWMutableDataPicker

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        [self internalConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalConfig];
    }
    return self;
}

- (void)internalConfig {
    _backView = [[UIView alloc] initWithFrame:self.frame];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.6;
    [self addSubview:_backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [_backView addGestureRecognizer:tap];
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.pickView];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pickView.frame.origin.y - 43.5, self.frame.size.width, 43.5)];
    _headView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 43.5, 43.5);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.frame.size.width - 42 - 10, 0, 42, 43.5);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:CUSTOMORANGECOLOR forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(completionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:button];
    
    [self addSubview:_headView];
}

- (void)showPickerWithDataSource:(NSArray *)dataSource firstComponentSelectedValue:(NSString *)firstValue secondComponentSelectedValue:(NSString *)secondValue thirdComponentSelectedValue:(NSString *)thirdValue
{
    if (!dataSource) {
        return;
    }
    _firstAry = dataSource;
    if (firstValue && firstValue.length > 0) {
        [_firstAry enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull rowData, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([rowData[self.rowValueInFirstComponentKey] isEqualToString:firstValue]) {
                _firstCurrentIndex = idx + 1;
                if (rowData[self.secondComponentDataSourceKey] && [rowData[self.secondComponentDataSourceKey] isKindOfClass:[NSArray class]]) {
                    _secondAry = rowData[self.secondComponentDataSourceKey];
                }
                
                *stop = YES;
            }
        }];
    } else
    {
        _firstCurrentIndex = 0;
        _secondCurrentIndex = 0;
    }
    
    [_secondAry enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull secondComponentRowData, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([secondComponentRowData[self.rowValueInSecondComponentKey] isEqualToString:secondValue]) {
            _secondCurrentIndex = idx + 1;
            if (secondComponentRowData[self.thirdComponentDataSourceKey] && [secondComponentRowData[self.thirdComponentDataSourceKey] isKindOfClass:[NSArray class]]) {
                _thirdAry = secondComponentRowData[self.thirdComponentDataSourceKey];
            }
            *stop = YES;
        }
    }];
    
    [_thirdAry enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull thirdComponentRowData, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([thirdComponentRowData[self.rowValueInThirdComponentKey] isEqualToString:thirdValue]) {
            _thirdCurrentIndex = idx + 1;
            *stop = YES;
        }
    }];
    
    [self.pickView reloadAllComponents];
    [self.pickView selectRow:_firstCurrentIndex inComponent:0 animated:NO];
    if (_secondAry && _secondAry.count > 0) {
        [self.pickView selectRow:_secondCurrentIndex inComponent:1 animated:NO];
    }
    
    if (_thirdAry && _thirdAry.count > 0) {
        [self.pickView selectRow:_thirdCurrentIndex inComponent:2 animated:NO];
    }
    
    [self show];

}

- (void)show {
    self.hidden = NO;

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = self.superview.frame;
    [self.superview endEditing:YES];
    _backView.frame = self.frame;

    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 0.6;
        self.pickView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kPickerViewHeight, self.frame.size.width, kPickerViewHeight);
        _headView.frame = CGRectMake(0, self.pickView.frame.origin.y - 43.5, self.frame.size.width, 43.5);
    }];
}

- (void)hide {
    _backView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.pickView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height+44, self.frame.size.width, kPickerViewHeight);
        _backView.alpha = 0;
        _headView.frame = CGRectMake(0, self.pickView.frame.origin.y, self.frame.size.width, 43.5);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

//选项默认值
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    return;
}

//设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    if (_secondAry && _thirdAry.count > 0) {
        return 3;
    }
    
    if (_secondAry.count > 0) {
        _thirdCurrentIndex = 0;
        return 2;
    }
    
    _secondCurrentIndex = 0;
    return 1;
}

//返回数组总数
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _firstAry.count + 1;
    } else if (component == 1) {
        return _secondAry.count + 1;
    } else {
        return _thirdAry.count + 1;
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        if (row > 0) {
            if (row - 1 < _firstAry.count) {
                NSDictionary *data = _firstAry[row - 1];
                //获取一级value
                NSString *str = data[self.rowValueInFirstComponentKey];
                return str;
            }
        }
    } else if (component == 1) {
        if (row > 0) {
            if (row - 1 < _secondAry.count) {
                NSDictionary *data = _secondAry[row - 1];
                //获取二级value
                NSString *str = data[self.rowValueInSecondComponentKey];
                return str;
            }
        }
    } else {
        if (row > 0) {
            if (row - 1 < _thirdAry.count) {
                //获取三级value
                NSString *str = _thirdAry[row - 1][self.rowValueInThirdComponentKey];
                return str;
            }
        }
    }
    return @"请选择";
}


//触发事件
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _firstCurrentIndex = row;
        
        if (row > 0) {
            NSDictionary *dic = _firstAry[row - 1];
            _secondAry = dic[self.secondComponentDataSourceKey];
            _secondCurrentIndex = 0;
            
            _thirdAry = nil;
            _thirdCurrentIndex = 0;
            
        } else {
            _secondAry = nil;
            _secondCurrentIndex = 0;
        }
        
        [self.pickView reloadAllComponents];
        if (_secondAry.count > 0) {
            [self.pickView selectRow:_secondCurrentIndex inComponent:1 animated:NO];
        }
    } else if (component == 1) {
        _secondCurrentIndex = row;
        
        if (row > 0) {
            NSDictionary *dic = _secondAry[row - 1];
            _thirdAry = dic[self.thirdComponentDataSourceKey];
            _thirdCurrentIndex = 0;
            
        } else {
            _thirdAry = nil;
            _thirdCurrentIndex = 0;
        }
        
        [self.pickView reloadAllComponents];
        if (_thirdAry.count > 0) {
            [self.pickView selectRow:_thirdCurrentIndex inComponent:2 animated:NO];
        }
    } else {
        _thirdCurrentIndex = row;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)completionButtonAction:(UIButton *)sender {
    
    NSDictionary *rowDataInFirstComponent = @{};
    NSDictionary *rowDataInSecondComponent = @{};
    NSDictionary *rowDataInThirdComponent = @{};
    
    if (_firstAry.count > 0) {
        if (_firstCurrentIndex > 0) {
            if (_firstCurrentIndex - 1 < _firstAry.count) {
                rowDataInFirstComponent = _firstAry[_firstCurrentIndex - 1];
            }
        }
    }
    
    if (_secondAry.count > 0) {
        if (_secondCurrentIndex > 0) {
            if (_secondCurrentIndex - 1 < _secondAry.count) {
               rowDataInSecondComponent = _secondAry[_secondCurrentIndex - 1];

            }
        }
    }
    
    if (_thirdAry.count > 0) {
        if (_thirdCurrentIndex > 0) {
            if (_thirdCurrentIndex - 1 < _thirdAry.count) {
                rowDataInThirdComponent = _thirdAry[_thirdCurrentIndex - 1];
            }
        }
    }
    
    if (_completion) {
        _completion(rowDataInFirstComponent, rowDataInSecondComponent, rowDataInThirdComponent);
    }
    [self hide];
}

- (void)cancleButtonAction:(UIButton *)sender {
    [self hide];
}


#pragma mark - 懒加载

- (UIPickerView*)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height + 44, self.frame.size.width, kPickerViewHeight)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor whiteColor];
        [_pickView selectRow:0 inComponent:0 animated:NO];
    }
    return _pickView;
}

@end
