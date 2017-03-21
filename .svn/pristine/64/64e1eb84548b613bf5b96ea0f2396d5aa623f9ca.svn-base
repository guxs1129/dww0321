//
//  ChooseIndustryViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/9.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "ChooseIndustryViewController.h"
#import "ChooseIndustryTableViewCell.h"

@interface ChooseIndustryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableViewDataSource;
@property (nonatomic) NSUInteger selectedIndex;

@end

@implementation ChooseIndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择行业";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseIndustryTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ChooseIndustryTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.selectedIndex = NSNotFound;
    [self requestListData];
}


#pragma mark --- navigation appearance

- (UIButton *)set_rightButton
{
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(0, 0, 40, 40);
    commitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
    return commitButton;
}

- (void)right_button_event:(UIButton *)sender
{
    if (self.selectedIndex == NSNotFound) {
        [MBProgressHUD showError:@"请先选择行业" ToView:nil];
        return;
    }
    if (self.completeChooseBlock) {
        self.completeChooseBlock(self.tableViewDataSource[self.selectedIndex][@"categoryname"], self.tableViewDataSource[self.selectedIndex][@"id"]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- request

- (void)requestListData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"1",@"grade",
               nil];
    [HaoConnect request:@"pub_category_position/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            self.tableViewDataSource = [result.results mutableCopy];
            if ([NSValueToString(self.industryID) length] > 0) {
                [self.tableViewDataSource enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([NSValueToString(self.industryID) isEqualToString:NSValueToString(obj[@"id"])]) {
                        self.selectedIndex = idx;
                        *stop = YES;
                    }
                }];
            }
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
    ChooseIndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChooseIndustryTableViewCell class])];
    
    cell.titleLabel.text = self.tableViewDataSource[indexPath.row][@"categoryname"];
    if (self.selectedIndex != NSNotFound && self.selectedIndex == indexPath.row) {
        cell.checkoutImageView.hidden = NO;
    } else
    {
        cell.checkoutImageView.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    [self.tableView reloadData];
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
