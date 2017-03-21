//
//  MultipleConditionsScreenViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/10.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "MultipleConditionsScreenViewController.h"
#import "ScreenJobPositionTableViewCell.h"

#define LIGHTGRAYCOLOR [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]
static NSString * const categoryID = @"categoryID";
static NSString * const categoryDetailID = @"categoryDetailID";
extern NSString * const YZUpdateMenuTitleNote;
@interface MultipleConditionsScreenViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) IBOutlet UITableView *categoryDetailTableView;
@property (strong, nonatomic) IBOutlet UIButton *clearConditionsButton;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;
@property (assign, nonatomic) NSInteger selectedCategoryIndex;
@property (strong, nonatomic) NSMutableDictionary *selectedDetailCategoryIndex;

@property (strong, nonatomic) NSMutableArray *categoryDataSource;
@property (strong, nonatomic) NSMutableDictionary *detailCategoryDataSoucre;

@end

@implementation MultipleConditionsScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   [self.categoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:categoryID];

    [self.categoryDetailTableView registerNib:[UINib nibWithNibName:@"ScreenJobPositionTableViewCell" bundle:nil] forCellReuseIdentifier:categoryDetailID];
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.categoryDetailTableView.dataSource = self;
    self.categoryDetailTableView.delegate = self;
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.categoryDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.selectedCategoryIndex = NSNotFound;
    self.selectedDetailCategoryIndex = [NSMutableDictionary dictionaryWithCapacity:1];
    
    self.clearConditionsButton.backgroundColor = LIGHTGRAYCOLOR;
    self.clearConditionsButton.layer.cornerRadius = self.clearConditionsButton.frame.size.height / 2;
    self.clearConditionsButton.layer.borderColor = DARKLINECOLOR.CGColor;
    self.clearConditionsButton.clipsToBounds = YES;
    self.clearConditionsButton.layer.borderWidth = 0.5;
    
    self.commitButton.backgroundColor = CUSTOMORANGECOLOR;
    self.commitButton.layer.cornerRadius = self.clearConditionsButton.frame.size.height / 2;
    self.commitButton.clipsToBounds = YES;
    
    self.categoryDataSource = @[@{@"gName":@"学历要求", @"c_alias":@"DW_education", @"requestKey":@"education"},
                                @{@"gName":@"发布时间", @"c_alias":@"", @"requestKey":@"pub_time_range"},
                                @{@"gName":@"经验要求", @"c_alias":@"DW_experience", @"requestKey":@"experience"},
                                @{@"gName":@"职位类型", @"c_alias":@"DW_jobs_nature", @"requestKey":@"nature"},
                                @{@"gName":@"公司性质", @"c_alias":@"DW_company_type", @"requestKey":@"company_type"},
                                @{@"gName":@"公司规模", @"c_alias":@"DW_scale", @"requestKey":@"scale"}].mutableCopy;
}


#pragma mark --- button action 

- (IBAction)clickClearButtonAction:(id)sender {
    if (self.cleanAllChooseBlock) {
        NSMutableDictionary *selectedData = [NSMutableDictionary dictionaryWithCapacity:1];
        [self.selectedDetailCategoryIndex enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, NSNumber *  _Nonnull obj, BOOL * _Nonnull stop) {
            [selectedData setObject:self.detailCategoryDataSoucre[[NSString stringWithFormat:@"%ld", (long)[key integerValue]]][[obj integerValue]][@"cID"] forKey:self.categoryDataSource[[key integerValue]][@"requestKey"]];
        }];
        self.cleanAllChooseBlock(selectedData);
    }
    [self.selectedDetailCategoryIndex removeAllObjects];
    [self.categoryTableView reloadData];
    [self.categoryDetailTableView reloadData];
}

- (IBAction)clickCommitButtonAction:(id)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{}];
    if (self.didDismissBlock) {
        self.didDismissBlock();
    }
}

- (void)requestDetailConditionsListDataWithSelectedCategoryIndex:(NSInteger)index
{
    if (self.detailCategoryDataSoucre[[NSString stringWithFormat:@"%ld", (long)self.selectedCategoryIndex]] && [self.detailCategoryDataSoucre[[NSString stringWithFormat:@"%ld", (long)self.selectedCategoryIndex]] count] > 0) {
        [self.categoryDetailTableView reloadData];
        return;
    }
    NSString *alias = self.categoryDataSource[index][@"c_alias"];
    if (alias.length == 0) {
        [self.detailCategoryDataSoucre setObject:@[@{@"cName":@"全部",@"cID":@""},
                                                   @{@"cName":@"今天",@"cID":@"today"},
                                                   @{@"cName":@"最近三天",@"cID":@"3day"},
                                                   @{@"cName":@"最近一周",@"cID":@"1week"},
                                                   @{@"cName":@"最近一个月",@"cID":@"1month"}] forKey:[NSString stringWithFormat:@"%ld", (long)index]];
        [self.categoryDetailTableView reloadData];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               NSValueToString(alias),@"c_alias",
               nil];
 
    [HaoConnect request:@"pub_category_group_d/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:result.results];
            [tmpArray insertObject:@{@"cName":@"全部",@"cID":@""} atIndex:0];
            [self.detailCategoryDataSoucre setObject:tmpArray forKey:[NSString stringWithFormat:@"%ld", (long)index]];
            [self.categoryDetailTableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.categoryTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.categoryTableView didSelectRowAtIndexPath:indexPath];
}


#pragma mark --- getter

- (NSMutableDictionary *)detailCategoryDataSoucre
{
    if (!_detailCategoryDataSoucre) {
        _detailCategoryDataSoucre = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _detailCategoryDataSoucre;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        // 左边的类别表格
        return self.categoryDataSource.count;
        
    } else {
        // 右边的类别详情表格
        return self.detailCategoryDataSoucre[[NSString stringWithFormat:@"%ld", (long)self.selectedCategoryIndex]] ? [self.detailCategoryDataSoucre[[NSString stringWithFormat:@"%ld", (long)self.selectedCategoryIndex]] count] : 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        // 左边的类别表格
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.textLabel.text = self.categoryDataSource[indexPath.row][@"gName"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = DARKTEXTCOLOR;
        if (indexPath.row == self.selectedCategoryIndex) {
            cell.contentView.backgroundColor = LIGHTGRAYCOLOR;
        } else{
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        }
        return cell;
    }
    
    // 右边的类别详情表格
    ScreenJobPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryDetailID];
    cell.contentView.backgroundColor = LIGHTGRAYCOLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == [self.selectedDetailCategoryIndex[@(self.selectedCategoryIndex)] integerValue]) {
        cell.checkoutImageView.hidden = NO;
    } else
    {
        cell.checkoutImageView.hidden = YES;
    }
    cell.titleLabel.text = self.detailCategoryDataSoucre[[NSString stringWithFormat:@"%ld", (long)self.selectedCategoryIndex]][indexPath.row][@"cName"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        
        self.selectedCategoryIndex = indexPath.row;
        [self.categoryTableView reloadData];
        // 刷新右边数据
        [self requestDetailConditionsListDataWithSelectedCategoryIndex:indexPath.row];
        
        return;
    }
    
    // 右边的类别详情表格

    [self.selectedDetailCategoryIndex setObject:@(indexPath.row) forKey:@(self.selectedCategoryIndex)];
    [self.categoryDetailTableView reloadData];
    if (self.completeChooseBlock) {
        NSMutableDictionary *selectedData = [NSMutableDictionary dictionaryWithCapacity:1];
        [self.selectedDetailCategoryIndex enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, NSNumber *  _Nonnull obj, BOOL * _Nonnull stop) {
            [selectedData setObject:self.detailCategoryDataSoucre[[NSString stringWithFormat:@"%ld", (long)[key integerValue]]][[obj integerValue]][@"cID"] forKey:self.categoryDataSource[[key integerValue]][@"requestKey"]];
        }];
        self.completeChooseBlock(selectedData);
    }

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
