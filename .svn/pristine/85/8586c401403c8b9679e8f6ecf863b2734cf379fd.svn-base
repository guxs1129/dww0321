//
//  MyRecruitmentLookedViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/9.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "MyRecruitmentLookedViewController.h"
#import "CompanyDetailViewController.h"
#import "PersonalRecruitmentTableViewCell.h"

@interface MyRecruitmentLookedViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableViewDataSource;

@end

@implementation MyRecruitmentLookedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"近期谁查看过我的简历";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalRecruitmentTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PersonalRecruitmentTableViewCell class])];
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
               
               nil];
    [HaoConnect request:@"job_company_label_v/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if (!result.results || [result.results count] < 1) {
                [self.view configBlankPage:EaseBlankPageTypeNoPersonlookResume hasData:NO hasError:NO reloadButtonBlock:nil customButtonBlock:nil];
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
    PersonalRecruitmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalRecruitmentTableViewCell class])];
    cell.cellType = RecruitmentCellTypeLooking;
    __weak typeof(self) weakSelf = self;
    cell.didClickDeleteButtonBlock = ^{
        
        [SWAlertView showAlertWithTitle:@"温馨提示" message:@"您确定要删除此记录吗？" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
            if (buttonIndex==1) {
                [weakSelf requestDeleteIndex:indexPath];
            }
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        
    };
    [cell configCellWithData:self.tableViewDataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompanyDetailViewController *companyDetailVC = [[CompanyDetailViewController alloc] init];
    companyDetailVC.companyID = NSValueToString(self.tableViewDataSource[indexPath.row][@"companyID"]);
    [self.navigationController pushViewController:companyDetailVC animated:YES];
}
//删除谁看过我的简历的企业
-(void)requestDeleteIndex:(NSIndexPath *)indexPath{
    NSString *sID = NSValueToString(self.tableViewDataSource[indexPath.row][@"id"]);

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               sID,@"id",
               @"2",@"user_op",
               
               nil];
    [HaoConnect request:@"job_company_resume/update_op_status" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [MBProgressHUD showSuccess:@"删除成功" ToView:nil];
            [self.tableViewDataSource removeObjectAtIndex:indexPath.row];
            if (self.tableViewDataSource.count==0) {
                [self.view configBlankPage:EaseBlankPageTypeDefault hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                    
                } customButtonBlock:nil];
            }
            
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    

    
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
