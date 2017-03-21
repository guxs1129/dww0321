//
//  CreateProjectExperienceViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CreateProjectExperienceViewController.h"
#import "UIViewController+KeyBoardManager.h"
#import "RecruitmentInfoTableViewCell.h"
#import "SWDatePickerAppearance.h"
#import "UITextView+Custom.h"
#import "HaoConnect.h"

@interface CreateProjectExperienceViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UITextViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UITextView *projectContentTextView;
@property (strong, nonatomic) NSMutableArray<RecruitmentInfoCellModel *> *tableViewDataSource;

// req_str
@property (strong, nonatomic) NSString *req_projectName;
@property (strong, nonatomic) NSString *req_projectResponsibility; // 职责
@property (strong, nonatomic) NSString *req_start_date; // 开始时间
@property (strong, nonatomic) NSString *req_end_date; // 结束时间如2016年11月
@property (strong, nonatomic) NSString *req_projectContent; // 项目描述

@end

@implementation CreateProjectExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目经验";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;

    [self setupDataSource];
    
    [self configTextView];
}


- (void)configTextView
{
    UIToolbar * tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 44)];
    UIBarButtonItem * fixitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickKeboardDone)];
    tool.items =@[fixitem,item];
    
    self.projectContentTextView.inputAccessoryView = tool;
    self.projectContentTextView.delegate = self;
    
    self.projectContentTextView.placeHolder = @"请输入内容......";
    self.projectContentTextView.placeHolderTextColor = LIGHTTEXTCOLOR;
    self.projectContentTextView.maxLength = 500;
    
    if (self.projectExperienceData && [self.projectExperienceData isKindOfClass:[NSDictionary class]]) {
        self.projectContentTextView.text = NSValueToString(self.projectExperienceData[@"projectDesc"]);
    }
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.projectContentTextView.text.length, (unsigned long)self.projectContentTextView.maxLength]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCountLabelText) name:UITextViewTextDidChangeNotification object:nil];
}


- (void)changeCountLabelText
{
    self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.projectContentTextView.text.length, (unsigned long)self.projectContentTextView.maxLength]];
    if (self.projectContentTextView.text.length > self.projectContentTextView.maxLength) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"内容不能超过%lu个字", (unsigned long)self.projectContentTextView.maxLength] ToView:nil];
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
    if (self.projectExperienceData && [self.projectExperienceData isKindOfClass:[NSDictionary class]] && self.projectExperienceData.count > 0) {
        self.resumeID = NSValueToString(self.projectExperienceData[@"resumeID"]);
        self.req_projectName = NSValueToString(self.projectExperienceData[@"projectname"]);
        self.req_projectResponsibility = NSValueToString(self.projectExperienceData[@"projectRole"]);
        self.req_start_date = NSValueToString(self.projectExperienceData[@"startDate"]);
        self.req_end_date = NSValueToString(self.projectExperienceData[@"endDate"]);
        self.req_projectContent = NSValueToString(self.projectExperienceData[@"projectDesc"]);

    }
    NSArray *titles = @[@{@"title":@"项目时间",@"requestKey":@""},
                        @{@"title":@"项目名称",@"requestKey":@"projectname"},
                        @{@"title":@"项目职责",@"requestKey":@"projectRole"},
                        ];
    [titles enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RecruitmentInfoCellModel *model = [[RecruitmentInfoCellModel alloc] init];
        model.title = obj[@"title"];
        
        model.required = NO;
        if (idx == 0) {
            
            model.cellType = RecruitmentInfoCellTypeShowAllChooseView;
            if (self.projectExperienceData && [self.projectExperienceData isKindOfClass:[NSDictionary class]]) {
                model.value = NSValueToString(self.projectExperienceData[@"startDate"]);
                model.subValue = NSValueToString(self.projectExperienceData[@"endDate"]);
            }
        } else
        {
            model.cellType = RecruitmentInfoCellTypeTextField;
            if (self.projectExperienceData && [self.projectExperienceData isKindOfClass:[NSDictionary class]]) {
                model.value = NSValueToString(self.projectExperienceData[obj[@"requestKey"]]);
            }
        }

        [self.tableViewDataSource addObject:model];
    }];
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
    
    [self requestUpdateOrAddBaseInfoWithSuccessBlock:^(NSDictionary *result) {
        [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];

}

- (BOOL)reqBefore
{
    if (!validInfo(self.resumeID) || !validInfo(self.req_projectName) || !validInfo(self.req_projectResponsibility) || !validInfo(self.req_start_date) || !validInfo(self.req_end_date) || !validInfo(self.req_projectContent)) {
        NSString * errorInfo = nil;
        if (!validInfo(self.req_projectName)) {
            errorInfo = @"请填写项目名称";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_projectResponsibility)) {
            errorInfo = @"请填写项目职责";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_start_date)) {
            errorInfo = @"请选择时间";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_end_date)) {
            errorInfo = @"请选择时间";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_projectContent)) {
            errorInfo = @"请填写项目描述";
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
               self.req_projectName,@"projectname",
               self.req_projectResponsibility,@"project_role",
               self.req_start_date,@"start_date",
               self.req_end_date,@"end_date",
               self.req_projectContent,@"project_desc",
               nil];
    NSString *request = @"job_resume_project/add";
    if ([NSValueToString(self.projectExperienceID) length] > 0) {
        request = @"job_resume_project/update";
        [exprame setObject:NSValueToString(self.projectExperienceID) forKey:@"id"];
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
    return 50;
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
    if ([model.title isEqualToString:@"项目时间"]) {
        cell.didClickRightChooseButtonBlock = ^
        {
            NSString *formatStr = @"yyyy年MM月";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            NSDate * currentData = [NSDate date];
            if (_req_end_date.length>0) {
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
            if (_req_start_date.length>0) {
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
  
    [cell setModel:model];
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
    if ([model.title isEqualToString:@"项目名称"]) {
        model.value = textField.text;
        self.req_projectName = textField.text;
    } else if ([model.title isEqualToString:@"项目职责"])
    {
        model.value = textField.text;
        self.req_projectResponsibility = textField.text;
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
    self.req_projectContent = textView.text;
    [self uploadKeyBoardManager];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.projectContentTextView.text.length >= self.projectContentTextView.maxLength && text.length > 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"内容不能超过%lu个字", (unsigned long)self.projectContentTextView.maxLength] ToView:nil];
        return NO;
    }else
    {
        self.countLabel.attributedText = [self countLabelAttributedStringWithString:[NSString stringWithFormat:@"%lu/%lu字", (unsigned long)self.projectContentTextView.text.length, (unsigned long)self.projectContentTextView.maxLength]];
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
