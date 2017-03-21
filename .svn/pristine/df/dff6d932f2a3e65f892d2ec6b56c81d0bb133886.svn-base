//
//  DWHomeListViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/6.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "DWHomeListViewController.h"
#import "CompanyDetailViewController.h"
#import "DWLoginViewController.h"
#import "UIViewController+Login.h"
#import "HXAdvantismentView.h"
#import "DWHomeCompanyTableViewCell.h"
#import "CrowdTabBarController.h"
@interface DWHomeListViewController ()<UITableViewDelegate, UITableViewDataSource, HXAdvantismentViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *advanceBackgroundView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic,strong) HXAdvantismentView * advanceView;

@end

@implementation DWHomeListViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self needLogin]) {
        [self goLogin];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 暂停定时器
    self.advanceView.isAutoScroll = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.advanceView.isAutoScroll = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"DWHomeCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWHomeCompanyTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
//    UIEdgeInsets contentInset = self.tableView.contentInset;
//    contentInset.top = -20;
//    [self.tableView setContentInset:contentInset];
    
    self.advanceView = [[HXAdvantismentView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, ScreenSizeWidth * 100 / 320)];
    self.advanceView.delegate = self;
    self.advanceView.timeInteval = 4.0f;
    self.advanceView.isAutoScroll = YES;
    [self.advanceBackgroundView addSubview:self.advanceView];
    self.advanceView.imagesUrlArray = @[@"banner_default"].mutableCopy;
    
    self.headerView.frame = CGRectMake(0, 0, ScreenSizeWidth, self.advanceView.frame.size.height + 150);
    self.tableView.tableHeaderView = self.headerView;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    JiaCoreWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestCompanyListData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
//    [self requestCompanyListData];
}


#pragma mark --- request

- (void)requestCompanyListData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
//               @"302",@"position_status",
//               @"companyBrandingApp",@"load_type",
               @"DW_indexCompanyBrandingAPP",@"alias",
               nil];
    
    [HaoConnect request:@"pub_adv_content/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            self.dataSource = [result.results mutableCopy];
            [self.tableView reloadData];

        }
        
    } onError:^(HaoResult *errorResult) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}


#pragma mark --- button action

- (IBAction)clickPersonnelRecruitmentButtonAction:(id)sender {
    self.tabBarController.selectedIndex = 1;
}
- (IBAction)clickCrowdfunding:(id)sender {
    CrowdTabBarController *crowdTabBarController=[[CrowdTabBarController alloc]init];
    [self presentViewController:crowdTabBarController animated:NO completion:nil];
}


#pragma mark --- getter

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


#pragma mark --- HXAdvantismentViewDelegate ---
// 点击轮播图当前图片执行
- (void)didClickPage:(HXAdvantismentView *)view atIndex:(NSInteger)index
{
    NSLog(@"index:%ld", (long)index);
 
}


#pragma mark --- tableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWHomeCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWHomeCompanyTableViewCell class])];
    
    [cell resetCellWithData:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompanyDetailViewController *companyDetailVC = [[CompanyDetailViewController alloc] init];
    companyDetailVC.companyID = NSValueToString(self.dataSource[indexPath.row][@"imgCompanyidLocal"][@"companyid"]);
//    companyDetailVC.jobPositionID = self.jobPositionID;
//    companyDetailVC.isApply = self.isApply;
    [self.navigationController pushViewController:companyDetailVC animated:YES];
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
