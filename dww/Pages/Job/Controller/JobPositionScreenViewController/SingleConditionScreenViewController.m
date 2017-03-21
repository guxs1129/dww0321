//
//  SingleConditionScreenViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/10.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "SingleConditionScreenViewController.h"
#import "ScreenJobPositionTableViewCell.h"

#define LIGHTGRAYCOLOR [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]
static NSString * const categoryID = @"categoryID";
extern NSString * const YZUpdateMenuTitleNote;
@interface SingleConditionScreenViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *categoryDataSource;
@property (assign, nonatomic) NSInteger selectedCategoryIndex;
@property (strong, nonatomic) NSArray *payCategoryDataSource;

@end

@implementation SingleConditionScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScreenJobPositionTableViewCell" bundle:nil] forCellReuseIdentifier:categoryID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.selectedCategoryIndex = NSNotFound;
    if (self.screenType == ScreenTypePay) {
        self.selectedCategoryIndex = 0;
        [self requestPayListData];
        
    } else if (self.screenType == ScreenTypeRecommend)
    {
        self.selectedCategoryIndex = 1;
 
        self.categoryDataSource = self.categoryDataSource = @[@{@"cName":@"推荐", @"cID":@"1"},
                                                              @{@"cName":@"最新", @"cID":@"0"},
                                                           ].mutableCopy;
        [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{@"title":NSValueToString(self.categoryDataSource[self.selectedCategoryIndex][@"cName"])}];
        [self.tableView reloadData];
    }
}


#pragma mark --- request

- (void)requestPayListData
{
    if (self.payCategoryDataSource && [self.payCategoryDataSource count] > 0) {
        self.categoryDataSource = [NSMutableArray arrayWithArray:self.payCategoryDataSource];
        [self.categoryDataSource insertObject:@{@"cName":@"不限", @"cIDcID":@""} atIndex:0];
        [self.tableView reloadData];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"DW_wage",@"c_alias",
               nil];
    
    [HaoConnect request:@"pub_category_group_d/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            self.payCategoryDataSource = result.results;
            self.categoryDataSource = [NSMutableArray arrayWithArray:self.payCategoryDataSource];
            [self.categoryDataSource insertObject:@{@"cName":@"不限", @"cID":@""} atIndex:0];
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

#pragma mark --- getter

- (NSMutableArray *)categoryDataSource
{
    if (!_categoryDataSource) {
        _categoryDataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _categoryDataSource;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.categoryDataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ScreenJobPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
    cell.contentView.backgroundColor = LIGHTGRAYCOLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == self.selectedCategoryIndex) {
        cell.checkoutImageView.hidden = NO;
    } else
    {
        cell.checkoutImageView.hidden = YES;
    }
    cell.titleLabel.text = self.categoryDataSource[indexPath.row][@"cName"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedCategoryIndex = indexPath.row;
    if (self.screenType == ScreenTypeRecommend) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{@"title":NSValueToString(self.categoryDataSource[indexPath.row][@"cName"])}];
    } else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{}];
    }
    if (self.completeChooseBlcok) {
        self.completeChooseBlcok(self.categoryDataSource[indexPath.row]);
    }
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
