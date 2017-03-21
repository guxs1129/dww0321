//
//  BaseViewController.m
//  eService
//
//  Created by 顾新生 on 2016/12/19.
//  Copyright © 2016年 guxinsheng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupNavi];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupNavi{
    
}
-(void)setupSubviews{
    
    UIControl *tapControl=[[UIControl alloc]init];
    [self.view addSubview:tapControl];
    [tapControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewDidTapped:)];
    [tapControl addGestureRecognizer:tap];
    
}
-(void)viewDidTapped:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}
-(void)pushVCWithClass:(Class)class{
    if ([class isSubclassOfClass:[BaseViewController class]]) {
        BaseViewController *vc=[[class alloc]init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
