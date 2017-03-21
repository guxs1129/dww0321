//
//  PersonalCenterHomeViewController.m
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "PersonalCenterHomeViewController.h"
#import "PersonalCenterHomeTableViewCell.h"
#import "PositionSubscriberListViewController.h"
#import "SystemMessageListViewController.h"
#import "JobPositionRecommendListViewController.h"
#import "MySendedJobPositionViewController.h"
#import "MyCollectedJobPositionViewController.h"
#import "MyRecruitmentDownloadedViewController.h"
#import "MyRecruitmentLookedViewController.h"
#import "SystemSettingViewController.h"
#import "FeedbackViewController.h"
#import "DWAboutUsViewController.h"
#import "UITableView+Common.h"

#define kLookRecruitmentTitle @"近期谁查看过我的简历"
#define kDownloadRecruitmentTitle @"近期谁下载过我的简历"
#define kCellHeight 48
@interface PersonalCenterHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *selectedCellActionSource;
@property (strong, nonatomic) UIButton *systemMessageButton;
@property (assign, nonatomic) BOOL isShowCompanyLookCountLabel;
@property (assign, nonatomic) BOOL isShowCompanyDownloadCountLabel;

@end

@implementation PersonalCenterHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.cyl_tabBarController.hidesBottomBarWhenPushed = NO;
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    self.cyl_tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalCenterHomeTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PersonalCenterHomeTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self setupTableViewDataSource];
    [self requestJobCompanyLabelVCountAndJobCompanyDownVCount];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.cyl_tabBarController.hidesBottomBarWhenPushed = NO;
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    self.cyl_tabBarController.tabBar.hidden = NO;
}


#pragma mark --- request

- (void)requestJobCompanyLabelVCountAndJobCompanyDownVCount
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
 
    [HaoConnect request:@"job_company_label_v/view_adn_down_group_count" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if ([NSValueToString(result.results[@"jobCompanyLabelVCount"]) integerValue] > 0) {
                self.isShowCompanyLookCountLabel = YES;
            }
            if ([NSValueToString(result.results[@"jobCompanyDownVCount"]) integerValue] > 0) {
                self.isShowCompanyDownloadCountLabel = YES;
            }
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

#pragma mark --- navigation appearance

- (UIButton *)set_rightButton
{
    self.systemMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.systemMessageButton.frame = CGRectMake(0, 0, 65, 40);
    self.systemMessageButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.systemMessageButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.systemMessageButton setTitle:@"消息" forState:UIControlStateNormal];
    [self.systemMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.systemMessageButton setImage:[UIImage imageNamed:@"my_information"] forState:UIControlStateNormal];
    [self.systemMessageButton setImage:[UIImage imageNamed:@"my_information_c"] forState:UIControlStateSelected];
    return self.systemMessageButton;
}

- (void)right_button_event:(UIButton *)sender
{
    SystemMessageListViewController *messageListVC = [[SystemMessageListViewController alloc] init];
    messageListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageListVC animated:YES];
}

- (void)setupTableViewDataSource
{
    self.dataSource = @[@[@"我投递的职位",@"我收藏的职位",kLookRecruitmentTitle,kDownloadRecruitmentTitle],
                        @[@"推荐给您的职位", @"职位订阅器"],
                        @[@"设置", @"意见反馈", @"关于我们"]].mutableCopy;
    self.selectedCellActionSource = @[
  @[NSStringFromSelector(@selector(gotoPositionOfSendingView)),
    NSStringFromSelector(@selector(gotoPositionOfCollectionView)),
    NSStringFromSelector(@selector(gotoRecruitmentOfLookingView)),
    NSStringFromSelector(@selector(gotoRecruitmentOfDownloadingView))
                                        ],
  @[NSStringFromSelector(@selector(gotoPositionOfRecommendView)),
    NSStringFromSelector(@selector(gotoPositionSubscriberView))],
  
  @[NSStringFromSelector(@selector(gotoSystemSettingView)),
    NSStringFromSelector(@selector(gotoFeedbackView)),
    NSStringFromSelector(@selector(gotoAboutUsView))
    ]
  ].mutableCopy;
}


#pragma mark --- tableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalCenterHomeTableViewCell class])];
    [tableView addLineforPlainCell:cell cellHeight:kCellHeight forRowAtIndexPath:indexPath withLeftSpace:0 hasSectionLine:YES];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
    if ([cell.titleLabel.text isEqualToString:kLookRecruitmentTitle]) {
        cell.numberCountLabel.hidden = !self.isShowCompanyLookCountLabel;
    }else if ([cell.titleLabel.text isEqualToString:kDownloadRecruitmentTitle])
    {
        cell.numberCountLabel.hidden = !self.isShowCompanyDownloadCountLabel;
    }
    else
    {
        cell.numberCountLabel.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SEL method = NSSelectorFromString(self.selectedCellActionSource[indexPath.section][indexPath.row]);
    [self performSelector:method withObject:nil];
}


#pragma mark --- selected cell action

// 我投递的职位
- (void)gotoPositionOfSendingView
{
    MySendedJobPositionViewController *sendedVC = [[MySendedJobPositionViewController alloc] init];
    sendedVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sendedVC animated:YES];
}

// 我收藏的职位
- (void)gotoPositionOfCollectionView
{
    MyCollectedJobPositionViewController *collectedVC = [[MyCollectedJobPositionViewController alloc] init];
    collectedVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:collectedVC animated:YES];
}

// 近期谁查看过我的简历
- (void)gotoRecruitmentOfLookingView
{
    MyRecruitmentLookedViewController *recruitmentLookedVC = [[MyRecruitmentLookedViewController alloc] init];
    recruitmentLookedVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recruitmentLookedVC animated:YES];
}

// 近期谁下载过我的简历
- (void)gotoRecruitmentOfDownloadingView
{
    MyRecruitmentDownloadedViewController *recruitmentDownloadedVC = [[MyRecruitmentDownloadedViewController alloc] init];
     recruitmentDownloadedVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recruitmentDownloadedVC animated:YES];
}

// 推荐给您的职位
- (void)gotoPositionOfRecommendView
{
    JobPositionRecommendListViewController *recommendListVC = [[JobPositionRecommendListViewController alloc] init];
    recommendListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recommendListVC animated:YES];
}

// 职位订阅器
- (void)gotoPositionSubscriberView
{
    PositionSubscriberListViewController *subscriberVC = [[PositionSubscriberListViewController alloc] init];
    subscriberVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subscriberVC animated:YES];
}

// 设置
- (void)gotoSystemSettingView
{
    SystemSettingViewController *settingVC = [[SystemSettingViewController alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}

// 意见反馈
- (void)gotoFeedbackView
{
    FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] init];
    feedbackVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedbackVC animated:YES];
}

// 关于我们
- (void)gotoAboutUsView
{
    DWAboutUsViewController *aboutUsVC = [[DWAboutUsViewController alloc] init];
    aboutUsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVC animated:YES];
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
