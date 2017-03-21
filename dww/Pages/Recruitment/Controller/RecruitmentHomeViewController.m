//
//  RecruitmentHomeViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "RecruitmentHomeViewController.h"
#import "CreateRecruitmentBaseInfoViewController.h"
#import "EditRecruitmentInfoViewController.h"
#import "RecruitmentEducationTableViewCell.h"
#import "RecruitmentJobIntensionTableViewCell.h"
#import "RecruitmentJobExperienceTableViewCell.h"
#import "EditRecruitmentExtraInfoTableViewCell.h"
#import "EditRecruitmentWorksShowTableViewCell.h"
#import "ProjectExperienceTableViewCell.h"
#import "PhotoShowViewController.h"
@interface RecruitmentHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *resumeID;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *headerViewNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;

@property (strong, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (nonatomic, strong) NSMutableDictionary *baseInfoData;
@property (nonatomic, strong) NSMutableDictionary *jobIntensionData;
@property (nonatomic, strong) NSMutableArray *experienceData;
@property (nonatomic, strong) NSMutableArray *educationData;
@property (nonatomic, strong) NSMutableArray *worksShowData; // 作品展示
@property (nonatomic, strong) NSMutableArray *projectExperienceData; // 项目经验
@property (nonatomic, strong) NSMutableDictionary *extraInfoData; // 附加信息
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@end

@implementation RecruitmentHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"简历";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentEducationTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentEducationTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentJobIntensionTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentJobIntensionTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentJobExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentJobExperienceTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"EditRecruitmentExtraInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EditRecruitmentExtraInfoTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProjectExperienceTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"EditRecruitmentWorksShowTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EditRecruitmentWorksShowTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableHeaderView = self.headerView;
    [self setupSectionTitles];

    self.headerImageView.clipsToBounds = YES;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.headerImageView.layer.cornerRadius = CGRectGetWidth(self.headerImageView.frame)/2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestRecruitmentInfo];
}


- (void)setupSectionTitles
{
    self.sectionTitles = @[@"求职意向",@"工作经历",@"教育经历",@"作品展示",@"项目经验",@"附加信息"].mutableCopy;
}

- (void)configHeaderViewWithData:(NSDictionary *)data
{
    self.headerViewNameLabel.text = NSValueToString(data[@"realname"]);
    self.extraInfoLabel.text = [NSString stringWithFormat:@"%@  %@岁  %@  工作%@", NSValueToString(data[@"sexCn"]), NSValueToString(data[@"age"]), NSValueToString(data[@"districtCn"]), NSValueToString(data[@"experienceCn"])];
    self.phoneLabel.text = NSValueToString(data[@"phone"]);
    self.emailLabel.text = NSValueToString(data[@"email"]);
//    NSString *imgUrlString = [data[@"photoImg"] hasSuffix:@"http"]?data[@"photoImg"]:[NSString stringWithFormat:@"http://www-dww.haoxitech.com/%@",data[@"photoImg"]];

    [Tool imageView:self.headerImageView configImageWithUrl:NSValueToString(data[@"showPhotoImg"]) placeholderImageName:@"person_default"];

}


#pragma mark --- navigationBar appearance

- (UIButton *)rightEditButton
{
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(0, 0, 40, 40);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(right_button_event:) forControlEvents:UIControlEventTouchUpInside];
    return editBtn;
}

- (void)right_button_event:(UIButton *)sender
{
    EditRecruitmentInfoViewController *editVC = [[EditRecruitmentInfoViewController alloc] init];
    editVC.hidesBottomBarWhenPushed = YES;
    editVC.baseInfoData = self.baseInfoData;
    editVC.jobIntensionData = self.jobIntensionData;
    editVC.experienceData = self.experienceData;
    editVC.educationData = self.educationData;
    editVC.resumeID = self.resumeID;
    editVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)requestRecruitmentInfo
{
    [self requestInfoWithRequest:@"job_resume/list" successBlock:^(NSArray *data) {
        if (!data || ![data isKindOfClass:[NSArray class]] || data.count <= 0) {
            self.navigationItem.rightBarButtonItem = nil;
            self.tableView.scrollEnabled = NO;
            [self.baseInfoData removeAllObjects];
            [self.jobIntensionData removeAllObjects];
            [self.experienceData removeAllObjects];
            [self.educationData removeAllObjects];
            [self.worksShowData removeAllObjects];
            [self.projectExperienceData removeAllObjects];
            [self.extraInfoData removeAllObjects];
            [self configHeaderViewWithData:self.baseInfoData];
            [self.tableView reloadData];
            [self.view configBlankPage:EaseBlankPageTypeNoRecruitment hasData:NO hasError:NO reloadButtonBlock:nil customButtonBlock:^(UIButton *sender) {
                CreateRecruitmentBaseInfoViewController *createRecruitmentVC = [[CreateRecruitmentBaseInfoViewController alloc] init];
                createRecruitmentVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:createRecruitmentVC animated:YES];
            }];
            return;
        }
        self.tableView.scrollEnabled = YES;
        [self.view configBlankPage:EaseBlankPageTypeNoRecruitment hasData:YES hasError:NO reloadButtonBlock:nil customButtonBlock:nil];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self rightEditButton]];
        self.navigationItem.title = @"简历预览";
        self.baseInfoData = [NSMutableDictionary dictionaryWithDictionary:[data firstObject]];
        self.resumeID = self.baseInfoData[@"id"];
        [self configHeaderViewWithData:self.baseInfoData];
        
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
                        if (_worksShowData.count==0) {
                            if ([self.sectionTitles containsObject:@"作品展示"]) {
                                [self.sectionTitles removeObject:@"作品展示"];
                            }
                        }else{
                            if (![self.sectionTitles containsObject:@"作品展示"]) {
                                [self.sectionTitles insertObject:@"作品展示" atIndex:3];
                            }
                        }
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.resumeID),@"resume_id",
               nil];
    [HaoConnect request:@"job_resume_additions/GetMixAdditions" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (result.results && [result.results isKindOfClass:[NSDictionary class]]) {
                self.extraInfoData = [result.results mutableCopy];
                [self.tableView reloadData];
            }
            
        }
        
    } onError:^(HaoResult *errorResult) {
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
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            [self requestRecruitmentInfo];
//        } customButtonBlock:nil];
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
    if ([self.sectionTitles[section] isEqualToString:@"求职意向"]) {
        return 1;
    } else if ([self.sectionTitles[section] isEqualToString:@"工作经历"])
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
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 50)];
    
    UIView *titleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, ScreenSizeWidth, 35)];
    titleBackgroundView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenSizeWidth - 40, 35)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = DARKTEXTCOLOR;
    titleLabel.text = self.sectionTitles[section];
    [titleBackgroundView addSubview:titleLabel];
    
    // light line
    
    UIView *lightLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleBackgroundView.frame.size.height - 0.5, ScreenSizeWidth, 0.5)];
    lightLineView.backgroundColor = LIGHTLINECOLOR;
    [titleBackgroundView addSubview:lightLineView];
    [sectionView addSubview:titleBackgroundView];
    
    // line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, ScreenSizeWidth, 0.5)];
    lineView.backgroundColor = DARKLINECOLOR;
    [sectionView addSubview:lineView];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.sectionTitles[indexPath.section] isEqualToString:@"求职意向"]) {
        
        RecruitmentJobIntensionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentJobIntensionTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configCellWithData:self.jobIntensionData];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"工作经历"])
    {
        RecruitmentJobExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentJobExperienceTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configCellWithData:self.experienceData[indexPath.row]];
        return cell;
    } else if ([self.sectionTitles[indexPath.section] isEqualToString:@"教育经历"])
    {
        RecruitmentEducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentEducationTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.sectionTitles[indexPath.section] isEqualToString:@"作品展示"]) {
        PhotoShowViewController * photoView = [[PhotoShowViewController alloc] initWithNibName:@"PhotoShowViewController" bundle:nil];
        photoView.dataArray = [NSMutableArray arrayWithArray:_worksShowData];
        photoView.bundleIndex = indexPath.row;
        [self.navigationController presentViewController:photoView animated:YES completion:nil];
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
