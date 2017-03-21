//
//  FeedbackViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UITextView+Custom.h"


@interface FeedbackViewController ()<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIToolbar * tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 44)];
    UIBarButtonItem * fixitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickKeboardDone)];
    tool.items =@[fixitem,item];
    
    self.contentTextView.inputAccessoryView = tool;
    self.contentTextView.delegate = self;
    self.navigationItem.title = @"意见反馈";
    self.contentTextView.placeHolder = @"请输入内容......";
    self.contentTextView.placeHolderTextColor = [UIColor colorWithHexString:@"0xc9c9c9"];
    self.contentTextView.maxLength = 300;
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.contentTextView.text.length, self.contentTextView.maxLength]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCountLabelText) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)changeCountLabelText
{
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.contentTextView.text.length, self.contentTextView.maxLength]];
    if (self.contentTextView.text.length > self.contentTextView.maxLength) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"反馈内容不能超过%lu个字", self.contentTextView.maxLength] ToView:nil];
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

- (IBAction)clickCommitButtonAction:(id)sender {
    
    if (self.titleTextField.text.length <=0) {
        [MBProgressHUD showError:@"请填写反馈标题" ToView:nil];
        return;
    }
    if (_contentTextView.text.length <= 0) {
        [MBProgressHUD showError:@"请填写反馈内容" ToView: nil];
        return;
    }
    if (self.titleTextField.text.length > 0 && self.contentTextView.text.length > 0 && self.contentTextView.text.length <= self.contentTextView.maxLength ) {
        
        [self requestSUmit];
    }

}

-(void)requestSUmit{
    
    NSMutableDictionary *exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"1",@"spmid",
                                    @"2",@"msgtype",
                                    @"0",@"msgtouid",
                                    self.titleTextField.text,@"title",
                                    self.contentTextView.text,@"message",
                                    @" ",@"phone",
                                    nil];
 
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HaoConnect request:@"sys_pms/add" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [MBProgressHUD showSuccess:@"提交成功" ToView:nil];
            [self performSelector:@selector(gotoback) withObject:nil afterDelay:1.0f];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];

  
}
-(void)gotoback{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    [_contentTextView resignFirstResponder];
}


#pragma mark --- textView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.contentTextView.text.length >= self.contentTextView.maxLength && text.length > 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"反馈内容不能超过%lu个字", self.contentTextView.maxLength] ToView:nil];
        return NO;
    }else
    {
        self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.contentTextView.text.length, self.contentTextView.maxLength]];
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
