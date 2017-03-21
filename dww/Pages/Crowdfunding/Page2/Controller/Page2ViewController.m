//
//  Page2ViewController.m
//  dww
//
//  Created by 顾新生 on 2017/3/21.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "Page2ViewController.h"
#import "SearchButton.h"
@interface Page2ViewController ()
@property(nonatomic,strong)SearchButton *titleView;
@property(nonatomic,strong)UIView *testView;

@end

@implementation Page2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavi{
    self.navigationItem.titleView=self.titleView;

}

#pragma mark ---------------setter & getter---------------
-(SearchButton *)titleView{
    if (_titleView==nil) {
        _titleView=[[SearchButton alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 26)];
        _titleView.clickBlock=^{
            NSLog(@"%s",__func__);
        };
    }
    return _titleView;
}
@end
