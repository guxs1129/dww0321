//
//  SettingServiceViewController.m
//  Zhaowaibao
//
//  Created by lianghuigui on 16/2/29.
//  Copyright © 2016年 lianghuigui. All rights reserved.
//

#import "SettingServiceViewController.h"

@interface SettingServiceViewController ()

@end

@implementation SettingServiceViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"服务器设置";
  
    BOOL ceShi = [[NSUserDefaults standardUserDefaults] boolForKey:@"FFFFFFFF"];
    
    [self.btn0 setTitleColor:ceShi ? [UIColor blackColor] : [UIColor redColor] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:ceShi ? [UIColor redColor] : [UIColor blackColor] forState:UIControlStateNormal];

    
}

- (UIButton *)set_leftButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    return button;
}

- (void)left_button_event:(UIButton *)sender
{
    [self goBackToPreview:sender];
}

- (UIButton *)set_rightButton
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    return rightBtn;
}

- (void)right_button_event:(UIButton *)sender
{
    [self clickAction];
}

-(void)goBackToPreview:(id)btn{

    exit(0);
}
-(void)clickAction{

    exit(0);

}
- (IBAction)changeServer:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    BOOL zhengShi = btn.tag == 10 ? YES : NO;
    
    [self.btn0 setTitleColor:zhengShi ? [UIColor redColor] : [UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:zhengShi ? [UIColor blackColor] : [UIColor redColor] forState:UIControlStateNormal];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:!zhengShi forKey:@"FFFFFFFF"];
    [ud synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
