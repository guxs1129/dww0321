//
//  ChooseJobPositionViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/9.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "ChooseJobPositionViewController.h"
#import "ChooseJobPositionTableViewCell.h"

@interface ChooseJobPositionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableDictionary *tableViewDataSource;
@property (strong, nonatomic) NSMutableArray *tableViewTitles; // 分区headerview标题数据
@property (strong, nonatomic) NSMutableDictionary *selectedDataSoucre; // 保存选中的数据的index
@property (strong, nonatomic) NSMutableDictionary *sectionArrowStatusDic; // 判断分区箭头方向
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *selectedJobPositionBackgroundView;
@property (strong, nonatomic) IBOutlet UILabel *selectedCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headerArrowImageView;

@end

@implementation ChooseJobPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择职能";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"ChooseJobPositionTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ChooseJobPositionTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self resetHeaderViewWithCurrentCount:0];
    [self requestListData];
}

- (IBAction)clickHeaderViewAction:(UIButton *)sender {
    
    self.headerArrowImageView.highlighted = !self.headerArrowImageView.highlighted;
    CGRect frame = self.headerView.frame;
    frame.size.height = self.headerArrowImageView.highlighted ? 80 : 40;
    self.headerView.frame = frame;
    self.tableView.tableHeaderView = self.headerView;
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
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:1];
    if (self.selectedDataSoucre && [self.selectedDataSoucre isKindOfClass:[NSDictionary class]]) {
        [self.selectedDataSoucre enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull section, NSArray * _Nonnull sectionData, BOOL * _Nonnull stop) {
            
            if (sectionData && [sectionData isKindOfClass:[NSArray class]]) {
                [sectionData enumerateObjectsUsingBlock:^(NSString *  _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [tmpArray addObject:self.tableViewDataSource[section][[row integerValue]]];
                   
                }];
            }
        }];
    }

    if (self.completeChoosePositionBlock) {
        self.completeChoosePositionBlock(tmpArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- getter

- (NSMutableArray *)tableViewTitles
{
    if (!_tableViewTitles) {
        _tableViewTitles = [NSMutableArray arrayWithCapacity:1];
    }
    return _tableViewTitles;
}

- (NSMutableDictionary *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _tableViewDataSource;
}

- (NSMutableDictionary *)selectedDataSoucre
{
    if (!_selectedDataSoucre) {
        _selectedDataSoucre = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _selectedDataSoucre;
}

- (NSMutableDictionary *)sectionArrowStatusDic
{
    if (!_sectionArrowStatusDic) {
        _sectionArrowStatusDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _sectionArrowStatusDic;
}

#pragma mark --- request

- (void)requestListData
{
    if ([NSValueToString(self.industryID) length] <= 0) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"2",@"grade",
               self.industryID,@"parentid",
               nil];
    [HaoConnect request:@"pub_category_position/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            self.tableViewTitles = [result.results mutableCopy];
            
            if (self.tableViewTitles.count == 1) {
                [self clickSectionViewAcitonWithIndex:0 isMustShow:YES];
            }
            if ([NSValueToString(self.firstJobPositionIDs) length] > 0) {
                NSArray *selectedfirstJobPosition = [self.firstJobPositionIDs componentsSeparatedByString:@","];
                [selectedfirstJobPosition enumerateObjectsUsingBlock:^(NSString  * _Nonnull firstJobPositionID, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([NSValueToString(firstJobPositionID) length] > 0) {
                        [self.tableViewTitles enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([NSValueToString(obj[@"id"]) isEqualToString:firstJobPositionID]) {
                                [self clickSectionViewAcitonWithIndex:idx isMustShow:YES];
                                *stop = YES;
                            }
                        }];
                    }
                }];
            }

            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

- (void)requestSublistDataWithSectionIndex:(NSInteger)sectionIndex
{
    NSString *parentID = self.tableViewTitles[sectionIndex][@"id"];
    if ([NSValueToString(parentID) length] <= 0) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"3",@"grade",
               parentID,@"parentid",
               nil];
    [HaoConnect request:@"pub_category_position/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [self.tableViewDataSource setObject:result.results forKey:[NSString stringWithFormat:@"%ld", (long)sectionIndex]];
            if (result.results && [result.results isKindOfClass:[NSArray class]] && [result.results count] > 0) {
                NSArray *selectedSecondJobPosition = [self.secondJobPositionIDs componentsSeparatedByString:@","];
                [selectedSecondJobPosition enumerateObjectsUsingBlock:^(NSString  * _Nonnull secondJobPositionID, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([NSValueToString(secondJobPositionID) length] > 0) {
                        [result.results enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([NSValueToString(obj[@"id"]) isEqualToString:secondJobPositionID]) {
                                [self cellActionWithSection:sectionIndex row:idx];
                                *stop = YES;
                            }
                        }];
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
    return self.tableViewTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sectionArrowStatusDic[[NSString stringWithFormat:@"%ld", (long)section]]) {
        
        if ([self.sectionArrowStatusDic[[NSString stringWithFormat:@"%ld", (long)section]] isEqualToString:@"1"]) {
            return [self.tableViewDataSource[[NSString stringWithFormat:@"%ld", (long)section]] count];
            
        } else
        {
            return 0;
        }
    } else
    {
        return 0;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    titleLabel.text = self.tableViewTitles[section][@"categoryname"];
    UIImageView *checkoutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"job_checkout"]];
    checkoutImageView.hidden = YES;
    checkoutImageView.contentMode = UIViewContentModeScaleAspectFit;
    if ([self.selectedDataSoucre objectForKey:[NSString stringWithFormat:@"%ld", (long)section]]) {
        if ([[self.selectedDataSoucre objectForKey:[NSString stringWithFormat:@"%ld", (long)section]] isKindOfClass:[NSArray class]] && [[self.selectedDataSoucre objectForKey:[NSString stringWithFormat:@"%ld", (long)section]] count] > 0) {
            checkoutImageView.hidden = NO;
        }
    }
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chooseJob_arrowdown"] highlightedImage:[UIImage imageNamed:@"chooseJob_arrowup"]];
    arrowImageView.highlighted = self.sectionArrowStatusDic[[NSString stringWithFormat:@"%ld", (long)section]] ? [self.sectionArrowStatusDic[[NSString stringWithFormat:@"%ld", (long)section]] boolValue] : NO;
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [headerView addSubview:titleLabel];
    [headerView addSubview:checkoutImageView];
    [headerView addSubview:arrowImageView];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(checkoutImageView.mas_left).offset(-20);
    }];
    [titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [checkoutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(15);
        make.right.mas_greaterThanOrEqualTo(arrowImageView.mas_left).offset(-10).with.priority(750);
    }];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(15);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LIGHTLINECOLOR;
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.tag = section;
    [headerView addSubview:actionButton];
    [actionButton addTarget:self action:@selector(clickSectionView:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.mas_equalTo(0);
    }];
    
    return headerView;
}

- (void)clickSectionView:(UIButton *)actionButton
{

    [self clickSectionViewAcitonWithIndex:(long)actionButton.tag isMustShow:NO];
   
}

- (void)clickSectionViewAcitonWithIndex:(NSInteger)index isMustShow:(BOOL)isMustShow
{
    if (isMustShow) {
        [self.sectionArrowStatusDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)index]];
        [self requestSublistDataWithSectionIndex:index];
        return;
    }
    if (self.sectionArrowStatusDic[[NSString stringWithFormat:@"%ld", (long)index]]) {
        
        if ([self.sectionArrowStatusDic[[NSString stringWithFormat:@"%ld", (long)index]] isEqualToString:@"1"]) {
            [self.sectionArrowStatusDic setObject:@"0" forKey:[NSString stringWithFormat:@"%ld", (long)index]];
            [self.tableView reloadData];
        } else
        {
            [self.sectionArrowStatusDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)index]];
            [self requestSublistDataWithSectionIndex:index];
        }
    } else
    {
        [self.sectionArrowStatusDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)index]];
        [self requestSublistDataWithSectionIndex:index];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseJobPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChooseJobPositionTableViewCell class])];
    
    NSDictionary *data = self.tableViewDataSource[[NSString stringWithFormat:@"%ld", (long)indexPath.section]][indexPath.row];
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        cell.titleLabel.text = data[@"categoryname"];
    }
   
    __block BOOL isSelected = NO;
    NSArray *sectionSelectedData = [self.selectedDataSoucre objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
    if (sectionSelectedData && [sectionSelectedData isKindOfClass:[NSArray class]]) {
        [sectionSelectedData enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                isSelected = YES;
                *stop = YES;
            }
        }];
    }
    cell.checkoutImageView.hidden = !isSelected;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    [self cellActionWithSection:indexPath.section row:indexPath.row];
    [self.tableView reloadData];
}

- (void)cellActionWithSection:(NSInteger)section row:(NSInteger)row
{
    int count = [self countOfSelectedDataCountWithData:self.selectedDataSoucre];
    NSArray *sectionSelectedData = [self.selectedDataSoucre objectForKey:[NSString stringWithFormat:@"%ld",(long)section]];
    NSMutableArray *tmpData = [NSMutableArray arrayWithArray:sectionSelectedData];
    
    if (self.maxSelectedCount > 1) {

        __block BOOL isSelected = NO;
        if (sectionSelectedData && [sectionSelectedData isKindOfClass:[NSArray class]]) {
            [sectionSelectedData enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:[NSString stringWithFormat:@"%ld", (long)row]]) {
                    isSelected = YES;
                    *stop = YES;
                }
            }];
        }
        if (isSelected) {
            [tmpData removeObject:[NSString stringWithFormat:@"%ld", (long)row]];
        } else
        {
            if (count >= self.maxSelectedCount) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"最多可选择%d个职能", count] ToView:nil];
                return;
            }
            
            [tmpData addObject:[NSString stringWithFormat:@"%ld", (long)row]];
        }
    } else
    {
        [tmpData removeAllObjects];
        [self.selectedDataSoucre removeAllObjects];
        [tmpData addObject:[NSString stringWithFormat:@"%ld", (long)row]];
    }
    
    [self.selectedDataSoucre setObject:tmpData forKey:[NSString stringWithFormat:@"%ld", (long)section]];
    count = [self countOfSelectedDataCountWithData:self.selectedDataSoucre];
    [self resetHeaderViewWithCurrentCount:count];
}

- (void)resetHeaderViewWithCurrentCount:(int)count
{
    NSMutableAttributedString *attributedHeaderViewCountLabelText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d/%lu", count, (unsigned long)self.maxSelectedCount] attributes:@{NSForegroundColorAttributeName:DARKTEXTCOLOR, NSFontAttributeName:self.selectedCountLabel.font}];
    [attributedHeaderViewCountLabelText addAttribute:NSForegroundColorAttributeName value:CUSTOMREDCOLOR range:NSMakeRange(0, 1)];
    [self addSelectedPositionBtnInView:self.selectedJobPositionBackgroundView withData:self.selectedDataSoucre];
    self.selectedCountLabel.attributedText= attributedHeaderViewCountLabelText;

}

- (void)addSelectedPositionBtnInView:(UIView *)view withData:(NSDictionary *)data
{
    [self.selectedJobPositionBackgroundView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    CGFloat leftInset = 20;
    CGFloat rightInset = 20;
    CGFloat topInset = 8;
    CGFloat itemSpace = 15;
    CGFloat itemHeight = 22;
    NSInteger itemCountOfRow = 3;
    CGFloat itemWidth = (view.frame.size.width - leftInset - rightInset - (itemCountOfRow- 1) * itemSpace) / 3;
    
    __block int count = 0;
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        [data enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull section, NSArray * _Nonnull sectionData, BOOL * _Nonnull stop) {
            
            if (sectionData && [sectionData isKindOfClass:[NSArray class]]) {
                [sectionData enumerateObjectsUsingBlock:^(NSString *  _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                   UIButton *positionBtn = [self createSelectedPositionBtnWithTitle:self.tableViewDataSource[section][[row integerValue]][@"categoryname"]];
                    positionBtn.frame = CGRectMake(leftInset + count *(itemSpace + itemWidth), topInset, itemWidth, itemHeight);
                    positionBtn.layer.cornerRadius = itemHeight / 2;
                    [self.selectedJobPositionBackgroundView addSubview:positionBtn];
                    count += 1;
                }];
            }
        }];
    }

}

- (UIButton *)createSelectedPositionBtnWithTitle:(NSString *)title
{
    UIButton *positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [positionBtn setTitle:title forState:UIControlStateNormal];
    [positionBtn setTitleColor:DARKTEXTCOLOR forState:UIControlStateNormal];
    positionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    positionBtn.backgroundColor = [UIColor whiteColor];
    positionBtn.clipsToBounds = YES;
    positionBtn.layer.borderColor = DARKLINECOLOR.CGColor;
    positionBtn.layer.borderWidth = 0.5;
    return positionBtn;
}

- (int)countOfSelectedDataCountWithData:(NSDictionary *)data
{
    __block int count = 0;
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray * _Nonnull sectionData, BOOL * _Nonnull stop) {
            if (sectionData && [sectionData isKindOfClass:[NSArray class]]) {
                [sectionData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj && [obj isKindOfClass:[NSString class]]) {
                        count += 1;
                    }
                }];
            }
        }];
    }
    return count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
