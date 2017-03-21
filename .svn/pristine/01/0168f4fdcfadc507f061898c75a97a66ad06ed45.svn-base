//
//  EditRecruitmentInfoViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/12.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "EditRecruitmentInfoViewController.h"
#import "CreateRecruitmentBaseInfoViewController.h"
#import "CreateRecruitmentJobintensionViewController.h"
#import "CreateRecruitmentJobExperienceViewController.h"
#import "CreateRecruitmentEducationInfoViewController.h"
#import "CreateProjectExperienceViewController.h"
#import "UpdateRecruitmentExtraInfoViewController.h"
#import "RecruitmentEducationTableViewCell.h"
#import "RecruitmentJobIntensionTableViewCell.h"
#import "RecruitmentJobExperienceTableViewCell.h"
#import "EditRecruitmentBaseInfoTableViewCell.h"
#import "EditRecruitmentWorksShowTableViewCell.h"
#import "EditRecruitmentAavatarTableViewCell.h"
#import "EditRecruitmentExtraInfoTableViewCell.h"
#import "ProjectExperienceTableViewCell.h"
#import "HaoQiNiu.h"

@interface EditRecruitmentInfoViewController ()<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UIButton *moreModulesButton;

@property (strong, nonatomic) UIImage *headerImage;

@property (strong, nonatomic) NSString *req_avatar;

@end

@implementation EditRecruitmentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentEducationTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentEducationTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentJobIntensionTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentJobIntensionTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentJobExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentJobExperienceTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"EditRecruitmentBaseInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EditRecruitmentBaseInfoTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"EditRecruitmentWorksShowTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EditRecruitmentWorksShowTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"EditRecruitmentAavatarTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EditRecruitmentAavatarTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"EditRecruitmentExtraInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EditRecruitmentExtraInfoTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProjectExperienceTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = self.footerView;
    [self setupSectionTitlesWithIfShowMoreModules:self.moreModulesButton.selected];
    [self setupBaseInfoTitles];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestRecruitmentInfo];
}

- (void)setupSectionTitlesWithIfShowMoreModules:(BOOL)isShowMoreModules
{
    self.sectionTitles = @[@"添加头像",@"基本信息",@"求职意向",@"工作经历",@"教育经历"].mutableCopy;
    if (isShowMoreModules) {
        self.sectionTitles = @[@"添加头像",@"基本信息",@"求职意向",@"工作经历",@"教育经历",@"作品展示",@"项目经验",@"附加信息"].mutableCopy;
    }
}

- (void)setupBaseInfoTitles
{
    self.baseInfotTitles = @[@{@"title":@"姓    名:",@"valueKey":@"realname"},
                             @{@"title":@"性    别:",@"valueKey":@"sexCn"},
                             @{@"title":@"生    日:",@"valueKey":@"birthday"},
                             @{@"title":@"所在城市:",@"valueKey":@"districtCn"},
                             @{@"title":@"工作年限:",@"valueKey":@"experienceCn"},
                             @{@"title":@"手    机:",@"valueKey":@"phone"},
                             @{@"title":@"邮    箱:",@"valueKey":@"email"}].mutableCopy;
}


#pragma mark --- navigationBar appearance

- (UIButton *)set_rightButton
{
    UIButton *resignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resignBtn.frame = CGRectMake(0, 0, 40, 40);
    [resignBtn setTitle:@"保存" forState:UIControlStateNormal];
    resignBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [resignBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return resignBtn;
}

- (void)right_button_event:(UIButton *)sender
{
    
    if (!self.headerImage) {
        [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.headerImage) {
        NSData *data = UIImageJPEGRepresentation([Tool imageWithImage:self.headerImage scaledToSize:CGSizeMake(self.headerImage.size.width/2, self.headerImage.size.height/2)], 1.0);
        
        MKNetworkOperation * op = [HaoQiNiu uploadImage:[NSString stringWithFormat:@"%@job/third/ueditor/php/controller.php?action=uploadimage", [HaoConfig getHtmlHost]] params:@{@"path_name_of_config":@"resume_photo_dir"}.mutableCopy imageDatas:data Method:METHOD_POST onCompletion:^(NSData *responseData) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic);
            
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSMutableDictionary * exprame  = nil;
            exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       NSValueToString(self.resumeID),@"id",
                       NSValueToString(dic[@"url"]),@"photo_img",
                       
                       nil];
            [HaoConnect request:@"job_resume/update" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if (result.isResultsOK) {
                    [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } onError:^(HaoResult *errorResult) {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
            
            
            
        } onError:^(NSError *error) {
            
        }];
        [op onUploadProgressChanged:^(double progress) {
            NSLog(@"真正上传的：%f",progress);
            
        }];
        
    }
    
    
    
    //    [HaoQiNiu requestUpLoadQiNiu:data onCompletion:^(NSString *urlPreview) {
    //        if (urlPreview) {
    //            self.req_avatar = [urlPreview mutableCopy];
    //            self.headerImage = [UIImage imageNamed:urlPreview];
    //
    //            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //            NSMutableDictionary * exprame  = nil;
    //            exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
    //                       NSValueToString(self.resumeID),@"id",
    //                       NSValueToString(self.req_avatar),@"photo_img",
    //
    //                       nil];
    //            [HaoConnect request:@"job_resume/update" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
    //                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //                if (result.isResultsOK) {
    //                    [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
    //                }
    //
    //            } onError:^(HaoResult *errorResult) {
    //
    //                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //            }];
    //        }
    //
    //        [self.tableView reloadData];
    //        NSLog(@"真正页面的UI：%@",urlPreview);
    //    } onError:^(NSError *error) {
    //
    //    } progress:^(double progress) {
    //        if (progress >= 1) {
    //            //                [self requestUpdateInfoKey:@"head_img" value:picUrl];
    //        }
    //    }];
}


#pragma mark --- button action

- (IBAction)clickMoreModulesButtonAction:(id)sender {
    
    self.moreModulesButton.selected = !self.moreModulesButton.selected;
    [self setupSectionTitlesWithIfShowMoreModules:self.moreModulesButton.selected];
    [self.tableView reloadData];
}


- (void)editInfoAction:(UIButton *)editButton
{
    if ([self.sectionTitles[editButton.tag] isEqualToString:@"基本信息"]) {
        CreateRecruitmentBaseInfoViewController *baseInfoVC = [[CreateRecruitmentBaseInfoViewController alloc] init];
        baseInfoVC.isEditing = YES;
        baseInfoVC.baseInfoData = self.baseInfoData;
        baseInfoVC.resumeID = self.resumeID;
        [self.navigationController pushViewController:baseInfoVC animated:YES];
    } else if ([self.sectionTitles[editButton.tag] isEqualToString:@"求职意向"])
    {
        CreateRecruitmentJobintensionViewController *jobIntensionVC = [[CreateRecruitmentJobintensionViewController alloc] init];
        jobIntensionVC.isEditing = YES;
        jobIntensionVC.jobIntensionData = self.jobIntensionData;
        jobIntensionVC.jobIntensionID = self.jobIntensionData[@"id"];
        jobIntensionVC.resumeID = self.resumeID;
        [self.navigationController pushViewController:jobIntensionVC animated:YES];
    } else if ([self.sectionTitles[editButton.tag] isEqualToString:@"附加信息"])
    {
        UpdateRecruitmentExtraInfoViewController *extraInfo = [[UpdateRecruitmentExtraInfoViewController alloc] init];
        extraInfo.resumeID = self.resumeID;
        [self.navigationController pushViewController:extraInfo animated:YES];
    };
}



#pragma mark --- request

- (void)requestRecruitmentInfo
{
    // 简历完成度
    [self requestRecruitmentCompletion];
    [self requestInfoWithRequest:@"job_resume/list" successBlock:^(NSArray *data) {
        
        self.baseInfoData = [NSMutableDictionary dictionaryWithDictionary:[data firstObject]];
        self.resumeID = self.baseInfoData[@"id"];
        
        [self requestInfoWithRequest:@"job_resume_position/list" successBlock:^(NSArray *data) {
            self.jobIntensionData = [NSMutableDictionary dictionaryWithDictionary:[data firstObject]];
            [self.tableView reloadData];
            
            [self requestInfoWithRequest:@"job_resume_work/list" successBlock:^(NSArray *data) {
                self.experienceData = [NSMutableArray arrayWithArray:data];
                [self.tableView reloadData];
                
                [self requestInfoWithRequest:@"job_resume_education/list" successBlock:^(NSArray *data) {
                    self.educationData = [NSMutableArray arrayWithArray:data];
                    [self.tableView reloadData];
                    
                    [self requestInfoWithRequest:@"job_resume_img/list" successBlock:^(NSArray *data) {
                        
                        self.worksShowData = [NSMutableArray arrayWithArray:data];
                        [self.tableView reloadData];
                        
                        [self requestInfoWithRequest:@"job_resume_project/list" successBlock:^(NSArray *data) {
                            self.projectExperienceData = [NSMutableArray arrayWithArray:data];
                            [self.tableView reloadData];
                            
                            [self requestRecruitmentExtraInfoData];
                            
                        }];
                    }];
                    
                }];
            }];
        }];
    }];
    
    
}


- (void)requestRecruitmentExtraInfoData
{
    if ([NSValueToString(self.resumeID) length] <= 1) {
        return;
    }
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
                [self.tableView reloadData];
            }
            
            
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

- (void)requestRecruitmentCompletion
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.resumeID),@"id",
               nil];
    [HaoConnect request:@"job_resume/GetResumeCompletion" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            self.navigationItem.title = [NSString stringWithFormat:@"简历完整度:%@", NSValueToString(result.results[@"percent"])];
            
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}


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
        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestRecruitmentInfo];
        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}


#pragma mark --- getter

- (NSMutableDictionary *)baseInfoData
{
    if (!_baseInfoData) {
        _baseInfoData = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _baseInfoData;
}

- (NSMutableDictionary *)jobIntensionData
{
    if (!_jobIntensionData) {
        _jobIntensionData = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _jobIntensionData;
}

-(NSMutableArray *)experienceData
{
    if (!_experienceData) {
        _experienceData = [NSMutableArray arrayWithCapacity:1];
    }
    return _experienceData;
}

-(NSMutableArray *)educationData
{
    if (!_educationData) {
        _educationData = [NSMutableArray arrayWithCapacity:1];
    }
    return _educationData;
}

-(NSMutableArray *)worksShowData
{
    if (!_worksShowData) {
        _worksShowData = [NSMutableArray arrayWithCapacity:1];
    }
    return _worksShowData;
}

- (NSMutableArray *)projectExperienceData
{
    if (!_projectExperienceData) {
        _projectExperienceData = [NSMutableArray arrayWithCapacity:1];
    }
    return _projectExperienceData;
}

- (NSMutableDictionary *)extraInfoData
{
    if (!_extraInfoData) {
        _extraInfoData = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _extraInfoData;
}


#pragma mark --- tableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.sectionTitles[section] isEqualToString:@"添加头像"]) {
        return 1;
    } else if ([self.sectionTitles[section] isEqualToString:@"基本信息"])
    {
        return self.baseInfotTitles.count;
    } else if ([self.sectionTitles[section] isEqualToString:@"求职意向"])
    {
        return 1;
    }  else if ([self.sectionTitles[section] isEqualToString:@"工作经历"])
    {
        return self.experienceData.count;
    } else if ([self.sectionTitles[section] isEqualToString:@"教育经历"])
    {
        return self.educationData.count;
    } else if ([self.sectionTitles[section] isEqualToString:@"作品展示"])
    {
        return self.worksShowData.count;
    } else if ([self.sectionTitles[section] isEqualToString:@"项目经验"])
    {
        return self.projectExperienceData.count;
    } else if ([self.sectionTitles[section] isEqualToString:@"附加信息"])
    {
        return 1;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.sectionTitles[section] isEqualToString:@"添加头像"] || [self.sectionTitles[section] isEqualToString:@"基本信息"] || [self.sectionTitles[section] isEqualToString:@"求职意向"] || [self.sectionTitles[section] isEqualToString:@"工作经历"]) {
        return 50;
    }
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 50)];
    
    UIView *titleBackgroundView = [[UIView alloc] init];
    titleBackgroundView.backgroundColor = [UIColor whiteColor];
    if ([self.sectionTitles[section] isEqualToString:@"添加头像"] || [self.sectionTitles[section] isEqualToString:@"基本信息"] || [self.sectionTitles[section] isEqualToString:@"求职意向"] || [self.sectionTitles[section] isEqualToString:@"工作经历"]) {
        titleBackgroundView.frame = CGRectMake(0, 15, ScreenSizeWidth, 35);
    } else
    {
        titleBackgroundView.frame = CGRectMake(0, 0, ScreenSizeWidth, 35);
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenSizeWidth - 40, 35)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = DARKTEXTCOLOR;
    titleLabel.text = self.sectionTitles[section];
    [titleBackgroundView addSubview:titleLabel];
    
    // edit button
    if ([self.sectionTitles[section] isEqualToString:@"基本信息"] || [self.sectionTitles[section] isEqualToString:@"求职意向"] || [self.sectionTitles[section] isEqualToString:@"附加信息"]) {
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(titleBackgroundView.frame.size.width - 20 - 60, 0, 60, titleBackgroundView.frame.size.height);
        [editButton setTitle:@" 编辑" forState:UIControlStateNormal];
        editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [editButton setTitleColor:CUSTOMORANGECOLOR forState:UIControlStateNormal];
        [editButton setImage:[UIImage imageNamed:@"recruitment_edit"] forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(editInfoAction:) forControlEvents:UIControlEventTouchUpInside];
        editButton.tag = section;
        [titleBackgroundView addSubview:editButton];
    }
    
    // light line
    
    UIView *lightLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleBackgroundView.frame.size.height - 0.5, ScreenSizeWidth, 0.5)];
    lightLineView.backgroundColor = LIGHTLINECOLOR;
    [titleBackgroundView addSubview:lightLineView];
    [sectionView addSubview:titleBackgroundView];
    
    // line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 0.5)];
    lineView.backgroundColor = DARKLINECOLOR;
    [titleBackgroundView addSubview:lineView];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.sectionTitles[section] isEqualToString:@"添加头像"] || [self.sectionTitles[section] isEqualToString:@"基本信息"] || [self.sectionTitles[section] isEqualToString:@"求职意向"] || [self.sectionTitles[section] isEqualToString:@"附加信息"]) {
        return 0.1;
    } else if ([self.sectionTitles[section] isEqualToString:@"工作经历"] || [self.sectionTitles[section] isEqualToString:@"教育经历"] || [self.sectionTitles[section] isEqualToString:@"作品展示"] || [self.sectionTitles[section] isEqualToString:@"项目经验"])
    {
        return 35;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 35)];
    footerView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    
    // top line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 0.5)];
    lineView.backgroundColor = DARKLINECOLOR;
    [footerView addSubview:lineView];
    
    // button
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(0, 0, ScreenSizeWidth, 35);
    actionButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    NSString *title = @"";
    UIColor *titleColor = [UIColor clearColor];
    if ([self.sectionTitles[section] isEqualToString:@"工作经历"]) {
        title = @"+添加工作经历";
        titleColor = kNavBackgroundColor;
        [actionButton addTarget:self action:@selector(clickFooterViewAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    } else if ([self.sectionTitles[section] isEqualToString:@"作品展示"]) {
        title = @"作品展示手机版暂不支持编辑, 请到网页版完善";
        titleColor = LIGHTTEXTCOLOR;
    } else if ([self.sectionTitles[section] isEqualToString:@"教育经历"]) {
        title = @"+添加教育经历";
        titleColor = kNavBackgroundColor;
        [actionButton addTarget:self action:@selector(clickFooterViewAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.sectionTitles[section] isEqualToString:@"项目经验"]) {
        title = @"+添加项目经验";
        titleColor = kNavBackgroundColor;
        [actionButton addTarget:self action:@selector(clickFooterViewAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    actionButton.tag = section;
    [actionButton setTitle:title forState:UIControlStateNormal];
    [actionButton setTitleColor:titleColor forState:UIControlStateNormal];
    [footerView addSubview:actionButton];
    
    return footerView;
}

- (void)clickFooterViewAddButtonAction:(UIButton *)actionButton
{
    if ([self.sectionTitles[actionButton.tag] isEqualToString:@"工作经历"])
    {
        CreateRecruitmentJobExperienceViewController *jobExperienceVC = [[CreateRecruitmentJobExperienceViewController alloc] init];
        jobExperienceVC.isEditing = YES;
        jobExperienceVC.resumeID = self.resumeID;
        [self.navigationController pushViewController:jobExperienceVC animated:YES];
    } else if ([self.sectionTitles[actionButton.tag] isEqualToString:@"教育经历"])
    {
        CreateRecruitmentEducationInfoViewController *educationInfoVC = [[CreateRecruitmentEducationInfoViewController alloc] init];
        educationInfoVC.isEditing = YES;
        educationInfoVC.resumeID = self.resumeID;
        [self.navigationController pushViewController:educationInfoVC animated:YES];
    } else if ([self.sectionTitles[actionButton.tag] isEqualToString:@"项目经验"])
    {
        CreateProjectExperienceViewController *projectExperienceVC = [[CreateProjectExperienceViewController alloc] init];
        projectExperienceVC.resumeID = self.resumeID;
        [self.navigationController pushViewController:projectExperienceVC animated:YES];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.sectionTitles[indexPath.section] isEqualToString:@"添加头像"]) {
        
        EditRecruitmentAavatarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditRecruitmentAavatarTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
        cell.avatarImageView.clipsToBounds = YES;
        if (self.headerImage) {
            cell.avatarImageView.image = self.headerImage;
        } else
        {

            [Tool imageView:cell.avatarImageView configImageWithUrl:([NSValueToString(self.req_avatar) length] > 0 ? NSValueToString(self.req_avatar) : NSValueToString(self.baseInfoData[@"showPhotoImg"])) placeholderImageName:@"person_default"];
        }
        
        return cell;
        
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"基本信息"]) {
        
        EditRecruitmentBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditRecruitmentBaseInfoTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.baseInfotTitles[indexPath.row][@"title"];
        cell.contentLabel.text = self.baseInfoData[NSValueToString(self.baseInfotTitles[indexPath.row][@"valueKey"])];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"求职意向"]) {
        
        RecruitmentJobIntensionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentJobIntensionTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configCellWithData:self.jobIntensionData];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"工作经历"])
    {
        RecruitmentJobExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentJobExperienceTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isEditing = YES;
        cell.didClickEditButtonBlock = ^{
            CreateRecruitmentJobExperienceViewController *jobExperienceVC = [[CreateRecruitmentJobExperienceViewController alloc] init];
            jobExperienceVC.isEditing = YES;
            jobExperienceVC.resumeID = self.resumeID;
            if (self.experienceData[indexPath.row] && [self.experienceData[indexPath.row] isKindOfClass:[NSDictionary class]]) {
                jobExperienceVC.jobExperienceID = self.experienceData[indexPath.row][@"id"];
                jobExperienceVC.jobExperienceData = self.experienceData[indexPath.row];
            }
            
            [self.navigationController pushViewController:jobExperienceVC animated:YES];
        };
        
        [cell configCellWithData:self.experienceData[indexPath.row]];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"教育经历"])
    {
        RecruitmentEducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentEducationTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isEditing = YES;
        cell.didClickEditButtonBlock = ^{
            CreateRecruitmentEducationInfoViewController *educationVC = [[CreateRecruitmentEducationInfoViewController alloc] init];
            educationVC.isEditing = YES;
            educationVC.resumeID = self.resumeID;
            if (self.experienceData[indexPath.row] && [self.experienceData[indexPath.row] isKindOfClass:[NSDictionary class]]) {
                educationVC.educationInfoID = self.educationData[indexPath.row][@"id"];
                educationVC.educationData = self.educationData[indexPath.row];
            }
            
            [self.navigationController pushViewController:educationVC animated:YES];
        };
        
        [cell configCellWithData:self.educationData[indexPath.row]];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"作品展示"])
    {
        EditRecruitmentWorksShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditRecruitmentWorksShowTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [Tool imageView:cell.contentImageView configImageWithUrl:NSValueToString(self.worksShowData[indexPath.row][@"showImg"]) placeholderImageName:@""];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"项目经验"])
    {
        ProjectExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProjectExperienceTableViewCell class])];
        cell.isEditing = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.didClickEditButtonBlock = ^{
            CreateProjectExperienceViewController *projectExperienceVC = [[CreateProjectExperienceViewController alloc] init];
            projectExperienceVC.resumeID = self.resumeID;
            if (self.projectExperienceData[indexPath.row] && [self.projectExperienceData[indexPath.row] isKindOfClass:[NSDictionary class]]) {
                projectExperienceVC.projectExperienceID = self.projectExperienceData[indexPath.row][@"id"];
                projectExperienceVC.projectExperienceData = self.projectExperienceData[indexPath.row];
            }
            
            [self.navigationController pushViewController:projectExperienceVC animated:YES];
        };
        [cell configCellWithData:self.projectExperienceData[indexPath.row]];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"附加信息"])
    {
        EditRecruitmentExtraInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditRecruitmentExtraInfoTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configCellWithData:self.extraInfoData];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.sectionTitles[indexPath.section] isEqualToString:@"添加头像"])
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从手机相册选择", nil];
        
        [actionSheet showInView:self.view];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = %d", (int)buttonIndex);
    
    
    switch (buttonIndex) {
            
        case 0:
        {
            [self takePhoto];
        }
            break;
        case 1:
        {
            [self localPhoto];
        }
            break;
        default:
            break;
    }
}

- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
}


- (void)localPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        self.headerImage = image;
        [self.tableView reloadData];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
