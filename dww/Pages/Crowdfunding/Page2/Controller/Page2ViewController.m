//
//  Page2ViewController.m
//  dww
//
//  Created by 顾新生 on 2017/3/21.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "Page2ViewController.h"
#import "SearchButton.h"
#import "Page2HeaderView.h"
@interface Page2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SearchButton *titleView;
@property(nonatomic,strong)UIView *testView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)Page2HeaderView *headerView;

@end

@implementation Page2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.headerView.advanceView.isAutoScroll=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.headerView.advanceView.isAutoScroll=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavi{
    self.navigationItem.titleView=self.titleView;

}
-(void)setupSubviews{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.headerView=[[Page2HeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width*100/320+44)];
    self.tableView.tableHeaderView=self.headerView;
    __weak typeof(self) weakSelf=self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"%s",__func__);
        [self.tableView.mj_header endRefreshing];
    }];}

#pragma mark ---------------tableview delegate---------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=@"test";
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
#pragma mark ---------------setter & getter---------------
-(SearchButton *)titleView{
    if (_titleView==nil) {
        _titleView=[[SearchButton alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 26)];
        _titleView.clickBlock=^{
            NSLog(@"%s",__func__);
        };
    }
    return _titleView;
}
@end
