//
//  PositionSubscriberViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "PositionSubscriberViewController.h"
#import "PositionSubscriberListViewController.h"
#import "ChooseIndustryViewController.h"
#import "ChooseJobPositionViewController.h"
#import "HaoConnect.h"
#import "PositionSubscriberModel.h"
#import "PositionSubscriberTableViewCell.h"
#import "SWMutableDataPicker.h"
#import "JobPositionChooseCityViewController.h"

@interface PositionSubscriberViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<PositionSubscriberModel *> *tableViewDataSource;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) SWMutableDataPicker *mutableDataPicker;
// 工作性质数据源
@property (strong, nonatomic) NSArray *jobsNatureDataSource;
// 行业领域数据源
@property (strong, nonatomic) NSArray *tradeDataSource;
// 职能类别数据源
@property (strong, nonatomic) NSArray *positionCategoryDataSource;
// 地区数据源
@property (strong, nonatomic) NSArray *areaDataSource;
// 公司性质数据源
@property (strong, nonatomic) NSArray *companyTypeDataSource;
// 公司规模数据源
@property (strong, nonatomic) NSArray *companyScaleDataSource;
// 月薪范围数据源
@property (strong, nonatomic) NSArray *wageCategoryDataSource;

// req
@property (strong, nonatomic) NSString *req_jobsNature; // 工作性质
@property (strong, nonatomic) NSString *req_topclass; // 期望行业
@property (strong, nonatomic) NSString *req_category; // 一级职位
@property (strong, nonatomic) NSString *req_subclass; // 二级职位
@property (strong, nonatomic) NSString *req_companyType;
@property (strong, nonatomic) NSString *req_companyScale;
@property (strong, nonatomic) NSString *req_area;
@property (strong, nonatomic) NSString *req_startWage;
@property (strong, nonatomic) NSString *req_endWage;

@end

@implementation PositionSubscriberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"职位订阅器";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"PositionSubscriberTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PositionSubscriberTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    if ([NSValueToString(self.subscriberID) length] > 0) {
        [self requestDetailSubscriberData];
    } else
    {
        [self setupDataSourceWithSubscriberInfoData:nil];
    }

    [self requestCategoryDataWithAliasStr:@"DW_jobs_nature" completeBlock:^(NSArray *data){
        self.jobsNatureDataSource = data;
        [self requestCategoryDataWithAliasStr:@"DW_company_type" completeBlock:^(NSArray *data){
            self.companyTypeDataSource = data;
            [self requestCategoryDataWithAliasStr:@"DW_scale" completeBlock:^(NSArray *data){
                self.companyScaleDataSource = data;
                NSMutableArray *wage = [NSMutableArray arrayWithCapacity:1];
                for (int i = 1000; i <= 50000; i+=1000) {
                    [wage addObject:@{@"cName":[NSString stringWithFormat:@"%d", i]}];
                }
                self.wageCategoryDataSource = wage;
            }];
        }];
    }];
}


// request
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
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (void)requestDetailSubscriberData
{
    if ([NSValueToString(self.subscriberID) length] < 1) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               self.subscriberID,@"id",
               nil];
    [HaoConnect request:@"job_subscriber_conf/detail" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [self setupDataSourceWithSubscriberInfoData:result.results];
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
    if (!validInfo(self.req_jobsNature) || !validInfo(self.req_topclass) || !validInfo(self.req_category) || !validInfo(self.req_subclass) || !validInfo(self.req_area)) {
        NSString * errorInfo = nil;
        if (!validInfo(self.req_jobsNature)) {
            errorInfo = @"请选择工作性质";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_topclass)) {
            errorInfo = @"请选择行业领域";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_subclass)) {
            errorInfo = @"请选择职能";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_area)) {
            errorInfo = @"请选择地区";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
            
        }
        
        return NO;
    } else
    {
        if (trimming(self.req_startWage).length > 0 && trimming(self.req_endWage).length < 1) {
            [MBProgressHUD showError:@"请选择最高月薪" ToView:nil];
            return NO;
        }
        if (trimming(self. req_endWage).length > 0 && trimming(self.req_startWage).length < 1) {
            [MBProgressHUD showError:@"请选择最低月薪" ToView:nil];
            return NO;
        }
        if (trimming(self.req_startWage).length > 0 && trimming(self.req_endWage).length > 0) {
//            if (strcmp([self.req_startWage UTF8String], [self.req_endWage UTF8String]) > 0) {
//                [MBProgressHUD showError:@"月薪范围选择不正确" ToView:nil];
//                return NO;
//            }
            if ([self.req_startWage floatValue] >= [self.req_endWage floatValue]) {
                [MBProgressHUD showError:@"月薪范围选择不正确" ToView:nil];
                return NO;
            }

            
        }
        return YES;
    }
}

- (void)requestAddOrUpdateSubscriber
{
    
    [self.view endEditing:YES];
    if ([self reqBefore] == NO) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"optype",
               NSValueToString(self.req_jobsNature),@"nature",
               @"工作性质",@"nature_desc",
               NSValueToString(self.req_topclass),@"topclass",
               @"行业领域",@"topclass_desc",
               NSValueToString(self.req_category),@"category",
               @"一级职能",@"category_desc",
               NSValueToString(self.req_subclass),@"subclass",
               @"二级职能",@"subclass_desc",
               NSValueToString(self.req_area),@"sdistrict",
               @"选择地区",@"sdistrict_desc",
               nil];
    if ([NSValueToString(self.subscriberID) length] > 0) {
        [exprame setObject:NSValueToString(self.subscriberID) forKey:@"id"];
    }
    if ([NSValueToString(self.req_companyType) length] > 0) {
        [exprame setObject:NSValueToString(self.req_companyType) forKey:@"company_type"];
        [exprame setObject:@"公司性质" forKey:@"company_type_desc"];
    }
    if ([NSValueToString(self.req_companyScale) length] > 0) {
        [exprame setObject:NSValueToString(self.req_companyScale) forKey:@"scale"];
        [exprame setObject:@"公司规模" forKey:@"scale_desc"];
    }
    if ([NSValueToString(self.req_startWage) length] > 0 && [NSValueToString(self.req_endWage) length] > 0) {
        [exprame setObject:NSValueToString(self.req_startWage) forKey:@"wage_begin"];
        [exprame setObject:@"月薪范围" forKey:@"wage_begin_desc"];
        [exprame setObject:NSValueToString(self.req_endWage) forKey:@"wage_end"];
        [exprame setObject:@"月薪范围" forKey:@"wage_end_desc"];
    }

    [HaoConnect request:@"job_subscriber_conf/update_conf_d_batch" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [MBProgressHUD showSuccess:@"提交成功" ToView:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kPositionSubscriberRefreshDataNotification object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}


#pragma mark --- button action

- (IBAction)clickCommitButtonAction:(id)sender {
    
    [self requestAddOrUpdateSubscriber];
}


- (void)setupDataSourceWithSubscriberInfoData:(NSDictionary *)infoData
{
    if (infoData && [infoData isKindOfClass:[NSDictionary class]]) {
        if (infoData[@"nature"] && [infoData[@"nature"] isKindOfClass:[NSArray class]]) {
            self.req_jobsNature = NSValueToString([infoData[@"nature"] firstObject]);
        }
        self.req_topclass = NSValueToString(infoData[@"topclass"]);
        self.req_category = NSValueToString(infoData[@"category"]);
        self.req_subclass = NSValueToString(infoData[@"subclass"]);
        self.req_area = NSValueToString(infoData[@"sdistrict"]);
        self.req_companyType = NSValueToString(infoData[@"companyType"]);
        self.req_companyScale = NSValueToString(infoData[@"scale"]);
        self.req_startWage = NSValueToString(infoData[@"wageBegin"]);
        self.req_endWage = NSValueToString(infoData[@"wageEnd"]);
    }
    NSArray *titles = @[@{@"title":@"工作性质",@"requestKey":@""},
                        @{@"title":@"行业领域",@"requestKey":@"topclassLocal"},
                        @{@"title":@"职能类别",@"requestKey":@"subclassLocal"},
                        @{@"title":@"选择地区",@"requestKey":@"sdistrictLocal"},
                        @{@"title":@"公司性质",@"requestKey":@"companyTypeLocal"},
                        @{@"title":@"公司规模",@"requestKey":@"scaleLocal"},
                        @{@"title":@"月薪范围",@"requestKey":@""}];
    [titles enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PositionSubscriberModel *model = [[PositionSubscriberModel alloc] init];
        model.title = obj[@"title"];
        if (idx == 0 || idx == 1 || idx == 2 || idx == 3) {
            model.required = YES;
        } else
        {
            model.required = NO;
        }
        
        if (idx == titles.count - 1) {
            model.needShowLeftChooseView = YES;
        } else
        {
            model.needShowLeftChooseView = NO;
        }
        if (idx == 0) {
            
            if (infoData[@"natureLocal"] && [infoData[@"natureLocal"] isKindOfClass:[NSArray class]]) {
                model.value = NSValueToString([infoData[@"natureLocal"] firstObject]);
            }

        } else if (idx == 6)
        {
            model.value = NSValueToString(infoData[@"wageBegin"]);
            model.subValue = NSValueToString(infoData[@"wageEnd"]);
        } else
        {
            model.value = NSValueToString(infoData[obj[@"requestKey"]]);
        }
        [self.tableViewDataSource addObject:model];
    }];
    [self.tableView reloadData];
}

#pragma mark --- getter

- (NSMutableArray<PositionSubscriberModel *> *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _tableViewDataSource;
}
- (SWMutableDataPicker *)mutableDataPicker
{
    if (!_mutableDataPicker) {
        
        _mutableDataPicker  = [[SWMutableDataPicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _mutableDataPicker;
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
    PositionSubscriberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PositionSubscriberTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row + 1 == self.tableViewDataSource.count) {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0XD7D7D7"];
    } else
    {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0XF0F0F0"];
    }
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    
    if ([model.title isEqualToString:@"工作性质"]) {
        cell.didClickedRightChooseButtonBlock = ^{
            [self jobsNatureCellActionWithIndexPath:indexPath];
        };
    } else if ([model.title isEqualToString:@"行业领域"])
    {
        cell.didClickedRightChooseButtonBlock = ^{
            [self tradeCellActionWithIndexPath:indexPath];
        };
        
    } else if ([model.title isEqualToString:@"职能类别"])
    {
        cell.didClickedRightChooseButtonBlock = ^{
            [self positionCategoryCellActionWithIndexPath:indexPath];
        };
        
    }else if ([model.title isEqualToString:@"选择地区"])
    {
        cell.didClickedRightChooseButtonBlock = ^{
            [self areaCellActionWithIndexPath:indexPath];
        };
        
    } else if ([model.title isEqualToString:@"公司性质"])
    {
        cell.didClickedRightChooseButtonBlock = ^{
             [self companyTypeCellActionWithIndexPath:indexPath];
        };
       
    } else if ([model.title isEqualToString:@"公司规模"])
    {
        cell.didClickedRightChooseButtonBlock = ^{
            [self companyScaleCellActionWithIndexPath:indexPath];
        };
       
    } else if ([model.title isEqualToString:@"月薪范围"])
    {
        JiaCoreWeakSelf(self);
        cell.didClickedLeftChooseButtonBlock = ^{
            [self wageCategoryCellActionWithIndexPath:indexPath completeBlock:^(NSDictionary *rowDataInFirstComponent) {
                model.value = rowDataInFirstComponent[@"cName"];
                weakself.req_startWage = rowDataInFirstComponent[@"cName"];
                [weakself.tableView reloadData];
            }];
        };
        
        cell.didClickedRightChooseButtonBlock = ^{
            [self wageCategoryCellActionWithIndexPath:indexPath completeBlock:^(NSDictionary *rowDataInFirstComponent) {
                model.subValue = rowDataInFirstComponent[@"cName"];
                weakself.req_endWage = rowDataInFirstComponent[@"cName"];
                [weakself.tableView reloadData];
            }];
        };
        
    }
    
    [cell setModel:model];
    return cell;
}


#pragma mark --- cell Action

- (void)jobsNatureCellActionWithIndexPath:(NSIndexPath *)indexPath
{
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"cName"];
        weakself.req_jobsNature = rowDataInFirstComponent[@"id"];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:self.jobsNatureDataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
}
- (void)tradeCellActionWithIndexPath:(NSIndexPath *)indexPath
{
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    PositionSubscriberModel *positionModel = self.tableViewDataSource[indexPath.row + 1];
    ChooseIndustryViewController *chooseIndustryVC = [[ChooseIndustryViewController alloc] init];
    chooseIndustryVC.industryID = self.req_topclass;
    chooseIndustryVC.completeChooseBlock = ^(NSString *industryName, NSString *industryID)
    {
        model.value = industryName;
        self.req_topclass = industryID;
        positionModel.value = @"";
        self.req_category = @"";
        self.req_subclass = @"";
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:chooseIndustryVC animated:YES];

   
}
- (void)positionCategoryCellActionWithIndexPath:(NSIndexPath *)indexPath
{
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    if ([NSValueToString(self.req_topclass) length] == 0) {
        [MBProgressHUD showError:@"请先选择行业" ToView:nil];
        return;
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
}
- (void)areaCellActionWithIndexPath:(NSIndexPath *)indexPath
{
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    JobPositionChooseCityViewController *chooseCityVC = [[JobPositionChooseCityViewController alloc] init];
    chooseCityVC.isorNotShowQuanGuo = YES;
    [chooseCityVC setCompleteChooseCityBlock:^(NSString *cityName, NSString *cityID) {
        model.value = cityName;
        self.req_area = cityID;
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:chooseCityVC animated:YES];

}
- (void)companyTypeCellActionWithIndexPath:(NSIndexPath *)indexPath
{
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"cName"];
        weakself.req_companyType = rowDataInFirstComponent[@"id"];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:self.companyTypeDataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
}
- (void)companyScaleCellActionWithIndexPath:(NSIndexPath *)indexPath
{
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"cName"];
        weakself.req_companyScale = rowDataInFirstComponent[@"id"];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:self.companyScaleDataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
}
- (void)wageCategoryCellActionWithIndexPath:(NSIndexPath *)indexPath completeBlock:(void(^)(NSDictionary *rowDataInFirstComponent))block
{
    PositionSubscriberModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";

    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        if (block) {
            block(rowDataInFirstComponent);
        }
    };
    [self.mutableDataPicker showPickerWithDataSource:self.wageCategoryDataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
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
