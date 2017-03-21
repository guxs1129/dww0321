//
//  SendRecruitmentSuccessViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/15.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "SendRecruitmentSuccessViewController.h"

@interface SendRecruitmentSuccessViewController ()

@end

@implementation SendRecruitmentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投递成功";
}

- (UIButton *)set_leftButton
{
    return [UIButton new];
}
- (UIButton *)set_rightButton
{
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return closeBtn;
}

- (void)right_button_event:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
