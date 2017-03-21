//
//  DWAboutUsViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "DWAboutUsViewController.h"
#import "AboutUsTableViewCell.h"

@interface DWAboutUsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableViewDataSource;
@property (strong, nonatomic) NSArray *tableViewTitles;

@end

@implementation DWAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"AboutUsTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AboutUsTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setupDataSource];

}

- (void)setupDataSource
{
    self.tableViewTitles = @[@"服务热线", @"E-mail", @"大文微信", @"大文微博"];
    self.tableViewDataSource = @[@"400-888-1234", @"Dawen@163.com", @"大文助手", @"@大文网"].mutableCopy;
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
    AboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AboutUsTableViewCell class])];
    cell.contentLabel.text = self.tableViewDataSource[indexPath.row];
    cell.titleLabel.text = self.tableViewTitles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
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
