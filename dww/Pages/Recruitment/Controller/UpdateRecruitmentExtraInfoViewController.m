//
//  UpdateRecruitmentExtraInfoViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/16.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "UpdateRecruitmentExtraInfoViewController.h"
#import "AddLanguageLevelViewController.h"
#import "AddSkillLevelViewController.h"
#import "AddSelfDescriptionViewController.h"
#import "RecruitmentInfoTableViewCell.h"

#define kCellTitleLanguageLevel @"语言程度"
#define kCellTitleSkillLevel @"掌握技能"
#define kCellTitleSelfDescription @"自我描述"
@interface UpdateRecruitmentExtraInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
//
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<RecruitmentInfoCellModel *> *tableViewDataSource;
@property (strong, nonatomic) NSMutableDictionary *requestData; // 保存的用来请求接口的数据
@property (nonatomic, strong) NSMutableDictionary *extraInfoData; // 附加信息

@property (nonatomic, strong) NSMutableArray *languages;
@property (nonatomic, strong) NSMutableArray *skills;

@end

@implementation UpdateRecruitmentExtraInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"附加信息";
    
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
    [self setupRequestData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestExtraInfoData];
}


- (void)requestExtraInfoData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.resumeID),@"resume_id",
               nil];
    [HaoConnect request:@"job_resume_additions/GetMixAdditions" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (result.results && [result.results isKindOfClass:[NSDictionary class]]) {
                self.extraInfoData = [result.results mutableCopy];
                if (self.extraInfoData[@"languages"] && [self.extraInfoData[@"languages"] isKindOfClass:[NSArray class]]) {
                    self.languages = [NSMutableArray arrayWithArray:self.extraInfoData[@"languages"]];
                }
                
                if (self.extraInfoData[@"skills"] && [self.extraInfoData[@"skills"] isKindOfClass:[NSArray class]]) {
                    self.skills = [NSMutableArray arrayWithArray:self.extraInfoData[@"skills"]];
                }
                
                [self.tableViewDataSource enumerateObjectsUsingBlock:^(RecruitmentInfoCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj.title isEqualToString:kCellTitleSkillLevel]) {
                        
                        obj.value = NSValueToString(self.extraInfoData[@"skillDesc"]);
                    } else if ([obj.title isEqualToString:kCellTitleLanguageLevel])
                    {
                        obj.value = NSValueToString(self.extraInfoData[@"languageDesc"]);
                    } else if ([obj.title isEqualToString:kCellTitleSelfDescription])
                    {
                        obj.value = NSValueToString(self.extraInfoData[@"selfDesc"]);
                        [self.requestData setObject:NSValueToString(self.extraInfoData[@"selfDesc"]) forKey:@"description"];
                    }
                }];
                [self.tableView reloadData];
            }
            
        }
        
    } onError:^(HaoResult *errorResult) {
        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestExtraInfoData];
        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (void)setupRequestData
{
    self.requestData = [NSMutableDictionary dictionaryWithCapacity:1];
    [self.requestData setObject:NSValueToString(self.resumeID) forKey:@"resume_id"];
    [self.requestData setObject:@[] forKey:@"languages"];
    [self.requestData setObject:@[] forKey:@"skills"];
    [self.requestData setObject:@"" forKey:@"description"];
}

- (void)setupDataSource
{
    NSArray *titles = @[kCellTitleLanguageLevel, kCellTitleSkillLevel, kCellTitleSelfDescription];
    [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RecruitmentInfoCellModel *model = [[RecruitmentInfoCellModel alloc] init];
        model.title = obj;
        model.cellType = RecruitmentInfoCellTypeTextField;
        [self.tableViewDataSource addObject:model];
    }];
}

#pragma mark --- navigationBar appearance
- (void)left_button_event:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (UIButton *)set_rightButton
//{
//    UIButton *stepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [stepBtn setTitle:@"保存" forState:UIControlStateNormal];
//    
//    stepBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [stepBtn sizeToFit];
//    [stepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    return stepBtn;
//}
//
//- (void)right_button_event:(UIButton *)sender
//{
//    [self.view endEditing:YES];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSMutableDictionary * exprame  = nil;
//    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//               NSValueToString([Tool stringFromDic:self.requestData]),@"resume_extras",
//
//               nil];
//    [HaoConnect request:@"job_resume_additions/SaveMixAdditions" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        if (result.isResultsOK) {
//            
//            [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//    } onError:^(HaoResult *errorResult) {
//   
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    }];
//
//    
//}

#pragma mark --- getter

- (NSMutableArray<RecruitmentInfoCellModel *> *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _tableViewDataSource;
}

- (NSMutableDictionary *)extraInfoData
{
    if (!_extraInfoData) {
        _extraInfoData = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _extraInfoData;
}

- (NSMutableArray *)languages
{
    if (!_languages) {
        _languages = [NSMutableArray arrayWithCapacity:1];
    }
    return _languages;
}

- (NSMutableArray *)skills
{
    if (!_skills) {
        _skills = [NSMutableArray arrayWithCapacity:1];
    }
    return _skills;
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
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
  
    cell.didClickRightChooseButtonBlock = nil;
    cell.didClickLeftChooseButtonBlock = nil;
    cell.didClickSingleLeftChooseButtonBlock = nil;
    cell.didClickSingleRightChooseButtonBlock = nil;
    [cell setModel:model];
    cell.contentTextField.userInteractionEnabled = NO;
    cell.arrowImageView.hidden = NO;
    cell.contentTextField.placeholder = @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];

    if ([self.tableViewDataSource[indexPath.row].title isEqualToString:kCellTitleLanguageLevel]) {
        AddLanguageLevelViewController *addLanguageVC = [[AddLanguageLevelViewController alloc] init];
        addLanguageVC.languages = self.languages;
        addLanguageVC.resumeID = NSValueToString(self.resumeID);
        addLanguageVC.hidesBottomBarWhenPushed = YES;
        addLanguageVC.completeChooseBlock = ^(NSArray<NSDictionary *>* selectedArray){
            __block NSString *languagesStr = @"";
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
            [selectedArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:1];
                [tempDic setObject:NSValueToString(obj[@"language"]) forKey:@"language"];
                [tempDic setObject:NSValueToString(obj[@"level"]) forKey:@"level"];
                if ([NSValueToString(obj[@"id"]) length] > 0) {
                    [tempDic setObject:NSValueToString(obj[@"id"]) forKey:@"id"];
                }
                [tempArray addObject:tempDic];
                if ([NSValueToString(languagesStr) length] > 0) {
                    languagesStr = [NSString stringWithFormat:@"%@  %@%@", languagesStr, NSValueToString(obj[@"languageCn"]),NSValueToString(obj[@"levelCn"])];
                } else
                {
                    languagesStr = [NSString stringWithFormat:@"%@%@", NSValueToString(obj[@"languageCn"]),NSValueToString(obj[@"levelCn"])];
                }
               
                self.languages = [NSMutableArray arrayWithArray:selectedArray];
            }];
            model.value = languagesStr;
            [self.tableView reloadData];
            [self.requestData setObject:tempArray forKey:@"languages"];
        };
        [self.navigationController pushViewController:addLanguageVC animated:YES];
    } else if ([self.tableViewDataSource[indexPath.row].title isEqualToString:kCellTitleSelfDescription])
    {
        AddSelfDescriptionViewController *descriptionVC = [[AddSelfDescriptionViewController alloc] init];
        descriptionVC.resumeID = NSValueToString(self.resumeID);
        descriptionVC.req_selfContent = model.value;
        descriptionVC.hidesBottomBarWhenPushed = YES;
        descriptionVC.completeChooseBlock = ^(NSString *description){
            [self.requestData setObject:NSValueToString(description) forKey:@"description"];
            model.value = NSValueToString(description);
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:descriptionVC animated:YES];
        
    } else if ([self.tableViewDataSource[indexPath.row].title isEqualToString:kCellTitleSkillLevel])
    {
        AddSkillLevelViewController *addSkillVC = [[AddSkillLevelViewController alloc] init];
        addSkillVC.skills = self.skills;
        addSkillVC.resumeID = NSValueToString(self.resumeID);
        addSkillVC.completeChooseBlock = ^(NSArray<NSDictionary *>* selectedArray){
            __block NSString *skillsStr = @"";
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
            [selectedArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:1];
                [tempDic setObject:NSValueToString(obj[@"title"]) forKey:@"title"];
                [tempDic setObject:NSValueToString(obj[@"level"]) forKey:@"level"];
                if ([NSValueToString(obj[@"id"]) length] > 0) {
                    [tempDic setObject:NSValueToString(obj[@"id"]) forKey:@"id"];
                }
                if ([NSValueToString(skillsStr) length] > 0) {
                    skillsStr = [NSString stringWithFormat:@"%@  %@%@", skillsStr, NSValueToString(obj[@"title"]), NSValueToString(obj[@"levelCn"])];
                } else
                {
                    skillsStr = [NSString stringWithFormat:@"%@%@", NSValueToString(obj[@"title"]), NSValueToString(obj[@"levelCn"])];
                }
                [tempArray addObject:tempDic];
                self.skills = [NSMutableArray arrayWithArray:selectedArray];
            }];
            model.value = skillsStr;
            [self.tableView reloadData];
            [self.requestData setObject:tempArray forKey:@"skills"];
        };
        addSkillVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addSkillVC animated:YES];
    }
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
