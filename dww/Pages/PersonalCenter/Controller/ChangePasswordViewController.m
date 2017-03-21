//
//  ChangePasswordViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIViewController+Login.h"
#import "HaoUtility.h"

@interface ChangePasswordViewController ()

@property (strong, nonatomic) IBOutlet UITextField *oldPassword;
@property (strong, nonatomic) IBOutlet UITextField *theNewPassword;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
}

- (IBAction)clickCommitButtonAction:(id)sender {
    
    if (![self reqBefore_password] || ![self reqBefore_newPassword]) {
        return;
    }
    [self.view endEditing:YES];
    NSMutableDictionary *exprame=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [HaoUtility md5:self.oldPassword.text], @"oldpassword",
                                  [HaoUtility md5:self.theNewPassword.text], @"newpassword",
                                  nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HaoConnect request:@"pub_user/update_with_oldpassword" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [MBProgressHUD showSuccess:@"修改成功" ToView:self.view];

            [self.navigationController popViewControllerAnimated:YES];
//            [self goLoginWithAnimation:YES completeAction:^{
//                [self.navigationController popToRootViewControllerAnimated:NO];
//            }];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];

}

- (BOOL)reqBefore_password
{
    if (self.oldPassword.text.length == 0) {
        [MBProgressHUD showError:@"请输入原密码" ToView:nil];
        return NO;
    }
    return YES;
}

- (BOOL)reqBefore_newPassword
{
    if (self.theNewPassword.text.length == 0) {
        [MBProgressHUD showError:@"请输入新密码" ToView:nil];
        return NO;
    }
    return YES;
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
