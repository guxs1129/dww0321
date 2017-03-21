//
//  SystemMessageListViewController.m
//  dww
//
//  Created by Shadow. G on 2016/12/30.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "SystemMessageListViewController.h"
#import "SystemMessageTableViewCell.h"
#import "DWSystemMessageModel.h"
#import "HaoConnect.h"
#import "NSDate+Utilities.h"

@interface SystemMessageListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<DWSystemMessageModel *> *tableViewDataSource;

@end

@implementation SystemMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"SystemMessageTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([SystemMessageTableViewCell class])];
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


#pragma mark ---

- (void)requestListData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               nil];
    [HaoConnect request:@"sys_pms/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (result.results && [result.results isKindOfClass:[NSArray class]]) {
                
                if ([result.results count] < 1) {
                    [self.view configBlankPage:EaseBlankPageTypeDefault hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                        
                    } customButtonBlock:nil];
                }
                [result.results enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    DWSystemMessageModel *model = [[DWSystemMessageModel alloc] init];
                    model.title = NSValueToString(obj[@"title"]);
                    model.message = NSValueToString(obj[@"message"]);
                    model.date = [[NSDate dateWithTimeIntervalSince1970:[NSValueToString(obj[@"dateline"]) doubleValue]] stringWithFormat:@"yyyy-MM-dd"];
                    [self.tableViewDataSource addObject:model];
                }];
            }

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

- (NSMutableArray<DWSystemMessageModel *> *)tableViewDataSource
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
    SystemMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SystemMessageTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DWSystemMessageModel *model = self.tableViewDataSource[indexPath.row];
    [cell setModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     DWSystemMessageModel *model = self.tableViewDataSource[indexPath.row];
    model.showDetail = !model.showDetail;
    [self.tableView reloadData];
}

//// 编辑状态
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self deleteSystemMessageWithIndexPath:indexPath];
//    }
//}
//
//// 修改默认的delete按钮文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

/**
 *  左滑出现什么按钮
 */
//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    tableView.editing = YES;
//    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//        [self.dataSource removeObjectAtIndex:indexPath.row];
//
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//        NSLog(@"删除--");
//    }];
//
//
//        action.backgroundColor = [UIColor orangeColor];
//
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//        //        [tableView reloadData];
//        //        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//        // 退出编辑模式
//        tableView.editing = NO;
//
//    }];
//    action1.backgroundColor = [UIColor orangeColor];
//
//    return @[action,action1];
//
//}

#pragma mark --- private methods

- (void)deleteSystemMessageWithIndexPath:(NSIndexPath *)indexPath
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    NSMutableDictionary *exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                    
//                                    NSValueToString(self.tableViewDataSource[indexPath.row][@"id"]),@"id",
//                                    nil];
//    [HaoConnect request:@"im_group_member/KickOutGroupMember" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if (result.isResultsOK) {
            [self.tableViewDataSource removeObjectAtIndex:indexPath.row];
    
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }
//        
//    } onError:^(HaoResult *errorResult) {
//        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//    }];

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
