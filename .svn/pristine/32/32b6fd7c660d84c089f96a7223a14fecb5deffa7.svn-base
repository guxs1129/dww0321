//
//  CreateRecruitmentIobintensionViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CreateRecruitmentJobintensionViewController.h"
#import "CreateRecruitmentPrivateSettingViewController.h"
#import "ChooseIndustryViewController.h"
#import "ChooseJobPositionViewController.h"
#import "RecruitmentInfoTableViewCell.h"
#import "SWMutableDataPicker.h"
#import "JobPositionChooseCityViewController.h"

@interface CreateRecruitmentJobintensionViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<RecruitmentInfoCellModel *> *tableViewDataSource;
@property (strong, nonatomic) SWMutableDataPicker *mutableDataPicker;
@property (strong, nonatomic) NSArray *jobNatureDataSource;
@property (strong, nonatomic) NSArray *jobWageDataSource;

// req_str
@property (strong, nonatomic) NSString *req_topclass; // 期望行业
@property (strong, nonatomic) NSString *req_category; // 一级职位
@property (strong, nonatomic) NSString *req_subclass; // 二级职位
@property (strong, nonatomic) NSString *req_wageID; // 期望薪资
@property (strong, nonatomic) NSString *req_wage_month; // 月薪
@property (strong, nonatomic) NSString *req_sdistrict; // 工作地点
@property (strong, nonatomic) NSString *req_nature; // 工作性质

@end

@implementation CreateRecruitmentJobintensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"求职意向";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footerView;
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
        [stepBtn setTitle:@"4/5" forState:UIControlStateNormal];
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
    if (!validInfo(self.resumeID) || !validInfo(self.req_topclass) || !validInfo(self.req_category) || !validInfo(self.req_sdistrict) || !validInfo(self.req_nature) || !validInfo(self.req_wageID)) {
        
        NSString * errorInfo = nil;
        if (!validInfo(self.req_topclass)) {
            errorInfo = @"请选择期望行业";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_category)) {
            errorInfo = @"请选择期望职能";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_sdistrict)) {
            errorInfo = @"请选择期望地点";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_nature)) {
            errorInfo = @"请选择工作性质";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_wageID)) {
            errorInfo = @"请选择期望月薪";
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
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               self.resumeID,@"resume_id",
               self.req_topclass,@"topclass",
               self.req_category,@"category",
               self.req_subclass,@"subclass",
               self.req_sdistrict,@"sdistrict",
               self.req_nature,@"nature",
               self.req_wageID,@"wageid",
               nil];
    NSString *request = @"job_resume_position/add";
    if ([NSValueToString(self.jobIntensionID) length] > 0) {
        request = @"job_resume_position/update";
        [exprame setObject:NSValueToString(self.jobIntensionID) forKey:@"id"];
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

- (void)setupDataSource
{
    if (self.jobIntensionData && [self.jobIntensionData isKindOfClass:[NSDictionary class]] && self.jobIntensionData.count > 0) {
        self.resumeID = NSValueToString(self.jobIntensionData[@"resumeID"]);
        self.req_topclass = NSValueToString(self.jobIntensionData[@"topclass"]);
        self.req_category = NSValueToString(self.jobIntensionData[@"category"]);
        self.req_subclass = NSValueToString(self.jobIntensionData[@"subclass"]);
        self.req_sdistrict = NSValueToString(self.jobIntensionData[@"sdistrict"]);
        if (self.jobIntensionData[@"resumeBaseInfo"] && [self.jobIntensionData isKindOfClass:[NSDictionary class]]) {
            self.req_nature = NSValueToString(self.jobIntensionData[@"resumeBaseInfo"][@"nature"]);
        }
        
        self.req_wageID = NSValueToString(self.jobIntensionData[@"wageid"]);


    }
    NSArray *titles = @[@{@"title":@"期望行业",@"requestKey":@"topClassLabel"},
                        @{@"title":@"期望职能",@"requestKey":@"subclassLabel"},
                        @{@"title":@"期望地点",@"requestKey":@"sdistrictName"},
                        @{@"title":@"工作性质",@"requestKey":@""},
                        @{@"title":@"期望月薪",@"requestKey":@""}];
    [titles enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RecruitmentInfoCellModel *model = [[RecruitmentInfoCellModel alloc] init];
        model.title = obj[@"title"];
        if (self.jobIntensionData && [self.jobIntensionData isKindOfClass:[NSDictionary class]]) {
            if ([model.title isEqualToString:@"工作性质"]) {
                if (self.jobIntensionData[@"resumeBaseInfo"] && [self.jobIntensionData isKindOfClass:[NSDictionary class]]) {
                    model.value = NSValueToString(self.jobIntensionData[@"resumeBaseInfo"][@"natureCn"]);
                }
            }else if ([model.title isEqualToString:@"期望月薪"])
            {
                if ([NSValueToString(self.jobIntensionData[@"wageBegin"]) length] > 0 && [NSValueToString(self.jobIntensionData[@"wageEnd"]) length] > 0) {
                    model.value = [NSString stringWithFormat:@"%@~%@元/月", NSValueToString(self.jobIntensionData[@"wageBegin"]), NSValueToString(self.jobIntensionData[@"wageEnd"])];
                } else if([NSValueToString(self.jobIntensionData[@"wageBegin"]) length] > 0 && [NSValueToString(self.jobIntensionData[@"wageEnd"]) length] < 1)
                {
                    model.value = [NSString stringWithFormat:@"%@元/月", NSValueToString(self.jobIntensionData[@"wageBegin"])];
                }
                
            }
            else
            {
                model.value = NSValueToString(self.jobIntensionData[obj[@"requestKey"]]);
            }

        }
        model.required = YES;
        model.cellType = RecruitmentInfoCellTypeShowRightChooseView;
        
        [self.tableViewDataSource addObject:model];
    }];
}


#pragma mark --- button action

- (IBAction)clickFooterViewButtonAction:(id)sender {
    
    [self requestUpdateOrAddBaseInfoWithSuccessBlock:^(NSDictionary *result) {
        self.jobIntensionID = NSValueToString(result[@"id"]);
        CreateRecruitmentPrivateSettingViewController *privateSettingVC = [[CreateRecruitmentPrivateSettingViewController alloc] init];
        privateSettingVC.resumeID = self.resumeID;
        [self.navigationController pushViewController:privateSettingVC animated:YES];
    }];
}

- (void)requestCategoryDataWithAliasStr:(NSString *)aliasStr completeBlock:(void(^)(NSArray *data))completeBlock
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               aliasStr,@"c_alias",
               nil];
    [HaoConnect request:@"pub_category_group_d/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (completeBlock) {
                completeBlock(result.results);
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
   

    cell.didClickRightChooseButtonBlock = nil;
    cell.didClickLeftChooseButtonBlock = nil;
    cell.didClickSingleLeftChooseButtonBlock = nil;
    cell.didClickSingleRightChooseButtonBlock = nil;
    if ([model.title isEqualToString:@"期望地点"])
    {
        cell.didClickRightChooseButtonBlock = ^{
            JobPositionChooseCityViewController *chooseCityVC = [[JobPositionChooseCityViewController alloc] init];
            [chooseCityVC setCompleteChooseCityBlock:^(NSString *cityName, NSString *cityID) {
                RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
                model.value = cityName;
                self.req_sdistrict = cityID;
                [self.tableView reloadData];
            }];
            [self.navigationController pushViewController:chooseCityVC animated:YES];
        };
        
    } else if ([model.title isEqualToString:@"工作性质"])
    {
        cell.didClickRightChooseButtonBlock = ^{
            
            if (self.jobNatureDataSource && self.jobNatureDataSource.count > 0) {
                [self jobNatureCellActionWithIndexPath:indexPath dataSource:self.jobNatureDataSource];
            } else
            {
                [self requestCategoryDataWithAliasStr:@"DW_jobs_nature" completeBlock:^(NSArray *data) {
                    self.jobNatureDataSource = data;
                    [self jobNatureCellActionWithIndexPath:indexPath dataSource:self.jobNatureDataSource];
                }];
            }
            
        };
    } else if ([model.title isEqualToString:@"期望月薪"])
    {
        cell.didClickRightChooseButtonBlock = ^{
            
            if (self.jobWageDataSource && self.jobWageDataSource.count > 0) {
                [self jobWageCellActionWithIndexPath:indexPath dataSource:self.jobWageDataSource];
            } else
            {
                [self requestCategoryDataWithAliasStr:@"DW_wage" completeBlock:^(NSArray *data) {
                    self.jobWageDataSource = data;
                    [self jobWageCellActionWithIndexPath:indexPath dataSource:self.jobWageDataSource];
                }];

            }
            
        };
    } else if ([model.title isEqualToString:@"期望行业"])
    {
        cell.didClickRightChooseButtonBlock = ^{
            ChooseIndustryViewController *chooseIndustryVC = [[ChooseIndustryViewController alloc] init];
            chooseIndustryVC.industryID = self.req_topclass;
            chooseIndustryVC.completeChooseBlock = ^(NSString *industryName, NSString *industryID)
            {
                model.value = industryName;
                self.req_topclass = industryID;
                RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row + 1];
                model.value = @"";
                self.req_category = @"";
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:chooseIndustryVC animated:YES];
            
        };
    } else if ([model.title isEqualToString:@"期望职能"])
    {
        cell.didClickRightChooseButtonBlock = ^{
            if ([NSValueToString(self.req_topclass) length] == 0) {
                [MBProgressHUD showError:@"请先选择行业" ToView:nil];
                return ;
            }
            ChooseJobPositionViewController *chooseJobPositionVC = [[ChooseJobPositionViewController alloc] init];
            chooseJobPositionVC.industryID = self.req_topclass;
            chooseJobPositionVC.firstJobPositionIDs = self.req_category;
            chooseJobPositionVC.secondJobPositionIDs = self.req_subclass;
            chooseJobPositionVC.maxSelectedCount = 1;
            chooseJobPositionVC.completeChoosePositionBlock = ^(NSArray *selectedPositionData){
                self.req_category = @"";
                self.req_subclass = @"";
                model.value = @"请选择";
                [selectedPositionData enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull data, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (self.req_subclass.length == 0) {
                        self.req_subclass = [NSString stringWithFormat:@"%@", data[@"id"]];
                        model.value = [NSString stringWithFormat:@"%@", data[@"categoryname"]];
                        self.req_category = [NSString stringWithFormat:@"%@", data[@"parentid"]];
                    } else
                    {
                        self.req_subclass = [NSString stringWithFormat:@"%@,%@", self.req_subclass, data[@"id"]];
                        model.value = [NSString stringWithFormat:@"%@,%@", model.value, data[@"categoryname"]];
                        if (![self.req_category containsString:NSValueToString(data[@"parentid"])]) {
                            self.req_category = [NSString stringWithFormat:@"%@,%@", self.req_category, data[@"parentid"]];
                        }
                    }
                }];
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:chooseJobPositionVC animated:YES];
        };
    }

    
    [cell setModel:model];
    return cell;
}


#pragma mark --- cell Action

- (void)jobWageCellActionWithIndexPath:(NSIndexPath *)indexPath dataSource:(NSArray *)dataSource
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"cName"];
        weakself.req_wageID = rowDataInFirstComponent[@"cID"];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:dataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
}
- (void)jobNatureCellActionWithIndexPath:(NSIndexPath *)indexPath dataSource:(NSArray *)dataSource
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"cName"];
        weakself.req_nature = rowDataInFirstComponent[@"cID"];
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

- (NSArray *)jobNatureDataSource
{
    if (!_jobNatureDataSource) {
        _jobNatureDataSource = [NSArray array];
    }
    return _jobNatureDataSource;
}

- (NSArray *)jobWageDataSource
{
    if (!_jobWageDataSource) {
        _jobWageDataSource = [NSArray array];
    }
    return _jobWageDataSource;
}

- (SWMutableDataPicker *)mutableDataPicker
{
    if (!_mutableDataPicker) {
        
        _mutableDataPicker  = [[SWMutableDataPicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _mutableDataPicker;
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
