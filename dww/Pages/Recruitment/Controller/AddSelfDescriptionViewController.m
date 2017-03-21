//
//  AddSelfDescriptionViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "AddSelfDescriptionViewController.h"
#import "UITextView+Custom.h"
#import "UIViewController+KeyBoardManager.h"

@interface AddSelfDescriptionViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation AddSelfDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自我描述";
    
    UIToolbar * tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 44)];
    UIBarButtonItem * fixitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickKeboardDone)];
    tool.items =@[fixitem,item];
    self.contentTextView.inputAccessoryView = tool;
    self.contentTextView.delegate = self;
    
    self.contentTextView.placeHolder = @"请输入内容......";
    self.contentTextView.placeHolderTextColor = LIGHTTEXTCOLOR;
    self.contentTextView.maxLength = 500;
    
    self.contentTextView.text = trimming(self.req_selfContent);
    
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.contentTextView.text.length, (unsigned long)self.contentTextView.maxLength]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCountLabelText) name:UITextViewTextDidChangeNotification object:nil];

}

- (void)changeCountLabelText
{
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.contentTextView.text.length, (unsigned long)self.contentTextView.maxLength]];
    if (self.contentTextView.text.length > self.contentTextView.maxLength) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"内容不能超过%lu个字", (unsigned long)self.contentTextView.maxLength] ToView:nil];
    }
}

-(void)clickKeboardDone{
    
    [self.view endEditing:YES];
}

- (NSMutableAttributedString *)countLabelAttributedStringWithString:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : CUSTOMORANGECOLOR}];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0X999999"] range:NSMakeRange(string.length - 5, 5)];
    return attributedString;
}


#pragma mark --- navigationBar appearance
- (void)left_button_event:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)set_rightButton
{
    UIButton *stepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [stepBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    stepBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [stepBtn sizeToFit];
    [stepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return stepBtn;
}

- (void)right_button_event:(UIButton *)sender
{
    if (trimming(self.contentTextView.text).length > 0) {
        if ([NSValueToString(self.resumeID) length] < 1) {
            [MBProgressHUD showError:@"简历不存在" ToView:nil];
            return;
        }
        [self saveInfoActionWithInfoData:@{@"resume_id":NSValueToString(self.resumeID),@"description":trimming(self.contentTextView.text)} completeBlock:^{
            if (self.completeChooseBlock) {
                
                self.completeChooseBlock(trimming(self.contentTextView.text));
            }
            [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];

    } else
    {
        [MBProgressHUD showError:@"请填写自我描述" ToView:nil];
    }
    
}


- (void)saveInfoActionWithInfoData:(NSDictionary *)infoData completeBlock:(void(^)())completeBlock
{
    [self.view endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString([Tool stringFromDic:infoData]),@"resume_extras",
               
               nil];
    [HaoConnect request:@"job_resume_additions/SaveMixAdditions" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (completeBlock) {
                completeBlock();
            }
            
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

#pragma mark --- textView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
  
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.req_selfContent = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.contentTextView.text.length >= self.contentTextView.maxLength && text.length > 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"内容不能超过%lu个字", (unsigned long)self.contentTextView.maxLength] ToView:nil];
        return NO;
    }else
    {
        self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.contentTextView.text.length, (unsigned long)self.contentTextView.maxLength]];
        return YES;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
