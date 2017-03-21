//
//  CreateRecruitmentJobExperienceViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CreateRecruitmentJobExperienceViewController.h"
#import "CreateRecruitmentJobintensionViewController.h"
#import "UIViewController+KeyBoardManager.h"
#import "RecruitmentInfoTableViewCell.h"
#import "SWDatePickerAppearance.h"
#import "UITextView+Custom.h"
#import "HaoConnect.h"


@interface CreateRecruitmentJobExperienceViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UITextView *jobContentTextView;
@property (strong, nonatomic) NSMutableArray<RecruitmentInfoCellModel *> *tableViewDataSource;

// req_str
@property (strong, nonatomic) NSString *req_companyname;
@property (strong, nonatomic) NSString *req_jobs; // 职位
@property (strong, nonatomic) NSString *req_start_date; // 开始时间
@property (strong, nonatomic) NSString *req_end_date; // 结束时间如2016年11月
@property (strong, nonatomic) NSString *req_wage_month; // 月薪
@property (strong, nonatomic) NSString *req_achievements; // 工作内容
@property (strong, nonatomic) IBOutlet UIButton *nextStepButton;


@end

@implementation CreateRecruitmentJobExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工作经历";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.tableHeaderView = self.headerView;
    self.nextStepButton.hidden = YES;
    if (self.isEditing) {
        self.nextStepButton.hidden = YES;
        self.tableView.tableHeaderView = [UIView new];
    } else
    {
        self.nextStepButton.hidden = NO;
    }
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.rt_disableInteractivePop = YES;
    [self setupDataSource];
    
    [self configTextView];

}


- (void)configTextView
{
    UIToolbar * tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 44)];
    UIBarButtonItem * fixitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickKeboardDone)];
    tool.items =@[fixitem,item];
    
    self.jobContentTextView.inputAccessoryView = tool;
    self.jobContentTextView.delegate = self;
    
    self.jobContentTextView.placeHolder = @"示例 : \n1、主要负责新员工入职培训;\n2、分析制定员工每月个人销售业绩;\n3、帮助员工提高每日客单价,整体店面管理等工作";
    self.jobContentTextView.placeHolderTextColor = LIGHTTEXTCOLOR;
    self.jobContentTextView.maxLength = 300;
    
    if (self.jobExperienceData && [self.jobExperienceData isKindOfClass:[NSDictionary class]]) {
        self.jobContentTextView.text = NSValueToString(self.jobExperienceData[@"achievements"]);
    }
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.jobContentTextView.text.length, (unsigned long)self.jobContentTextView.maxLength]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCountLabelText) name:UITextViewTextDidChangeNotification object:nil];
}


- (void)changeCountLabelText
{
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.jobContentTextView.text.length, (unsigned long)self.jobContentTextView.maxLength]];
    if (self.jobContentTextView.text.length > self.jobContentTextView.maxLength) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"内容不能超过%lu个字", (unsigned long)self.jobContentTextView.maxLength] ToView:nil];
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

- (void)setupDataSource
{
    if (self.jobExperienceData && [self.jobExperienceData isKindOfClass:[NSDictionary class]] && self.jobExperienceData.count > 0) {
        self.resumeID = NSValueToString(self.jobExperienceData[@"resumeID"]);
        self.req_companyname = NSValueToString(self.jobExperienceData[@"companyname"]);
        self.req_jobs = NSValueToString(self.jobExperienceData[@"jobs"]);
        self.req_start_date = NSValueToString(self.jobExperienceData[@"startDate"]);
        self.req_end_date = NSValueToString(self.jobExperienceData[@"endDate"]);
        self.req_wage_month = NSValueToString(self.jobExperienceData[@"wageMonth"]);
        self.req_achievements = NSValueToString(self.jobExperienceData[@"achievements"]);
    }
    NSArray *titles = @[@{@"title":@"公司名称",@"requestKey":@"companyname"},
                        @{@"title":@"职位名称",@"requestKey":@"jobs"},
                        @{@"title":@"起止时间",@"requestKey":@""},
                        @{@"title":@"月薪",@"requestKey":@"wageMonth"}];
    [titles enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RecruitmentInfoCellModel *model = [[RecruitmentInfoCellModel alloc] init];
        model.title = obj[@"title"];
        
        model.required = YES;
        if (idx == 2) {
        
            model.cellType = RecruitmentInfoCellTypeShowAllChooseView;
            if (self.jobExperienceData && [self.jobExperienceData isKindOfClass:[NSDictionary class]]) {
                model.value = NSValueToString(self.jobExperienceData[@"startDate"]);
                model.subValue = NSValueToString(self.jobExperienceData[@"endDate"]);
            }
        } else
        {
            model.cellType = RecruitmentInfoCellTypeTextField;
            if (self.jobExperienceData && [self.jobExperienceData isKindOfClass:[NSDictionary class]]) {
                model.value = NSValueToString(self.jobExperienceData[obj[@"requestKey"]]);
            }
        }
        if (idx == 3) {
            model.required = NO;
        }
        
        [self.tableViewDataSource addObject:model];
    }];
}


#pragma mark --- button action

- (IBAction)clickFooterViewButtonAction:(id)sender {
    
   [self requestUpdateOrAddBaseInfoWithSuccessBlock:^(NSDictionary *result) {
       
       self.jobExperienceID = NSValueToString(result[@"id"]);
       [self requestInfoWithRequest:@"job_resume_position/list" successBlock:^(NSArray *data) {
           CreateRecruitmentJobintensionViewController *jobIntensionVC = [[CreateRecruitmentJobintensionViewController alloc] init];
           jobIntensionVC.resumeID = self.resumeID;
           if (data && [data isKindOfClass:[NSArray class]] && data.count > 0) {
               jobIntensionVC.jobIntensionID = NSValueToString(data.firstObject[@"id"]);
               jobIntensionVC.jobIntensionData = data.firstObject;
           }
           [self.navigationController pushViewController:jobIntensionVC animated:YES];
       }];
       
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
    if (self.isEditing) {
        [stepBtn setTitle:@"保存" forState:UIControlStateNormal];
    } else
    {
        [stepBtn setTitle:@"3/5" forState:UIControlStateNormal];
    }

    stepBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [stepBtn sizeToFit];
    [stepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return stepBtn;
}

- (void)right_button_event:(UIButton *)sender
{
    if (self.isEditing) {
        [self requestUpdateOrAddBaseInfoWithSuccessBlock:^(NSDictionary *result) {
            [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}


#pragma mark --- request
- (void)requestInfoWithRequest:(NSString *)requestStr successBlock:(void(^)(NSArray *data))completeBlcok
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               [DWUserDataManager standardUserDefaults].userID,@"uid",
               nil];
    if ([NSValueToString(self.resumeID) length] > 0) {
        [exprame setObject:NSValueToString(self.resumeID) forKey:@"resume_id"];
    }
    [HaoConnect request:requestStr params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (completeBlcok) {
                completeBlcok(result.results);
            }
            
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (BOOL)reqBefore
{
    if (!validInfo(self.resumeID) || !validInfo(self.req_companyname) || !validInfo(self.req_jobs) || !validInfo(self.req_start_date) || !validInfo(self.req_end_date)) {
        
        NSString * errorInfo = nil;
        if (!validInfo(self.req_companyname)) {
            errorInfo = @"请填写公司名称";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_jobs)) {
            errorInfo = @"请填写职位专业";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_start_date)||!validInfo(self.req_end_date)) {
            errorInfo = @"请选择工作时间";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }

        return NO;
    } else
    {

        return YES;
    }
}

- (void)requestUpdateOrAddBaseInfoWithSuccessBlock:(void(^)(NSDictionary *result))successBlock
{

    [self.view endEditing:YES];
    if ([self reqBefore] == NO) {
//        [MBProgressHUD showError:@"请完成填写" ToView:nil];
        return;
    }
    if (strcmp([self.req_start_date UTF8String], [self.req_end_date UTF8String]) > 0) {
        [MBProgressHUD showError:@"开始时间不能大于结束时间" ToView:nil];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               self.resumeID,@"resume_id",
               self.req_companyname,@"companyname",
               self.req_jobs,@"jobs",
               self.req_start_date,@"start_date",
               self.req_end_date,@"end_date",
               nil];
    NSString *request = @"job_resume_work/add";
    if ([NSValueToString(self.jobExperienceID) length] > 0) {
        request = @"job_resume_work/update";
        [exprame setObject:NSValueToString(self.jobExperienceID) forKey:@"id"];
    }
    if ([NSValueToString(self.req_wage_month) length] > 0) {
        [exprame setObject:NSValueToString(self.req_wage_month) forKey:@"wage_month"];
    }
    if ([NSValueToString(self.req_achievements) length] > 0) {
        [exprame setObject:NSValueToString(self.req_achievements) forKey:@"achievements"];
    }
    [HaoConnect request:request params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if (successBlock) {
                successBlock(result.results);
            }
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}


#pragma mark --- tableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewDataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecruitmentInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row + 1 == self.tableViewDataSource.count) {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0XD6D6D6"];
    } else
    {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0XF0F0F0"];
    }
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    cell.contentTextField.tag = indexPath.row;
    cell.contentTextField.delegate = self;
    
    cell.didClickRightChooseButtonBlock = nil;
    cell.didClickLeftChooseButtonBlock = nil;
    cell.didClickSingleLeftChooseButtonBlock = nil;
    cell.didClickSingleRightChooseButtonBlock = nil;
    if ([model.title isEqualToString:@"起止时间"]) {
        cell.didClickRightChooseButtonBlock = ^
        {
            NSString *formatStr = @"yyyy年MM月";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            NSDate * currentData = [NSDate date];
            if (_req_end_date.length >0) {
                currentData = [dateFormatter dateFromString:self.req_end_date];
            }
            formatStr = @"yyyy-MM";
            [dateFormatter setDateFormat:formatStr];

            SWDatePickerAppearance *picker = [[SWDatePickerAppearance alloc]initWithDatePickerMode:DatePickerYearMonthMode currentDate:currentData minDate:[dateFormatter dateFromString:@"1970-01"] maxDate:[NSDate date]  completeBlock:^(NSDate *date) {
                NSString *formatStr = @"yyyy年MM月";
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:formatStr];
                NSLog(@"%@",[dateFormatter stringFromDate:date]);
                self.req_end_date = [dateFormatter stringFromDate:date];
                RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
                model.subValue = self.req_end_date;
                [self.tableView reloadData];
            }];
            [picker show];
        };
        cell.didClickLeftChooseButtonBlock = ^
        {
            NSString *formatStr = @"yyyy年MM月";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            NSDate * currentData = [NSDate date];
            if (_req_start_date.length >0) {
                currentData = [dateFormatter dateFromString:self.req_start_date];
            }
            formatStr = @"yyyy-MM";
            [dateFormatter setDateFormat:formatStr];

            SWDatePickerAppearance *picker = [[SWDatePickerAppearance alloc]initWithDatePickerMode:DatePickerYearMonthMode currentDate:currentData minDate:[dateFormatter dateFromString:@"1970-01"] maxDate:[NSDate date]  completeBlock:^(NSDate *date) {
                NSString *formatStr = @"yyyy年MM月";
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:formatStr];
                NSLog(@"%@",[dateFormatter stringFromDate:date]);
                self.req_start_date = [dateFormatter stringFromDate:date];
                RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
                model.value = self.req_start_date;
                [self.tableView reloadData];
            }];
            [picker show];
        };
    }
    if (model.cellType == RecruitmentInfoCellTypeSingleChoose) {
        if ([model.value isEqualToString:@"1"]) {
            cell.singleLeftChooseBtn.selected = YES;
            cell.singleRightChooseBtn.selected = NO;
        } else if ([model.value isEqualToString:@"0"])
        {
            cell.singleLeftChooseBtn.selected = NO;
            cell.singleRightChooseBtn.selected = YES;
        } else
        {
            cell.singleLeftChooseBtn.selected = NO;
            cell.singleRightChooseBtn.selected = NO;
        }
    }
    [cell setModel:model];
    if ([model.title isEqualToString:@"月薪"]) {
        cell.contentTextField.placeholder = @"请填写 元 / 月";
        cell.contentTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:cell.contentTextField.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0X999999"]}];
    }
    return cell;
}




#pragma mark --- getter

- (NSMutableArray<RecruitmentInfoCellModel *> *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _tableViewDataSource;
}


#pragma mark --- textFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self setupForKeyboardWithScrolledView:self.tableView clickedView:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[textField.tag];
    if ([model.title isEqualToString:@"公司名称"]) {
        model.value = textField.text;
        self.req_companyname = textField.text;
    } else if ([model.title isEqualToString:@"职位名称"])
    {
        model.value = textField.text;
        self.req_jobs = textField.text;
    }else if ([model.title isEqualToString:@"月薪"])
    {
        model.value = textField.text;
        self.req_wage_month = textField.text;
    }
    [self uploadKeyBoardManager];
}

#pragma mark --- textView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self setupForKeyboardWithScrolledView:self.tableView clickedView:textView];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.req_achievements = textView.text;
    [self uploadKeyBoardManager];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.jobContentTextView.text.length >= self.jobContentTextView.maxLength && text.length > 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"内容不能超过%lu个字", (unsigned long)self.jobContentTextView.maxLength] ToView:nil];
        return NO;
    }else
    {
        self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.jobContentTextView.text.length, (unsigned long)self.jobContentTextView.maxLength]];
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
