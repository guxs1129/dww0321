//
//  CreateRecruitmentEducationInfoViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CreateRecruitmentEducationInfoViewController.h"
#import "CreateRecruitmentJobExperienceViewController.h"
#import "UIViewController+KeyBoardManager.h"
#import "RecruitmentInfoTableViewCell.h"
#import "SWDatePickerAppearance.h"
#import "SWMutableDataPicker.h"

// @"学校名称", @"所学专业", @"就读时间", @"学   历", @"是否统招"
#define kCellTitleSchoolName @"学校名称"
#define kCellTitleProfession @"所学专业"
#define kCellTitleTime       @"就读时间"
#define kCellTitleEducation  @"学   历"
#define kCellTitleNature     @"是否统招"

@interface CreateRecruitmentEducationInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<RecruitmentInfoCellModel *> *tableViewDataSource;

@property (strong, nonatomic) SWMutableDataPicker *mutableDataPicker;
@property (strong, nonatomic) NSArray *educationDataSource;

// req_str
@property (strong, nonatomic) NSString *req_school;
@property (strong, nonatomic) NSString *req_major_desc; // 专业
@property (strong, nonatomic) NSString *req_start_date; // 就读开始时间
@property (strong, nonatomic) NSString *req_end_date; // 就读结束时间如2016年11月
@property (strong, nonatomic) NSString *req_education; // 一级地区id
@property (strong, nonatomic) NSString *req_edu_type; // 是否统招：1是，0否

@end

@implementation CreateRecruitmentEducationInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"教育经历";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.tableHeaderView = self.headerView;
    if (self.isEditing) {
        self.tableView.tableFooterView = [UIView new];
        self.tableView.tableHeaderView = [UIView new];
    }
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.rt_disableInteractivePop = YES;
    [self setupDataSource];
}

- (void)setupDataSource
{
    if (self.educationData && [self.educationData isKindOfClass:[NSDictionary class]] && self.educationData.count > 0) {
        self.resumeID = NSValueToString(self.educationData[@"resumeID"]);
        self.req_school = NSValueToString(self.educationData[@"school"]);
        self.req_major_desc = NSValueToString(self.educationData[@"majorDesc"]);
        self.req_start_date = NSValueToString(self.educationData[@"startDate"]);
        self.req_end_date = NSValueToString(self.educationData[@"endDate"]);
        self.req_education = NSValueToString(self.educationData[@"education"]);
        self.req_edu_type = NSValueToString(self.educationData[@"eduType"]);

    }
    NSArray *titles = @[@{@"title":kCellTitleSchoolName,@"requestKey":@"school"},
                        @{@"title":kCellTitleProfession,@"requestKey":@"majorDesc"},
                        @{@"title":kCellTitleTime,@"requestKey":@""},
                        @{@"title":kCellTitleEducation,@"requestKey":@"educationCn"},
                        @{@"title":kCellTitleNature,@"requestKey":@"eduType"}];
    [titles enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RecruitmentInfoCellModel *model = [[RecruitmentInfoCellModel alloc] init];
        model.title = obj[@"title"];
        if (self.educationData && [self.educationData isKindOfClass:[NSDictionary class]]) {
            model.value = NSValueToString(self.educationData[obj[@"requestKey"]]);
        }
        model.required = YES;
        if (idx == 0 || idx == 1) {
            model.cellType = RecruitmentInfoCellTypeTextField;
        } else if(idx == 4)
        {
            model.cellType = RecruitmentInfoCellTypeSingleChoose;
            model.singleChooseLeftButtonTitle = @"是";
            model.singleChooseRightButtonTitle = @"否";
        } else if(idx == 3)
        {
            model.cellType = RecruitmentInfoCellTypeShowRightChooseView;
        } else
        {
            model.cellType = RecruitmentInfoCellTypeShowAllChooseView;
            if (self.educationData && [self.educationData isKindOfClass:[NSDictionary class]]) {
                model.value = NSValueToString(self.educationData[@"startDate"]);
                model.subValue = NSValueToString(self.educationData[@"endDate"]);
            }
        }
        
        
        [self.tableViewDataSource addObject:model];
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
        [stepBtn setTitle:@"2/5" forState:UIControlStateNormal];
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
    if (!validInfo(self.resumeID) || !validInfo(self.req_school) || !validInfo(self.req_major_desc) || !validInfo(self.req_start_date) || !validInfo(self.req_end_date) || !validInfo(self.req_education) || !validInfo(self.req_edu_type)) {
        NSString * errorInfo = nil;
        if (!validInfo(self.req_school)) {
            errorInfo = @"请填写学校名称";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_major_desc)) {
            errorInfo = @"请填写所学专业";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_start_date)) {
            errorInfo = @"请选择就读时间";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_education)) {
            errorInfo = @"请选择学历";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_edu_type)) {
            errorInfo = @"请选择教育类型";
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
               self.req_school,@"school",
               self.req_major_desc,@"major_desc",
               self.req_start_date,@"start_date",
               self.req_end_date,@"end_date",
               self.req_education,@"education",
               self.req_edu_type,@"edu_type",
               
               nil];
    NSString *request = @"job_resume_education/add";
    if ([NSValueToString(self.educationInfoID) length] > 0) {
        request = @"job_resume_education/update";
        [exprame setObject:NSValueToString(self.educationInfoID) forKey:@"id"];
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

#pragma mark --- button action

- (IBAction)clickFooterViewButtonAction:(id)sender {
    
    [self requestUpdateOrAddBaseInfoWithSuccessBlock:^(NSDictionary *result) {
        
        self.educationInfoID = NSValueToString(result[@"id"]);
        [self requestInfoWithRequest:@"job_resume_work/list" successBlock:^(NSArray *data) {
            CreateRecruitmentJobExperienceViewController *jobExperienceVC = [[CreateRecruitmentJobExperienceViewController alloc] init];
            jobExperienceVC.resumeID = self.resumeID;
            if (data && [data isKindOfClass:[NSArray class]] && data.count > 0) {
                jobExperienceVC.jobExperienceID = NSValueToString(data.firstObject[@"id"]);
                jobExperienceVC.jobExperienceData = data.firstObject;
            }
            [self.navigationController pushViewController:jobExperienceVC animated:YES];
        }];
        
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
    if ([model.title isEqualToString:kCellTitleTime]) {
        cell.didClickRightChooseButtonBlock = ^
        {
            NSString *formatStr = @"yyyy年MM月";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            NSDate * currentData = [NSDate date];
            if (_req_end_date.length > 0) {
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
            if (_req_start_date.length > 0) {
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
    } else if ([model.title isEqualToString:kCellTitleEducation])
    {
        cell.didClickRightChooseButtonBlock = ^{
            
            if (self.educationDataSource && self.educationDataSource.count > 0) {
                [self educationCellActionWithIndexPath:indexPath dataSource:self.educationDataSource];
            } else
            {
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSMutableDictionary * exprame  = nil;
                exprame = @{@"page":@"1",@"size":@"999",@"c_alias":@"DW_education"}.mutableCopy;
                [HaoConnect request:@"pub_category_group_d/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if (result.isResultsOK) {
                        self.educationDataSource = result.results;
                        [self educationCellActionWithIndexPath:indexPath dataSource:self.educationDataSource];
                    }
                    
                } onError:^(HaoResult *errorResult) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }];
            }
            
        };
    } else if ([model.title isEqualToString:kCellTitleNature])
    {
        cell.didClickSingleLeftChooseButtonBlock = ^
        {
            self.req_edu_type = @"1";
            model.value = @"1";
        };
        cell.didClickSingleRightChooseButtonBlock = ^
        {
            self.req_edu_type = @"0";
            model.value = @"0";
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
    return cell;
}


#pragma mark --- cell Action

- (void)educationCellActionWithIndexPath:(NSIndexPath *)indexPath dataSource:(NSArray *)dataSource
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"cName"];
        weakself.req_education = rowDataInFirstComponent[@"cID"];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:dataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
}

#pragma mark --- getter

- (NSMutableArray<RecruitmentInfoCellModel *> *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _tableViewDataSource;
}

- (NSArray *)educationDataSource
{
    if (!_educationDataSource) {
        _educationDataSource = [NSArray array];
    }
    return _educationDataSource;
}

- (SWMutableDataPicker *)mutableDataPicker
{
    if (!_mutableDataPicker) {
        
        _mutableDataPicker  = [[SWMutableDataPicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _mutableDataPicker;
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
    if ([model.title isEqualToString:kCellTitleSchoolName]) {
        model.value = textField.text;
        self.req_school = textField.text;
    } else if ([model.title isEqualToString:kCellTitleProfession])
    {
        model.value = textField.text;
        self.req_major_desc = textField.text;
    }     
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
