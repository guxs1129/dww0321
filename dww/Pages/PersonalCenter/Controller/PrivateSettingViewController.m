//
//  PrivateSettingViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/8.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "PrivateSettingViewController.h"
#import "PrivateSettingTableViewCell.h"

#define kDefaultAddTitle @"请添加企业名称"
@interface PrivateSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) NSMutableArray *tableViewDataSource;
@property (strong, nonatomic) IBOutlet UIButton *privateButton;
@property (strong, nonatomic) IBOutlet UIButton *openButton;
@property (strong, nonatomic) NSString *resumeID;

@end

@implementation PrivateSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"隐私设置";
    
    self.rt_disableInteractivePop = YES;
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"PrivateSettingTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PrivateSettingTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.display = @"1";
    self.openButton.selected = YES;
    self.privateButton.selected = NO;
    
    [self requestRecruitmentInfoWithsuccessBlock:^(NSArray *data) {
        if (data && [data isKindOfClass:[NSArray class]] && data.count > 0) {
            NSDictionary *infoData = data.firstObject;
            self.resumeID = NSValueToString(infoData[@"id"]);
            self.display = NSValueToString(infoData[@"display"]);
            if ([NSValueToString(infoData[@"display"]) boolValue]) {
                self.openButton.selected = YES;
                self.privateButton.selected = NO;
            } else
            {
                self.openButton.selected = NO;
                self.privateButton.selected = YES;
            }

        } else
        {
            [SWAlertView showAlertWithTitle:@"请先创建简历" message:@"" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
                
                [[DWTabBarControllerConfig sharedInstance].tabBarController setSelectedIndex:2];
                 [self.navigationController popToRootViewControllerAnimated:YES];
                
            } cancelButtonTitle:@"立即创建" otherButtonTitles:nil];
        }
    }];
    
    
}


#pragma mark --- request

- (void)requestRecruitmentInfoWithsuccessBlock:(void(^)(NSArray *data))completeBlcok
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               [DWUserDataManager standardUserDefaults].userID,@"uid",
               nil];
    [HaoConnect request:@"job_resume/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (completeBlcok) {
                completeBlcok(result.results);
            }
            
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

//- (void)requestRecruitmentInfo
//{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSMutableDictionary * exprame  = nil;
//
//    [HaoConnect request:@"job_resume/my_resume" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        if (result.isResultsOK) {
//            
//            self.resumeID = NSValueToString(result.results[@"id"]);
//            self.display = NSValueToString(result.results[@"display"]);
//            if ([NSValueToString(result.results[@"display"]) boolValue]) {
//                self.openButton.selected = YES;
//                self.privateButton.selected = NO;
//            } else
//            {
//                self.openButton.selected = NO;
//                self.privateButton.selected = YES;
//            }
//        }
//        
//    } onError:^(HaoResult *errorResult) {
//        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    }];
//
//}

- (void)requestResumeMaskCompanyList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               [DWUserDataManager standardUserDefaults].userID,@"uid",
               nil];
    [HaoConnect request:@"job_resume_mask/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            self.tableViewDataSource = [result.results mutableCopy];
            [self.tableViewDataSource addObject:@{@"companymaskStr":kDefaultAddTitle}];
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}



- (void)requestJobResumeMaskAddWithCompanyName:(NSString *)companyName completeBlock:(void(^)(NSDictionary *data))completeBlock
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(companyName),@"companymask_str",
               nil];
    [HaoConnect request:@"job_resume_mask/add" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (completeBlock) {
                completeBlock(result.results);
            }
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (void)requestJobResumeMaskDeleteWithID:(NSString *)resumeMaskID completeBlock:(void(^)())completeBlock
{
  
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(resumeMaskID),@"id",
               nil];
    [HaoConnect request:@"job_resume_mask/delete" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            if (completeBlock) {
                completeBlock();
            }
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark --- navigationBar appearance

- (UIButton *)set_leftButton
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return backBtn;
}

- (void)left_button_event:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveInfoActionWithCompleteBlock:(void(^)())completeBlock
{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.resumeID),@"id",
               NSValueToString(self.display),@"display",
               
               nil];
    
    [HaoConnect request:@"job_resume/update" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if (completeBlock) {
                completeBlock();
            }else{
                [MBProgressHUD showSuccess:@"设置成功" ToView:nil];
            }
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}


- (void)savePrivateSetting
{
    if ([NSValueToString(self.resumeID) length] < 1) {
        [SWAlertView showAlertWithTitle:@"请先创建简历" message:@"" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
            if (buttonIndex != alertView.cancelButtonIndex) {
                [[DWTabBarControllerConfig sharedInstance].tabBarController setSelectedIndex:2];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } cancelButtonTitle:@"取消" otherButtonTitles:@"立即创建", nil];
    } else
    {
        [self saveInfoActionWithCompleteBlock:nil];
    }
}

#pragma mark --- button action

- (IBAction)clickPrivateButtonAction:(id)sender {
    
    self.privateButton.selected = YES;
    self.openButton.selected = NO;
    self.display = @"0";
    [self savePrivateSetting];
}
- (IBAction)clickOpenButtonAction:(id)sender {
    
    self.openButton.selected = YES;
    self.privateButton.selected = NO;
    self.display = @"1";
    [self savePrivateSetting];

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
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivateSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PrivateSettingTableViewCell class])];
//    cell.titleTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:kDefaultAddTitle attributes:@{NSForegroundColorAttributeName : CUSTOMORANGECOLOR}];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self.tableViewDataSource[indexPath.row][@"companymaskStr"] isEqualToString:kDefaultAddTitle]) {
        
        cell.titleTextField.text = @"";
        
        cell.titleTextField.userInteractionEnabled = YES;
        [cell.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [cell.rightButton setTitle:@"+" forState:UIControlStateNormal];
        
        __weak typeof(cell)weakCell = cell;
        cell.didClickRightButtonBlock = ^{
            __strong typeof(weakCell)strongCell = weakCell;
            if ([self isFailedWithCell:strongCell] == NO) {
                if (self.tableViewDataSource.count > 10) {
                    [MBProgressHUD showError:@"最多可添加10个企业" ToView: nil];
                    return;
                }
                [self requestJobResumeMaskAddWithCompanyName:strongCell.titleTextField.text completeBlock:^(NSDictionary *data){
                    [self.tableViewDataSource insertObject:data atIndex:0];
                    [self.tableView reloadData];
                }];
                
            } else
            {
                [MBProgressHUD showError:@"请输入企业名称" ToView:nil];
            }
        };
        
    } else
    {
        cell.titleTextField.text = self.tableViewDataSource[indexPath.row][@"companymaskStr"];
        cell.titleTextField.userInteractionEnabled = NO;
        [cell.rightButton setImage:[[UIImage imageNamed:@"privateSetting_delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [cell.rightButton setTitle:@"" forState:UIControlStateNormal];
        cell.didClickRightButtonBlock = ^{
            
            [SWAlertView showAlertWithTitle:@"" message:@"确认删除?" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
                if (buttonIndex != alertView.cancelButtonIndex) {
                    [self requestJobResumeMaskDeleteWithID:NSValueToString(self.tableViewDataSource[indexPath.row][@"id"]) completeBlock:^{
                        [self.tableViewDataSource removeObjectAtIndex:indexPath.row];
                        [self.tableView  reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }];
                }
            } cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            
            
        };
    }
  
    return cell;
}


- (BOOL)isFailedWithCell:(PrivateSettingTableViewCell *)cell
{
    if (cell.titleTextField.text.length > 0) {
        return NO;
    } else
    {
        return YES;
    }
    
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
