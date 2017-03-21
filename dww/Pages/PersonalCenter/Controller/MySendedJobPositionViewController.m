//
//  MySendedJobPositionViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "MySendedJobPositionViewController.h"
#import "JobPositionDetailViewController.h"
#import "PersonalJobPositionTableViewCell.h"

@interface MySendedJobPositionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableViewDataSource;

@end

@implementation MySendedJobPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我投递的职位";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalJobPositionTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PersonalJobPositionTableViewCell class])];
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
               nil];
    [HaoConnect request:@"job_personal_position_apply/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (!result.results || [result.results count] < 1) {
                [self.view configBlankPage:EaseBlankPageTypeNosendResumeJob hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                    
                } customButtonBlock:nil];
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

- (void)requestDeleteJob_personal_position_applyWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *applyID = NSValueToString(self.tableViewDataSource[indexPath.row][@"id"]);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(applyID),@"id",
               nil];
    [HaoConnect request:@"job_personal_position_apply/del" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [MBProgressHUD showSuccess:@"删除成功" ToView:nil];
            [self.tableViewDataSource removeObjectAtIndex:indexPath.row];
            if (self.tableViewDataSource.count==0) {
                [self.view configBlankPage:EaseBlankPageTypeDefault hasData:NO hasError:NO reloadButtonBlock:nil customButtonBlock:nil];
            }
            
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        
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
    PersonalJobPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalJobPositionTableViewCell class])];
    cell.cellType = PersonalJobPositionCellTypeSending;
    
    if (indexPath.row + 1 == self.tableViewDataSource.count) {
        cell.bottomLineView.hidden = YES;
    } else
    {
        cell.bottomLineView.hidden = NO;
    }
    cell.didClickRightButtonBlock = ^{
        [SWAlertView showAlertWithTitle:@"温馨提示" message:@"您确定要要删除此记录吗？" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
            if (buttonIndex==1) {
                [self requestDeleteJob_personal_position_applyWithIndexPath:indexPath];
            }
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];

    };
    [cell configCellWithData:self.tableViewDataSource[indexPath.row]];
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
