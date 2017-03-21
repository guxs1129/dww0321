//
//  PositionSubscriberListViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "PositionSubscriberListViewController.h"
#import "PositionSubscriberViewController.h"
#import "PositionSubscriberListTableViewCell.h"

@interface PositionSubscriberListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tableViewDataSource;

@end

@implementation PositionSubscriberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"职位订阅器";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"PositionSubscriberListTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PositionSubscriberListTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self requestJobSubscriberListData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestJobSubscriberListData) name:kPositionSubscriberRefreshDataNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
}



#pragma mark --- request

- (void)requestJobSubscriberListData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               [DWUserDataManager standardUserDefaults].userID,@"user_id",
               nil];
    [HaoConnect request:@"job_subscriber_conf/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (!result.results || ![result.results isKindOfClass:[NSArray class]] || [result.results count] < 1) {
                
                [self.view configBlankPage:EaseBlankPageTypeBookingJob hasData:NO hasError:NO reloadButtonBlock:nil customButtonBlock:^(UIButton *sender) {
                    PositionSubscriberViewController *subscriberVC = [[PositionSubscriberViewController alloc] init];
                    subscriberVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:subscriberVC animated:YES];
                }];

                self.tableView.scrollEnabled = NO;
                return ;
            }
            
            [self.view configBlankPage:EaseBlankPageTypeNoRecruitment hasData:YES hasError:NO reloadButtonBlock:nil customButtonBlock:nil];
            self.tableView.scrollEnabled = YES;
            self.tableViewDataSource = [result.results mutableCopy];
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestJobSubscriberListData];
        } customButtonBlock:nil];
        self.tableView.scrollEnabled = NO;
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
    PositionSubscriberListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PositionSubscriberListTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row + 1 == self.tableViewDataSource.count) {
        cell.bottomLineView.hidden = YES;
    } else
    {
        cell.bottomLineView.hidden = NO;
    }
    cell.didClickDeleteButtonBlcok = ^{
        [self didClickDeleteButtonActionWithIndexPath:indexPath];
    };
    cell.didClickEditButtonBlock = ^{
        [self didClickEditButtonActionWithIndexPath:indexPath];
    };
    [cell configCellWithData:self.tableViewDataSource[indexPath.row]];
    return cell;
}


#pragma mark --- cell block

- (void)didClickEditButtonActionWithIndexPath:(NSIndexPath *)indexPath
{
    PositionSubscriberViewController *subscriberVC = [[PositionSubscriberViewController alloc] init];
    subscriberVC.hidesBottomBarWhenPushed = YES;
    subscriberVC.subscriberID = NSValueToString(self.tableViewDataSource[indexPath.row][@"id"]);
    [self.navigationController pushViewController:subscriberVC animated:YES];
}

- (void)didClickDeleteButtonActionWithIndexPath:(NSIndexPath *)indexPath
{
    [SWAlertView showAlertWithTitle:@"" message:@"是否删除" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSMutableDictionary * exprame  = nil;
            exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       NSValueToString(self.tableViewDataSource[indexPath.row][@"id"]),@"id",
                       nil];
            [HaoConnect request:@"job_subscriber_conf/delete" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if (result.isResultsOK) {
                    [MBProgressHUD showSuccess:@"删除成功" ToView:nil];
                    [self.tableViewDataSource removeObjectAtIndex:indexPath.row];
                    [self requestJobSubscriberListData];
                }
                
            } onError:^(HaoResult *errorResult) {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
        }
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPositionSubscriberRefreshDataNotification object:nil];
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
