//
//  JobPositionHomeViewController.m
//  dww
//
//  Created by Shadow. G on 2016/12/26.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "JobPositionHomeViewController.h"
#import "JobPositionChooseCityViewController.h"
#import "JobPositionSearchViewController.h"
#import "MultipleConditionsScreenViewController.h"
#import "SingleConditionScreenViewController.h"
#import "JobPositionDetailViewController.h"
#import "UIButton+EdgeInsets.h"
#import "JobPositionTableViewCell.h"
#import "YZPullDownMenu.h"
#import "YZMenuButton.h"


#define kRequestParamsSDistrict @"sdistrict"
#define kSearchTypeAllwords @"keyword_contents" // 全文
#define kSearchTypePosition @"keyword"   // 职位
#define kSearchTypeCompany @"keyword_company"  // 公司
@interface JobPositionHomeViewController ()<UITableViewDelegate, UITableViewDataSource, PYSearchViewControllerDelegate,YZPullDownMenuDataSource>
{

    BOOL bundleBool;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *navigationSearchButton;
@property (strong, nonatomic) IBOutlet UIView *pullDownMenu;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableDictionary *extraParams;
@property (strong, nonatomic) IBOutlet UIView *searchButtonView;
@property (strong, nonatomic) UIButton *navigationChooseCityButton;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) YZPullDownMenu *menu;

@property (strong, nonatomic) NSArray *searchTypes;

// 用于数据回显
@property (nonatomic, strong) NSString *industryID;
@property (nonatomic, strong) NSString *jobPositionIDs;
@property (nonatomic, strong) NSString *jobFirstPositionIDs;
@property (nonatomic, strong) NSString *jobIndustryName;
@property (nonatomic, strong) NSString *jobPositionName;

@end

@implementation JobPositionHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchButtonView.frame = CGRectMake(0, 0, ScreenSizeWidth, 26);
    self.navigationSearchButton.backgroundColor = [UIColor colorWithHexString:@"0x52217A"];
    self.navigationSearchButton.clipsToBounds = YES;
    [self.navigationSearchButton addTarget:self action:@selector(clickSearchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.searchButtonView;
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"JobPositionTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([JobPositionTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    // pullDown munu
    self.menu = [[YZPullDownMenu alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 44)];
    self.menu.dataSource = self;
    self.menu.coverColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.menu.clipsToBounds = YES;
    JiaCoreWeakSelf(self);
    self.menu.didDismissBlock = ^{
        [weakself requestJobPositionListDataWithExtraExprames:weakself.extraParams];
    };
    [self.view addSubview:self.menu];
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
        make.bottom.mas_equalTo(self.tableView.mas_top).offset(0);
    }];
    
    self.searchTypes = @[kSearchTypeCompany, kSearchTypeAllwords, kSearchTypePosition];
    // 添加筛选子控制器
    [self setupAllChildViewController];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (bundleBool) {
            [weakself  requestJobPositionListDataWithExtraExprames:self.extraParams];
        }else{
            [weakself requestListData];
        }
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];

//    [self requestJobPositionListDataWithExtraExprames:nil];
//    [self requestListData];
}

#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    SingleConditionScreenViewController *recommentVC = [[SingleConditionScreenViewController alloc] init];
    recommentVC.screenType = ScreenTypeRecommend;
    recommentVC.completeChooseBlcok = ^(NSDictionary *selectedData){
        if ([NSValueToString(selectedData[@"cID"]) isEqualToString:@"1"]) {
            [self.extraParams setObject:NSValueToString(selectedData[@"cID"]) forKey:@"recommend"];
        } else{
            [self.extraParams removeObjectForKey:@"recommend"];
        }
        
    };
    SingleConditionScreenViewController *payVC = [[SingleConditionScreenViewController alloc] init];
    payVC.screenType = ScreenTypePay;
    payVC.completeChooseBlcok = ^(NSDictionary *selectedData){
        [self.extraParams setObject:NSValueToString(selectedData[@"cID"]) forKey:@"wage"];
    };
    MultipleConditionsScreenViewController *moreMenu = [[MultipleConditionsScreenViewController alloc] init];
    moreMenu.didDismissBlock = ^{
         [self requestJobPositionListDataWithExtraExprames:self.extraParams];
    };
    moreMenu.cleanAllChooseBlock = ^(NSDictionary *needCleaningSelectedData)
    {
        [needCleaningSelectedData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.extraParams removeObjectForKey:key];
        }];
        [self requestJobPositionListDataWithExtraExprames:self.extraParams];
    };
    moreMenu.completeChooseBlock = ^(NSDictionary *mutiSelectedData)
    {
        [mutiSelectedData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.extraParams setObject:obj forKey:key];
        }];
    };
    [self addChildViewController:recommentVC];
    [self addChildViewController:payVC];
    [self addChildViewController:moreMenu];
}

#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(YZPullDownMenu *)pullDownMenu
{
    return 3;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(YZPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index
{
    YZMenuButton *button = [YZMenuButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@[@"最新",@"薪资范围",@"更多筛选"][index] forState:UIControlStateNormal];
    [button setTitleColor:DARKTEXTCOLOR forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:kNavBackgroundColor forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"arrow_screen_normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"arrow_screen_selected"] forState:UIControlStateSelected];
    
    return button;
}

// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(YZPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(YZPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return 120;
            break;
        case 1:
            return ScreenSizeHeight * 0.55;
            break;
        case 2:
            return ScreenSizeHeight * 0.6;
            break;
        default:
            break;
    }
    return 0;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self layoutNavigationSearchButton];
}

- (void)layoutNavigationSearchButton
{
    self.navigationSearchButton.layer.cornerRadius = CGRectGetHeight(self.navigationSearchButton.frame) / 2;
    [self.navigationSearchButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:CGRectGetWidth(self.navigationSearchButton.frame) - CGRectGetWidth(self.navigationSearchButton.titleLabel.frame) - CGRectGetWidth(self.navigationSearchButton.imageView.frame) - 15 *2];
}

- (UIButton *)set_leftButton
{
    self.navigationChooseCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.navigationChooseCityButton.frame = CGRectMake(0, 0, 70, 44);
    self.navigationChooseCityButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.navigationChooseCityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.navigationChooseCityButton setTitle:@"选择城市" forState:UIControlStateNormal];
    [self.navigationChooseCityButton setImage:[UIImage imageNamed:@"arrow_below_white"] forState:UIControlStateNormal];
    [self.navigationChooseCityButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    return self.navigationChooseCityButton;
}

- (void)clickSearchButtonAction:(UIButton *)button
{
    bundleBool = YES;

    JobPositionSearchViewController *searchViewController = [JobPositionSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"请输入职位/公司" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        if ([NSValueToString(searchText) length] > 0) {
            [self.navigationSearchButton setTitle:NSValueToString(searchText) forState:UIControlStateNormal];
        } else
        {
            [self.navigationSearchButton setTitle:@"请输入职位/公司" forState:UIControlStateNormal];
        }
        JobPositionSearchViewController *jobPositionSearchVC = ((JobPositionSearchViewController *)searchViewController);
        [self.searchTypes enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.extraParams removeObjectForKey:obj];
        }];
        [self.extraParams setObject:trimming(searchText) forKey:NSValueToString(jobPositionSearchVC.searchType)];
        if (jobPositionSearchVC.completeBlock) {
            jobPositionSearchVC.completeBlock(jobPositionSearchVC.exparams, jobPositionSearchVC.industryID, jobPositionSearchVC.jobFirstPositionIDs, jobPositionSearchVC.jobPositionIDs, jobPositionSearchVC.jobIndustryName, jobPositionSearchVC.jobPositionName);
        }
        [searchViewController.navigationController popViewControllerAnimated:YES];
        
    }];
    searchViewController.completeBlock = ^(NSDictionary *params, NSString *industryID, NSString *firstPositionIDs, NSString * secondPositionIDs, NSString *jobIndustryName , NSString *jobPositionName){
        
        self.jobPositionIDs = secondPositionIDs;
        self.industryID = industryID;
        self.jobFirstPositionIDs = firstPositionIDs;
        self.jobIndustryName = jobIndustryName;
        self.jobPositionName = jobPositionName;
        [params enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.extraParams setObject:NSValueToString(obj) forKey:NSValueToString(key)];
        }];
        [self.menu mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.bottom.mas_equalTo(self.tableView.mas_top).offset(0);
        }];
        [self.view layoutIfNeeded];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelButton];
        [self requestJobPositionListDataWithExtraExprames:self.extraParams];
    };
    searchViewController.industryID = self.industryID;
    searchViewController.jobPositionIDs = self.jobPositionIDs;
    searchViewController.jobFirstPositionIDs = self.jobFirstPositionIDs;
    searchViewController.jobIndustryName = self.jobIndustryName;
    searchViewController.jobPositionName = self.jobPositionName;
    searchViewController.showHotSearch = NO;
    searchViewController.showSearchHistory = NO;
    searchViewController.delegate = self;
    searchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)left_button_event:(UIButton *)sender
{
    bundleBool = YES;
    JobPositionChooseCityViewController *chooseCityVC = [[JobPositionChooseCityViewController alloc] init];
    [chooseCityVC setCompleteChooseCityBlock:^(NSString *cityName, NSString *cityID) {
        [self.navigationChooseCityButton setTitle:cityName forState:UIControlStateNormal];
        [self.navigationChooseCityButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
        [self.extraParams setObject:NSValueToString(cityID) forKey:kRequestParamsSDistrict];
        [self requestJobPositionListDataWithExtraExprames:self.extraParams];
    }];
    chooseCityVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chooseCityVC animated:YES];
}

- (UIButton *)set_rightButton
{
    return [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
}


#pragma mark --- getter

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (NSMutableDictionary *)extraParams
{
    if (!_extraParams) {
        _extraParams = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _extraParams;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 0, 40, 40);
        _cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (void)cancelAction
{
    NSMutableDictionary *tmpDic = self.extraParams;
    
    [tmpDic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![NSValueToString(key) isEqualToString:kRequestParamsSDistrict]) {
            [self.extraParams removeObjectForKey:NSValueToString(key)];
        }
    }];
    [self.menu reload];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[SingleConditionScreenViewController class]] || [obj isKindOfClass:[MultipleConditionsScreenViewController class]]) {
            [obj removeFromParentViewController];
        }
    }];
    [self setupAllChildViewController];
    self.jobPositionName = @"";
    self.jobIndustryName = @"";
    self.jobFirstPositionIDs = @"";
    self.jobPositionIDs = @"";
    self.industryID = @"";
    [self.navigationSearchButton setTitle:@"请输入职位/公司" forState:UIControlStateNormal];
    [self.menu mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
        make.bottom.mas_equalTo(self.tableView.mas_top).offset(0);
    }];
    [self.view layoutIfNeeded];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self set_rightButton]];
    bundleBool = NO;
    [self requestListData];
//    [self requestJobPositionListDataWithExtraExprames:self.extraParams];
}

#pragma mark---首页数据展示
-(void)requestListData{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"DW_jobindexPositionAPP",@"alias",
               nil];
    
    [HaoConnect request:@"pub_adv_content/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        if (result.isResultsOK) {
            if (!result.results || [result.results count] < 1) {
                [self.view configBlankPage:EaseBlankPageTypeDefault hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                    
                } customButtonBlock:nil];
            } else
            {
                [self.view configBlankPage:EaseBlankPageTypeDefault hasData:YES hasError:YES reloadButtonBlock:^(id sender) {
                    
                } customButtonBlock:nil];
            }
            
            NSMutableArray *realDataSource = [NSMutableArray arrayWithCapacity:1];
            [result.results enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                    NSDictionary * imgPositionidLocal = obj[@"imgPositionidLocal"];
                    if (imgPositionidLocal && [imgPositionidLocal isKindOfClass:[NSDictionary class]]) {
                        [realDataSource addObject:imgPositionidLocal];
                    }
                   
                }
            }];
            self.dataSource = realDataSource;
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        if (!self.dataSource || [self.dataSource count] < 1) {
            [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [self.tableView.mj_header beginRefreshing];
            } customButtonBlock:nil];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

    
}

#pragma mark --- request

- (void)requestJobPositionListDataWithExtraExprames:(NSDictionary *)extraExprames
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"302",@"position_status",
               nil];
    if (extraExprames) {
        [extraExprames enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [exprame setObject:obj forKey:key];
        }];
    }
    
    [HaoConnect request:@"job_position/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        if (result.isResultsOK) {
            if (!result.results || [result.results count] < 1) {
                [self.view configBlankPage:EaseBlankPageTypeDefault hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                    
                } customButtonBlock:nil];
            } else
            {
                [self.view configBlankPage:EaseBlankPageTypeDefault hasData:YES hasError:YES reloadButtonBlock:^(id sender) {
                    
                } customButtonBlock:nil];
            }
            self.dataSource = [result.results mutableCopy];
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        if (!self.dataSource || [self.dataSource count] < 1) {
            [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [self.tableView.mj_header beginRefreshing];
            } customButtonBlock:nil];
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}


#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    JobPositionSearchViewController *jobPositionSearchVC = ((JobPositionSearchViewController *)searchViewController);
    if (trimming(searchText).length) { // 与搜索条件再搜索
        
        jobPositionSearchVC.commitButton.hidden = YES;
        jobPositionSearchVC.chooseIndustryView.hidden = YES;
        jobPositionSearchVC.chooseJobPositionView.hidden = YES;
        // 根据条件发送查询
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary * exprame  = nil;
        exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   @"1",@"page",
                   @"10",@"size",
                   trimming(searchText),@"keyword",
                   nil];

        [HaoConnect request:@"pub_hotword/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (result.isResultsOK) {
                
                NSMutableArray *searchSuggestionsM = [NSMutableArray array];
                if (result.results && [result.results isKindOfClass:[NSArray class]]) {
                    [result.results enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSString *suggestionString = trimming(obj[@"wWord"]);
                        [searchSuggestionsM addObject:suggestionString];
                    }];
                    searchViewController.searchSuggestions = searchSuggestionsM;
                }
            
            }
            
        } onError:^(HaoResult *errorResult) {
            
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];

    } else
    {
        jobPositionSearchVC.commitButton.hidden = NO;
        jobPositionSearchVC.chooseIndustryView.hidden = NO;
        jobPositionSearchVC.chooseJobPositionView.hidden = NO;
    }
}

/** 点击搜索建议时调用，如果实现该代理方法则点击搜索建议时searchViewController:didSearchWithsearchBar:searchText:失效 */
//- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndex:(NSInteger)index searchText:(NSString *)searchText
//{
//    
//}

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
    JobPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JobPositionTableViewCell class])];
    
    [cell resetCellWithData:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobPositionDetailViewController *detailVC = [[JobPositionDetailViewController alloc] init];
    if (self.dataSource[indexPath.row][@"imgPositionidLocal"]) {
        detailVC.jobPositionID = NSValueToString(self.dataSource[indexPath.row][@"imgPositionidLocal"][@"id"]);
    }else{
        detailVC.jobPositionID = NSValueToString(self.dataSource[indexPath.row][@"id"]);
    }
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
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
