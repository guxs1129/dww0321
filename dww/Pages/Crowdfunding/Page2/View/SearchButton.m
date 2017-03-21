//
//  SearchButton.m
//  dww
//
//  Created by 顾新生 on 2017/3/21.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "SearchButton.h"

@implementation SearchButton

-(instancetype)init{
    if (self=[super init]) {
        [self setupSubviews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews{
    
        //bg
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor colorWithRed:67/255.0 green:18/255.0 blue:109/255.0 alpha:1.0];
    bgView.layer.cornerRadius=13;
    bgView.clipsToBounds=YES;
    [self addSubview:bgView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick:)];
    [bgView addGestureRecognizer:tap];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.height.equalTo(@26);
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    
    UILabel *placeholder=[[UILabel alloc]init];
    placeholder.text=@"搜索";

    [placeholder setValuesForKeysWithDictionary:@{@"font":[UIFont systemFontOfSize:11],@"textColor":[UIColor lightGrayColor]}];
    [bgView addSubview:placeholder];
    [placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
    }];
    
    UIButton *searchIndicator=[[UIButton alloc]initWithFrame:CGRectZero];
    [searchIndicator setImage:[UIImage imageNamed:@"search_white"] forState:UIControlStateNormal];
    [bgView addSubview:searchIndicator];
    [searchIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@16);
        make.right.equalTo(@(-10));
        make.centerY.equalTo(@0);
    }];
    [searchIndicator addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)buttonClick:(id)sender{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
