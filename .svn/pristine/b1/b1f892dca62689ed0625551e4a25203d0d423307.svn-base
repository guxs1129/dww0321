//
//  DWForgetPasswordViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/6.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "DWForgetPasswordViewController.h"
#import "UIViewController+KeyBoardManager.h"
#import "HaoConnect.h"
#import "HaoUtility.h"

#define kVerifyDefaulfText @"获取验证码"
@interface DWForgetPasswordViewController ()
{
    NSTimer * timer;
    NSInteger seconds;
    NSInteger indexSelect;
}

@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (strong, nonatomic) IBOutlet UITextField *verifyCodeTF;

@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@property (strong, nonatomic) IBOutlet UIButton *verifyCodeBtn;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation DWForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.isDarkBackButton = YES;
    self.verifyCodeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}


#pragma mark --- navigation bar appearance

- (BOOL)hideNavigationBottomLine
{
    return NO;
}

- (NSMutableAttributedString *)setTitle
{
    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:@"找回密码"];
    [attTitle addAttribute:NSForegroundColorAttributeName value:DARKTEXTCOLOR range:NSMakeRange(0, attTitle.length)];
    return attTitle;
}


#pragma mark --- btn action

- (IBAction)clickCommitBtnAction:(id)sender {
    if (![self reqBefor_phoneNumber] || ![self reqBefor_validationCode] || ![self reqBefor_password]) {
        return;
    }
    [self.view endEditing:YES];
    NSMutableDictionary *exprame=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  
                                  self.phoneNumberTF.text, @"telephone",
                                  self.verifyCodeTF.text, @"yzma",
                                  [HaoUtility md5:self.passwordTF.text], @"newpassword",
                                  nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HaoConnect request:@"pub_user/update_with_verify_code" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [MBProgressHUD showSuccess:@"已重置密码" ToView:self.view];
            [self performSelector:@selector(gobacktoLogin) withObject:nil afterDelay:1.0f];
            
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];

}
-(void)gobacktoLogin{

    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickVerifyCodeBtnAction:(id)sender {
    
    if (![self reqBefor_phoneNumber]) {
        return;
    }
    NSMutableDictionary *exprame=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  
                                  self.phoneNumberTF.text, @"telephone",
                                  @"findpass", @"pass_key",
                                  @"2",@"utype", //个人用户
                                  nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HaoConnect request:@"sys_ident_sms/send_verify_code" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [MBProgressHUD showSuccess:@"发送成功" ToView:self.view];
//            [SWAlertView showAlertWithTitle:@"" message:result.errorStr completionBlock:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            seconds = 60;
            timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(secondCount) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            self.verifyCodeBtn.enabled=NO;
            
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];


}

-(void)secondCount{
    
    seconds--;
    if (seconds<=0) {
        self.verifyCodeBtn.enabled=YES;
        seconds = 60;
        [self.verifyCodeBtn setBackgroundColor:[UIColor whiteColor]];
        [self.verifyCodeBtn setTitleColor:[UIColor colorWithHexString:@"0XFDA128"] forState:UIControlStateNormal];
        [self.verifyCodeBtn setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        [timer invalidate];
        timer=nil;
    }else{
        self.verifyCodeBtn.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
        [self.verifyCodeBtn setTitleColor:DARKTEXTCOLOR forState:UIControlStateNormal];
        [self.verifyCodeBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld)",(long)seconds] forState:UIControlStateNormal];
        self.verifyCodeBtn.enabled=NO;
        
    }
    
}





- (BOOL)reqBefor_phoneNumber
{
    if (self.phoneNumberTF.text.length != 11 || ![Tool validatePhone:self.phoneNumberTF.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号码" ToView:nil];
        indexSelect=0;
        [self performSelector:@selector(becomeKeyBoard) withObject:self afterDelay:1.0f];
        
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)reqBefor_validationCode
{
    if (self.verifyCodeTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码" ToView:nil];
        indexSelect=1;
        [self performSelector:@selector(becomeKeyBoard) withObject:self afterDelay:1.0f];
        
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)reqBefor_password
{
    if (self.passwordTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" ToView:nil];
        indexSelect=3;
        [self performSelector:@selector(becomeKeyBoard) withObject:self afterDelay:1.0f];
        
        return FALSE;
    }
    //    else if (self.passwordTF.text.length < 6 || self.passwordTF.text.length > 12)
    //    {
    //        [MBProgressHUD showError:@"密码长度限制6至12位" toView:nil];
    //        return FALSE;
    //    }
    //    if ([Tool validatePassword:self.passwordTF.text] == NO) {
    //        [MBProgressHUD showError:@"密码只允许字母和数字" toView:nil];
    //        return FALSE;
    //    }
    //    if (![_passwordTF.text isEqualToString:_againPasswordTF.text]) {
    //        [MBProgressHUD showError:@"您输入的密码前后不一致" toView:nil];
    //        indexSelect=4;
    [self performSelector:@selector(becomeKeyBoard) withObject:self afterDelay:1.0f];
    //
    //        return FALSE;
    //    }
    
    
    return TRUE;
}

-(void)becomeKeyBoard{
    
    switch (indexSelect) {
        case 0:
            [_phoneNumberTF becomeFirstResponder];
            
            break;
        case 1:
            [_verifyCodeTF becomeFirstResponder];
            
            break;
        case 2:
            //            [_userNameTF becomeFirstResponder];
            
            break;
        case 3:
            [_passwordTF becomeFirstResponder];
            
            break;
            
            
        default:
            break;
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
