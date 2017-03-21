//
//  AddLanguageLevelViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "AddLanguageLevelViewController.h"
#import "RecruitmentInfoTableViewCell.h"
#import "SWMutableDataPicker.h"

#define kCellTitleLanguageLevel @"语言程度"
#define kDefaultLeftButtonTitle @"请选择语言"
#define kDefaultRightButtonTitle @"请选择熟练程度"
@interface AddLanguageLevelViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray<RecruitmentInfoCellModel *> *tableViewDataSource;
@property (strong, nonatomic) NSMutableDictionary *selectedData;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) SWMutableDataPicker *mutableDataPicker;
@property (strong, nonatomic) NSMutableArray *languageCategoryDataSource;
@property (strong, nonatomic) NSMutableArray *languageLevelDataSource;

@end

@implementation AddLanguageLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加语言程度";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self setupDataSource];

}

- (void)setupDataSource
{
    if (self.languages && [self.languages isKindOfClass:[NSArray class]] && self.languages.count > 0) {
        [self.languages enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                RecruitmentInfoCellModel *model = [self createRecruitmentInfoModel];
                model.value = obj[@"languageCn"];
                model.subValue = obj[@"levelCn"];
                NSMutableDictionary *selectedRowData = self.selectedData[[NSString stringWithFormat:@"%ld", (unsigned long)idx]];
                if (kDictIsEmpty(selectedRowData)) {
                    selectedRowData = [NSMutableDictionary dictionaryWithCapacity:1];
                }
                [selectedRowData setObject:NSValueToString(obj[@"language"]) forKey:@"language"];
                [selectedRowData setObject:NSValueToString(obj[@"languageCn"]) forKey:@"languageCn"];
                [selectedRowData setObject:NSValueToString(obj[@"level"]) forKey:@"level"];
                [selectedRowData setObject:NSValueToString(obj[@"levelCn"]) forKey:@"levelCn"];
                [selectedRowData setObject:NSValueToString(obj[@"id"]) forKey:@"id"];
                [self.selectedData setObject:selectedRowData forKey:[NSString stringWithFormat:@"%ld", (unsigned long)idx]];
                [self.tableViewDataSource addObject:model];
                
            }
        }];
        
        
    } else{
        [self.tableViewDataSource addObject:[self createRecruitmentInfoModel]];

    }

}

- (IBAction)clickFooterViewAction:(id)sender {
    
    if (![self isAnyValueInTableViewDataSource]) {
        [self.tableViewDataSource addObject:[self createRecruitmentInfoModel]];
        [self.tableView reloadData];
    }
}

- (RecruitmentInfoCellModel *)createRecruitmentInfoModel
{
    RecruitmentInfoCellModel *model = [[RecruitmentInfoCellModel alloc] init];
    model.title = kCellTitleLanguageLevel;
    model.value = kDefaultLeftButtonTitle;
    model.subValue = kDefaultRightButtonTitle;
    model.cellType = RecruitmentInfoCellTypeShowAllChooseView;
    return model;
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
    NSMutableArray *selectedArray = [NSMutableArray arrayWithCapacity:1];
//    [self.selectedData enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSDictionary *  _Nonnull obj, BOOL * _Nonnull stop) {
//        if ([NSValueToString(obj[@"language"]) length] > 0 && [NSValueToString(obj[@"level"]) length] > 0) {
//            [selectedArray addObject:obj];
//        }
//    }];
    for (int i = 0; i < self.selectedData.allKeys.count; i++) {
        NSDictionary *obj = self.selectedData[[NSString stringWithFormat:@"%d", i]];
        if (obj && [obj isKindOfClass:[NSDictionary class]]) {
            if ([NSValueToString(obj[@"language"]) length] > 0 && [NSValueToString(obj[@"level"]) length] > 0) {
                [selectedArray addObject:obj];
            } else
            {
                [MBProgressHUD showError:@"您有未完成的信息" ToView:nil];
                return;
            }
        }
    }
    if (selectedArray.count > 0) {
        if ([NSValueToString(self.resumeID) length] < 1) {
            [MBProgressHUD showError:@"简历不存在" ToView:nil];
            return;
        }
        [self saveInfoActionWithInfoData:@{@"resume_id":NSValueToString(self.resumeID),@"languages":selectedArray} completeBlock:^{
            if (self.completeChooseBlock) {
                
                self.completeChooseBlock(selectedArray);
            }
            [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } else
    {
        [MBProgressHUD showError:@"请选择语言" ToView:nil];
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

#pragma mark --- getter

- (NSMutableArray<RecruitmentInfoCellModel *> *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _tableViewDataSource;
}

- (NSMutableDictionary *)selectedData
{
    if (!_selectedData) {
        _selectedData = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _selectedData;
}

- (NSMutableArray *)languageLevelDataSource
{
    if (!_languageLevelDataSource) {
        _languageLevelDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _languageLevelDataSource;
}

- (NSMutableArray *)languageCategoryDataSource
{
    if (!_languageCategoryDataSource) {
        _languageCategoryDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _languageCategoryDataSource;
}

- (SWMutableDataPicker *)mutableDataPicker
{
    if (!_mutableDataPicker) {
        
        _mutableDataPicker  = [[SWMutableDataPicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _mutableDataPicker;
}

- (BOOL)isAnyValueInTableViewDataSource
{
    __block BOOL anyValueIsEmpty = NO;
    [self.tableViewDataSource enumerateObjectsUsingBlock:^(RecruitmentInfoCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSValueToString(obj.value) length] < 1 || [NSValueToString(obj.subValue) length] < 1 || [NSValueToString(obj.value) isEqualToString:kDefaultLeftButtonTitle] || [NSValueToString(obj.subValue) isEqualToString:kDefaultRightButtonTitle]) {
            anyValueIsEmpty = YES;
            *stop = YES;
        }
    }];
    return anyValueIsEmpty;
}

#pragma mark --- tableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self isAnyValueInTableViewDataSource]) {
        self.tableView.tableFooterView = nil;
    }else
    {
        self.tableView.tableFooterView = self.footerView;
    }
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
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    
    cell.didClickRightChooseButtonBlock = ^{
        
        if (self.languageLevelDataSource && self.languageLevelDataSource.count > 0) {
            [self languageLevelBlockActionWithIndexPath:indexPath dataSource:self.languageLevelDataSource];
        } else
        {
            [self requestCategoryDataWithAliasStr:@"DW_language_level" completeBlock:^(NSArray *data) {
                self.languageLevelDataSource = [NSMutableArray arrayWithArray:data];
                [self languageLevelBlockActionWithIndexPath:indexPath dataSource:self.languageLevelDataSource];
            }];
        }
        
    };

    cell.didClickLeftChooseButtonBlock = ^{
        
        if (self.languageCategoryDataSource && self.languageCategoryDataSource.count > 0) {
            [self languageCategoryBlockActionWithIndexPath:indexPath dataSource:self.languageCategoryDataSource];
        } else
        {
            [self requestCategoryDataWithAliasStr:@"DW_language" completeBlock:^(NSArray *data) {
                self.languageCategoryDataSource = [NSMutableArray arrayWithArray:data];
                [self languageCategoryBlockActionWithIndexPath:indexPath dataSource:self.languageCategoryDataSource];
            }];
        }
        
    };;
    cell.separatorLabel.text = @"/";
    [cell setModel:model];
 
    if ([NSValueToString(model.value) length] < 1 ||  [NSValueToString(model.value) isEqualToString:kDefaultLeftButtonTitle]) {
        [cell.leftChooseButton setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
    } else
    {
        [cell.leftChooseButton setTitleColor:DARKTEXTCOLOR forState:UIControlStateNormal];
    }
    if ([NSValueToString(model.subValue) length] < 1 ||  [NSValueToString(model.subValue) isEqualToString:kDefaultRightButtonTitle]) {
        [cell.rightChooseButton setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
    } else
    {
        [cell.rightChooseButton setTitleColor:DARKTEXTCOLOR forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark --- cell block

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

- (void)languageLevelBlockActionWithIndexPath:(NSIndexPath *)indexPath dataSource:(NSArray *)dataSource
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.subValue = rowDataInFirstComponent[@"cName"];
        NSMutableDictionary *selectedRowData = weakself.selectedData[[NSString stringWithFormat:@"%ld", indexPath.row]];
        if (kDictIsEmpty(selectedRowData)) {
            selectedRowData = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [selectedRowData setObject:NSValueToString(rowDataInFirstComponent[@"cID"]) forKey:@"level"];
        [selectedRowData setObject:NSValueToString(rowDataInFirstComponent[@"cName"]) forKey:@"levelCn"];
        [weakself.selectedData setObject:selectedRowData forKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:dataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
}

- (void)languageCategoryBlockActionWithIndexPath:(NSIndexPath *)indexPath dataSource:(NSArray *)dataSource
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"cName";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"cName"];
        NSMutableDictionary *selectedRowData = weakself.selectedData[[NSString stringWithFormat:@"%ld", indexPath.row]];
        if (kDictIsEmpty(selectedRowData)) {
            selectedRowData = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [selectedRowData setObject:NSValueToString(rowDataInFirstComponent[@"cID"]) forKey:@"language"];
        [selectedRowData setObject:NSValueToString(rowDataInFirstComponent[@"cName"]) forKey:@"languageCn"];
        [weakself.selectedData setObject:selectedRowData forKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:dataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
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
