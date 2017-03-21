//
//  JobPositionRecommendListViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JobPositionRecommendListViewController.h"
#import "JobPositionDetailViewController.h"
#import "JobPositionTableViewCell.h"

@interface JobPositionRecommendListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableViewDataSource;

@end

@implementation JobPositionRecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐给您的职位";
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
    [self requestListData];
}

#pragma mark --- request

- (void)requestListData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               [DWUserDataManager standardUserDefaults].userID,@"personal_uid",
               @"1",@"sourcefrom",
               nil];
    [HaoConnect request:@"job_personal_position_op/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if (!result.results || [result.results count] < 1) {
                [self.view configBlankPage:EaseBlankPageTypeDefault hasData:NO hasError:NO reloadButtonBlock:nil customButtonBlock:nil];
            }
            self.tableViewDataSource = [result.results mutableCopy];
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestListData];
        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

#pragma mark --- getter

- (NSMutableArray *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _tableViewDataSource;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JobPositionTableViewCell class])];
    if (indexPath.row + 1 == self.tableViewDataSource.count) {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0xd6d6d6"];
    } else
    {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0xECECEC"];
    }
    if (self.tableViewDataSource[indexPath.row] && [self.tableViewDataSource[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        [cell resetCellWithData:self.tableViewDataSource[indexPath.row][@"positionLocal"]];
    }
    
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobPositionDetailViewController *detailVC = [[JobPositionDetailViewController alloc] init];
    detailVC.jobPositionID = NSValueToString(self.tableViewDataSource[indexPath.row][@"positionID"]);
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
