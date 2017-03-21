//
//  JobPositionSearchViewController.m
//  dww
//
//  Created by Shadow. G on 2016/12/29.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "JobPositionSearchViewController.h"
#import "ChooseIndustryViewController.h"
#import "ChooseJobPositionViewController.h"
#import "UIButton+EdgeInsets.h"
#import "SWPopView.h"

@interface JobPositionSearchViewController ()<PYSearchViewControllerDelegate, SWPopViewDelegate>

@property (nonatomic, strong) UIButton *chooseSearchTypeButton;
@property (nonatomic, strong) NSArray *selectedJobPositionData;
@property (strong, nonatomic) IBOutlet UILabel *jobPositionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *industryNameLabel;
@property (strong, nonatomic) UIView *titleView;
@property (nonatomic, strong) SWPopView *popView;

@end

@implementation JobPositionSearchViewController

+ (JobPositionSearchViewController *)searchViewControllerWithHotSearches:(NSArray<NSString *> *)hotSearches searchBarPlaceholder:(NSString *)placeholder didSearchBlock:(PYDidSearchBlock)block
{
    JobPositionSearchViewController *searchVC =[[JobPositionSearchViewController alloc] init];
    searchVC.hotSearches = hotSearches;
    searchVC.searchBar.placeholder = placeholder;
    searchVC.didSearchBlock = [block copy];
    
    return searchVC;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchType = kSearchTypeAllwords;
   
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.jobPositionNameLabel.text = [NSValueToString(self.jobPositionName) length] > 0 ? NSValueToString(self.jobPositionName) : @"请选择";
    self.industryNameLabel.text = [NSValueToString(self.jobIndustryName) length] > 0 ? NSValueToString(self.jobIndustryName) : @"请选择";
    self.navigationItem.titleView = self.titleView;
    for (UIView *subView in [[self.searchBar.subviews lastObject] subviews]) {
        if ([[subView class] isSubclassOfClass:[UITextField class]]) { // 是UItextField
            UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
            rightImageView.image = [UIImage imageNamed:@"search_white"];
            UITextField *textField = ((UITextField *)subView);
            textField.font = [UIFont systemFontOfSize:13];
            textField.textColor = [UIColor whiteColor];
            textField.borderStyle = UITextBorderStyleNone;
            textField.rightView = rightImageView;
            textField.leftViewMode = UITextFieldViewModeNever;

            textField.rightViewMode = UITextFieldViewModeUnlessEditing;
            
            break;
        }
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)]];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 40, 40);
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelInteraction) forControlEvents:UIControlEventTouchUpInside];
    [self setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:cancelButton]];
}

- (void)cancelInteraction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view endEditing:YES];
    [self.view bringSubviewToFront:self.chooseIndustryView];
    [self.view bringSubviewToFront:self.chooseJobPositionView];
    [self.view bringSubviewToFront:self.commitButton];
   
}



- (IBAction)tapAction:(id)sender {
    [self.searchBar resignFirstResponder];
}


#pragma mark --- SWPopViewDelegate

- (void)selectIndexPathRow:(NSInteger)index
{
    NSString * plachStr = nil;
    switch (index) {
        case 0:
        {
            plachStr = @"请输入职位/公司";
            self.searchType = kSearchTypeAllwords;
            [_chooseSearchTypeButton setTitle:@"全文" forState:UIControlStateNormal];
            [_chooseSearchTypeButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
        }
            break;
        case 1:
        {
            plachStr = @"请输入职位名称";
            self.searchType = kSearchTypePosition;
            [_chooseSearchTypeButton setTitle:@"职位" forState:UIControlStateNormal];
            [_chooseSearchTypeButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
        }
            break;
        case 2:
        {
            plachStr = @"请输入公司名称";
            self.searchType = kSearchTypeCompany;
            [_chooseSearchTypeButton setTitle:@"公司" forState:UIControlStateNormal];
            [_chooseSearchTypeButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
        }
            break;

        default:
            break;
    }
    self.searchBar.placeholder = plachStr;
    [self.popView dismiss];
}


#pragma mark --- button action


- (void)clickChooseSearchTypeButtonAction
{
        CGPoint point = CGPointMake(CGRectGetMidX(self.chooseSearchTypeButton.frame) + 80, self.chooseSearchTypeButton.frame.origin.y + 64);
        _popView = [[SWPopView alloc] initWithOrigin:point width:80 height:40 * 3 backgroundColor:[UIColor blackColor] borderColor:[UIColor blackColor]];
    
        _popView.dataArray = @[@"全文",@"职位",@"公司"];
        _popView.fontSize = 13;
        _popView.row_height = 40;
        _popView.titleTextColor = [UIColor whiteColor];
        _popView.delegate = self;
        
        [_popView popView];
}

- (IBAction)clickCommitButtonAction:(id)sender {
    
    if ([NSValueToString(self.industryID) length] <= 0) {
        [MBProgressHUD showError:@"请选择行业类别" ToView:nil];
        return;
    }
    if ([NSValueToString(self.jobPositionIDs) length] <= 0) {
        [MBProgressHUD showError:@"请选择职位类别" ToView:nil];
        return;
    }
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithCapacity:1];
    if ([NSValueToString(self.industryID) length] > 0) {
        [tmpDic setObject:NSValueToString(self.industryID) forKey:@"topclass"];
    }
    if ([NSValueToString(self.jobPositionIDs) length] > 0) {
         [tmpDic setObject:NSValueToString(self.jobPositionIDs) forKey:@"subclass"];
    }
    if ([NSValueToString(self.jobFirstPositionIDs) length] > 0) {
        [tmpDic setObject:NSValueToString(self.jobFirstPositionIDs) forKey:@"category"];
    }
   
    if (self.completeBlock) {
        self.completeBlock(tmpDic, self.industryID, self.jobFirstPositionIDs, self.jobPositionIDs, self.industryNameLabel.text, self.jobPositionNameLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickChooseIndustryCityButtonAction:(id)sender {
    
    ChooseIndustryViewController *chooseIndustryVC = [[ChooseIndustryViewController alloc] init];
    chooseIndustryVC.industryID = self.industryID;
    chooseIndustryVC.completeChooseBlock = ^(NSString *industryName, NSString *industryID)
    {
        self.industryNameLabel.text = industryName;
        self.jobIndustryName = industryName;
        self.industryID = industryID;
        self.jobFirstPositionIDs = @"";
        self.jobPositionIDs = @"";
        self.jobPositionNameLabel.text = @"请选择";
        self.jobPositionName = self.jobPositionNameLabel.text;
        [self.exparams setObject:NSValueToString(self.industryID) forKey:@"topclass"];
    };
    [self.navigationController pushViewController:chooseIndustryVC animated:YES];
    
}
- (IBAction)clickChooseJobPositionButtonAction:(id)sender {
    
    if ([NSValueToString(self.industryID) length] == 0) {
        [MBProgressHUD showError:@"请先选择行业" ToView:nil];
        return;
    }
    ChooseJobPositionViewController *chooseJobPositionVC = [[ChooseJobPositionViewController alloc] init];
    chooseJobPositionVC.industryID = self.industryID;
    chooseJobPositionVC.firstJobPositionIDs = self.jobFirstPositionIDs;
    chooseJobPositionVC.secondJobPositionIDs = self.jobPositionIDs;
    chooseJobPositionVC.maxSelectedCount = 3;
    chooseJobPositionVC.completeChoosePositionBlock = ^(NSArray *selectedPositionData){
        self.selectedJobPositionData = selectedPositionData;
        self.jobPositionIDs = @"";
        self.jobFirstPositionIDs = @"";
        self.jobPositionNameLabel.text = @"请选择";
        [selectedPositionData enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull data, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.jobPositionIDs.length == 0) {
                self.jobPositionIDs = [NSString stringWithFormat:@"%@", data[@"id"]];
                self.jobPositionNameLabel.text = [NSString stringWithFormat:@"%@", data[@"categoryname"]];
                self.jobFirstPositionIDs = [NSString stringWithFormat:@"%@", data[@"parentid"]];
            } else
            {
                self.jobPositionIDs = [NSString stringWithFormat:@"%@,%@", self.jobPositionIDs, data[@"id"]];
                self.jobPositionNameLabel.text = [NSString stringWithFormat:@"%@,%@", self.jobPositionNameLabel.text, data[@"categoryname"]];
                if (![self.jobFirstPositionIDs containsString:NSValueToString(data[@"parentid"])]) {
                     self.jobFirstPositionIDs = [NSString stringWithFormat:@"%@,%@", self.jobFirstPositionIDs, data[@"parentid"]];
                }
               
            }
        }];
        self.jobPositionName = self.jobPositionNameLabel.text;
        [self.exparams setObject:NSValueToString(self.jobPositionIDs) forKey:@"category"];
    };
    
    [self.navigationController pushViewController:chooseJobPositionVC animated:YES];
}


#pragma mark --- getter

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth *0.7, 30)];
        _titleView.backgroundColor = [UIColor colorWithHexString:@"0x52217A"];
        _titleView.layer.cornerRadius = self.searchBar.frame.size.height / 2;
        _titleView.clipsToBounds = YES;

        [_titleView addSubview:self.chooseSearchTypeButton];
        UIView *searchBarView = [[UIView alloc] initWithFrame:self.searchBar.bounds];
        [searchBarView addSubview:self.searchBar];
        [_titleView addSubview:searchBarView];
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.bottom.mas_equalTo(-2);
            make.left.right.mas_equalTo(0);
        }];
        [self.chooseSearchTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(60);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(searchBarView.mas_left).offset(0).priority(1000);
        }];
        [searchBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    return _titleView;
}

- (NSMutableDictionary *)exparams
{
    if (!_exparams) {
        _exparams = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _exparams;
}
- (UIButton *)chooseSearchTypeButton
{
    if (!_chooseSearchTypeButton) {
        _chooseSearchTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseSearchTypeButton.frame = CGRectMake(0, 0, 60, 40);
        [_chooseSearchTypeButton setTitle:@"全文" forState:UIControlStateNormal];
  
        [_chooseSearchTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chooseSearchTypeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_chooseSearchTypeButton setImage:[UIImage imageNamed:@"arrow_below_white"] forState:UIControlStateNormal];
        [_chooseSearchTypeButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
        [_chooseSearchTypeButton addTarget:self action:@selector(clickChooseSearchTypeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _chooseSearchTypeButton;
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
