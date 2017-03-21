//
//  DWLoginViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/6.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "DWLoginViewController.h"
#import "DWRegisterViewController.h"
#import "DWForgetPasswordViewController.h"
#import "SettingServiceViewController.h"
#import "UIViewController+KeyBoardManager.h"
#import "HaoConnect.h"
#import "HaoUtility.h"

@interface DWLoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passWordTF;
@property (strong, nonatomic) IBOutlet UIButton *forgetPassWordBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

// 切换服务器
@property(nonatomic,assign)NSInteger passwordCurrentIndex;
@property(nonatomic,strong)NSMutableString * passwordString;

@end

@implementation DWLoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
}


#pragma mark ---- btn action -----

- (IBAction)clickLeftBtnAction:(id)sender {
    self.passwordCurrentIndex++;
    NSLog(@"L");
    if (self.passwordCurrentIndex > 8) {
        self.passwordCurrentIndex = 0;
        self.passwordString = [NSMutableString string];
    }
    
    [self.passwordString appendString:@"L"];
    
    if ([self.passwordString isEqualToString:@"LLRRLRRL"]) {
        
        SettingServiceViewController *server = [[SettingServiceViewController alloc] initWithNibName:@"SettingServiceViewController" bundle:nil];
        [self.navigationController pushViewController:server animated:YES];
    }
    
}
- (IBAction)clickRightBtnAction:(id)sender {
    
    self.passwordCurrentIndex++;
    NSLog(@"R");
    if (self.passwordCurrentIndex > 8) {
        self.passwordCurrentIndex = 0;
        self.passwordString = [NSMutableString string];
    }
    
    [self.passwordString appendString:@"R"];
}


- (IBAction)clickForgetPasswordBtnAction:(id)sender {
    
    DWForgetPasswordViewController *forgetPasswordVC = [[DWForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}

- (IBAction)clickRegisterBtnAction:(id)sender {
    
    DWRegisterViewController *registerVC = [[DWRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (IBAction)clickLoginBtnAction:(id)sender {
    
    if (![self reqBefor_username]) {
        return;
    }
    
    if (![self reqBefor_password]) {
        return;
    }
    
    [self.view endEditing:YES];
    
    [self loginAction];
    
}

- (void)loginAction
{

    //    g_App.checkCode = @"";
    //    [Y_X_DataInterface setCommonParam:YX_KEY_CHECKCODE value:@""];
    //
    [HaoConnect setCurrentUserInfo:nil :nil :nil];
    NSMutableDictionary * exprame=nil;
    exprame=[NSMutableDictionary dictionaryWithObjectsAndKeys:
             self.userNameTF.text,@"name",
//             [HaoUtility md5:self.passWordTF.text],@"pass",
             self.passWordTF.text,@"pass",
             nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HaoConnect request:@"pub_user/login_with_pwd" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            NSString *checkcode = NSValueToString(result.extraInfo[@"authInfo"][@"Checkcode"]);
            NSString *logintime = NSValueToString(result.extraInfo[@"authInfo"][@"Logintime"]);
            NSString *userID = NSValueToString(result.extraInfo[@"authInfo"][@"Userid"]);
            NSString *userName = NSValueToString(result.results[@"userName"]);
            
            [DWUserDataManager standardUserDefaults].checkcode = checkcode;
            [DWUserDataManager standardUserDefaults].logintime = logintime;
            [DWUserDataManager standardUserDefaults].userID = userID;
            [DWUserDataManager standardUserDefaults].userName = userName;
            
            [HaoConnect setCurrentUserInfo:userID :logintime :checkcode];
            [MBProgressHUD showSuccess:@"登录成功" ToView:nil];
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.completeLoginBlock) {
                    self.completeLoginBlock();
                }
            }];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];

}



- (BOOL)reqBefor_username
{
    if (self.userNameTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" ToView:nil];
        return FALSE;
    }
    
    return TRUE;
}



- (BOOL)reqBefor_password
{
    if (self.passWordTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" ToView:nil];
        return FALSE;
    }
    //    else if (self.passWordTF.text.length < 6 || self.passWordTF.text.length > 16)
    //    {
    //        [MBProgressHUD showError:@"密码长度限制6至16位" toView:nil];
    //        return FALSE;
    //    }
    //    if ([Tool validatePassword:self.passwordTF.text] == NO) {
    //        [MBProgressHUD showError:@"密码只允许字母和数字" toView:nil];
    //        return FALSE;
    //    }
    
    return TRUE;
}


- (void)textFieldDidChange:(NSNotification *)noti
{
    if (self.passWordTF.text.length > 0 && self.userNameTF.text.length >0) {
        
        self.loginBtn.userInteractionEnabled = YES;
        [self.loginBtn setBackgroundColor:kNavBackgroundColor];
        
    } else
    {
        self.loginBtn.userInteractionEnabled = NO;
        [self.loginBtn setBackgroundColor:[Tool getColor:@"#a3bdf0"]];
    }
    
}


#pragma mark --- textField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self setupForKeyboardWithScrolledView:self.scrollView clickedView:textField];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self uploadKeyBoardManager];
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
