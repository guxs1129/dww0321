//
//  CreateRecruitmentPrivateSettingViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CreateRecruitmentPrivateSettingViewController.h"

@interface CreateRecruitmentPrivateSettingViewController ()
@property (strong, nonatomic) UIView *footerView;

@end

@implementation CreateRecruitmentPrivateSettingViewController

- (instancetype)init
{
    self = [super initWithNibName:@"PrivateSettingViewController" bundle:nil];
    if (self) {
        return self;
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 121)];
    self.footerView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(0, 0, ScreenSizeWidth *0.9, 45);
    commitBtn.center = CGPointMake(self.footerView.frame.size.width / 2, self.footerView.frame.size.height / 2);
    commitBtn.backgroundColor = CUSTOMORANGECOLOR;
    [commitBtn setTitle:@"完成简历创建" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commitBtn addTarget:self action:@selector(clickFooterViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.layer.cornerRadius = 2;
    commitBtn.clipsToBounds = YES;
    [self.footerView addSubview:commitBtn];
    self.tableView.tableFooterView = self.footerView;
    
    self.rt_disableInteractivePop = YES;
}
- (void)clickFooterViewButtonAction:(UIButton *)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.resumeID),@"id",
               NSValueToString(self.display),@"display",
            
               nil];
    
    [HaoConnect request:@"job_resume/update" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            [SWAlertView showAlertWithTitle:@"" message:@"您的简历已创建完成!" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
                
                if (buttonIndex != alertView.cancelButtonIndex) {
                    [self.cyl_tabBarController setSelectedIndex:1];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } else
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            } cancelButtonTitle:@"继续完善简历" otherButtonTitles:@"去找工作",nil];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

#pragma mark --- navigationBar appearance

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
    if (self.isEditing) {
        [self.navigationController popViewControllerAnimated:YES];
    } else
    {
        [SWAlertView showAlertWithTitle:@"" message:@"您确定退出简历编辑吗?退出编辑, 可在简历页完善简历" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
            
            if (buttonIndex != alertView.cancelButtonIndex) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    
}

- (UIButton *)set_rightButton
{
    UIButton *stepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stepBtn.frame = CGRectMake(0, 0, 60, 40);
    [stepBtn setTitle:@"5/5" forState:UIControlStateNormal];
    stepBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [stepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return stepBtn;
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
