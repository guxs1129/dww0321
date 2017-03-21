//
//  CreateRecruitmentBaseInfoViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/4.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CreateRecruitmentBaseInfoViewController.h"
#import "CreateRecruitmentEducationInfoViewController.h"
#import "UIViewController+KeyBoardManager.h"
#import "RecruitmentInfoTableViewCell.h"
#import "SWDatePickerAppearance.h"
#import "SWMutableDataPicker.h"
#import "JobPositionChooseCityViewController.h"
#import "HaoConnect.h"
#import "HaoQiNiu.h"

@interface CreateRecruitmentBaseInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) NSMutableArray<RecruitmentInfoCellModel *> *tableViewDataSource;

@property (strong, nonatomic) SWMutableDataPicker *mutableDataPicker;
@property (strong, nonatomic) NSArray *jobExperienceDataSource;

// req_str
@property (strong, nonatomic) NSString *req_avatar;
@property (strong, nonatomic) NSString *req_name; // 1-男，2-女，3-未知
@property (strong, nonatomic) NSString *req_sex;
@property (strong, nonatomic) NSString *req_birthday; // 如2016年11月
@property (strong, nonatomic) NSString *req_district; // 一级地区id
@property (strong, nonatomic) NSString *req_districtName;
@property (strong, nonatomic) NSString *req_sdistrict; // 二级地区id
@property (strong, nonatomic) NSString *req_sdistrictName;
@property (strong, nonatomic) NSString *req_jobExperienceID;
@property (strong, nonatomic) NSString *req_jobExperienceStr;
@property (strong, nonatomic) NSString *req_phoneNumber;
@property (strong, nonatomic) NSString *req_email;

@end

@implementation CreateRecruitmentBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基本信息";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.tableHeaderView = self.headerView;
    if (self.isEditing) {
        self.tableView.tableFooterView = [UIView new];
        self.tableView.tableHeaderView = [UIView new];
    }
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.rt_disableInteractivePop = YES;
    self.headerImageView.layer.cornerRadius = self.headerImageView.frame.size.height / 2;
    
    [self setupDataSource];
}


- (void)setupDataSource
{
    if (self.baseInfoData && [self.baseInfoData isKindOfClass:[NSDictionary class]] && self.baseInfoData.count > 0) {
        self.req_name = NSValueToString(self.baseInfoData[@"realname"]);
        self.req_sex = NSValueToString(self.baseInfoData[@"sex"]);
        self.req_birthday = NSValueToString(self.baseInfoData[@"birthday"]);
        self.req_jobExperienceID = NSValueToString(self.baseInfoData[@"experience"]);
        self.req_email = NSValueToString(self.baseInfoData[@"email"]);
        self.req_phoneNumber = NSValueToString(self.baseInfoData[@"phone"]);
        if (self.baseInfoData[@"districtLocal"] && [self.baseInfoData[@"districtLocal"] isKindOfClass:[NSDictionary class]]) {
            self.req_sdistrict = NSValueToString(self.baseInfoData[@"districtLocal"][@"secondAreaId"]);
        }
    }

    NSArray *titles = @[@{@"title":@"姓名",@"requestKey":@"realname"},
                        @{@"title":@"性别",@"requestKey":@"sex"},
                        @{@"title":@"生日",@"requestKey":@"birthday"},
                        @{@"title":@"所在城市",@"requestKey":@"districtCn"},
                        @{@"title":@"工作经验",@"requestKey":@"experienceCn"},
                        @{@"title":@"手机",@"requestKey":@"phone"},
                        @{@"title":@"邮箱",@"requestKey":@"email"}];
    [titles enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RecruitmentInfoCellModel *model = [[RecruitmentInfoCellModel alloc] init];
        model.title = obj[@"title"];
        if (self.baseInfoData && [self.baseInfoData isKindOfClass:[NSDictionary class]]) {
            model.value = NSValueToString(self.baseInfoData[obj[@"requestKey"]]);
        }
        model.required = YES;
        if (idx == 0 || idx == 5 || idx == 6) {
            model.cellType = RecruitmentInfoCellTypeTextField;
        } else if(idx == 1)
        {
            model.cellType = RecruitmentInfoCellTypeSingleChoose;
            model.singleChooseLeftButtonTitle = @"男";
            model.singleChooseRightButtonTitle = @"女";
        } else
        {
            model.cellType = RecruitmentInfoCellTypeShowRightChooseView;
        }
        
        
        [self.tableViewDataSource addObject:model];
    }];
}


#pragma mark --- navigationBar appearance

- (UIButton *)set_leftButton
{
    UIButton *resignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resignBtn.frame = CGRectMake(0, 0, 40, 40);
    resignBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
    if (self.isEditing) {
        [resignBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    } else
    {
        [resignBtn setTitle:@"放弃" forState:UIControlStateNormal];
    }

    resignBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [resignBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return resignBtn;
}

- (void)left_button_event:(UIButton *)sender
{

    if (self.isEditing) {
        [self.navigationController popViewControllerAnimated:YES];
    } else
    {
        [SWAlertView showAlertWithTitle:@"" message:@"您确定退出简历编辑吗?退出编辑, 可在简历页完善简历" completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
            
            if (buttonIndex != alertView.cancelButtonIndex) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    }
}

- (UIButton *)set_rightButton
{
    UIButton *stepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (self.isEditing) {
       [stepBtn setTitle:@"保存" forState:UIControlStateNormal];
    } else
    {
        [stepBtn setTitle:@"1/5" forState:UIControlStateNormal];
    }
    [stepBtn sizeToFit];
    stepBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [stepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return stepBtn;
}

- (void)right_button_event:(UIButton *)sender
{
    if ([NSValueToString(self.resumeID) length] > 0) {
       [self requestUpdateOrAddBaseInfoWithSuccessBlock:^(NSDictionary *result) {
           [MBProgressHUD showSuccess:@"保存成功" ToView:nil];
           [self.navigationController popViewControllerAnimated:YES];
       }];
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecruitmentInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecruitmentInfoTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row + 1 == self.tableViewDataSource.count) {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0XD6D6D6"];
    } else
    {
        cell.lineView.backgroundColor = [UIColor colorWithHexString:@"0XF0F0F0"];
    }
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    cell.contentTextField.tag = indexPath.row;
    cell.contentTextField.delegate = self;
    
    cell.didClickRightChooseButtonBlock = nil;
    cell.didClickLeftChooseButtonBlock = nil;
    cell.didClickSingleLeftChooseButtonBlock = nil;
    cell.didClickSingleRightChooseButtonBlock = nil;
    if ([model.title isEqualToString:@"生日"]) {
        cell.didClickRightChooseButtonBlock = ^
        {
            NSString *formatStr = @"yyyy年MM月";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            NSDate * currentData = [NSDate date];
            if (_isEditing) {
                currentData = [dateFormatter dateFromString:self.req_birthday];
            }
            formatStr = @"yyyy-MM";
            [dateFormatter setDateFormat:formatStr];
            SWDatePickerAppearance *picker = [[SWDatePickerAppearance alloc]initWithDatePickerMode:DatePickerYearMonthMode currentDate:currentData minDate:[dateFormatter dateFromString:@"1970-01"] maxDate:[NSDate date]  completeBlock:^(NSDate *date) {
                NSString *formatStr = @"yyyy年MM月";
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:formatStr];
                NSLog(@"%@",[dateFormatter stringFromDate:date]);
                self.req_birthday = [dateFormatter stringFromDate:date];
                RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
                model.value = self.req_birthday;
                [self.tableView reloadData];
            }];
            [picker show];
        };
    } else if ([model.title isEqualToString:@"所在城市"])
    {
        cell.didClickRightChooseButtonBlock = ^{
            JobPositionChooseCityViewController *chooseCityVC = [[JobPositionChooseCityViewController alloc] init];
            chooseCityVC.isorNotShowQuanGuo = YES;
            [chooseCityVC setCompleteChooseCityBlock:^(NSString *cityName, NSString *cityID) {
                RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
                model.value = cityName;
                self.req_sdistrict = cityID;
                [self.tableView reloadData];
            }];
            chooseCityVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chooseCityVC animated:YES];
        };
        
    } else if ([model.title isEqualToString:@"工作经验"])
    {
        cell.didClickRightChooseButtonBlock = ^{
            
            if (self.jobExperienceDataSource && self.jobExperienceDataSource.count > 0) {
                [self jobExperienceCellActionWithIndexPath:indexPath dataSource:self.jobExperienceDataSource];
            } else
            {
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSMutableDictionary * exprame  = nil;
                
                [HaoConnect request:@"pub_category_group_d/GetDiscreteWorkExperiences" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if (result.isResultsOK) {
                        self.jobExperienceDataSource = result.results;
                        [self jobExperienceCellActionWithIndexPath:indexPath dataSource:self.jobExperienceDataSource];
                    }
                    
                } onError:^(HaoResult *errorResult) {
                    
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }];
            }
            
        };
    } else if ([model.title isEqualToString:@"性别"])
    {
        cell.didClickSingleLeftChooseButtonBlock = ^
        {
            self.req_sex = @"1";
            model.value = @"1";
        };
        cell.didClickSingleRightChooseButtonBlock = ^
        {
            self.req_sex = @"2";
            model.value = @"2";
        };
    }
    
    if (model.cellType == RecruitmentInfoCellTypeSingleChoose) {
        if ([model.value isEqualToString:@"1"]) {
            cell.singleLeftChooseBtn.selected = YES;
            cell.singleRightChooseBtn.selected = NO;
        } else if ([model.value isEqualToString:@"2"])
        {
            cell.singleLeftChooseBtn.selected = NO;
            cell.singleRightChooseBtn.selected = YES;
        } else
        {
            cell.singleLeftChooseBtn.selected = NO;
            cell.singleRightChooseBtn.selected = NO;
        }
    }
    [cell setModel:model];
    return cell;
}


#pragma mark --- cell Action

- (void)jobExperienceCellActionWithIndexPath:(NSIndexPath *)indexPath dataSource:(NSArray *)dataSource
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[indexPath.row];
    self.mutableDataPicker.rowValueInFirstComponentKey = @"name";
    
    JiaCoreWeakSelf(self);
    self.mutableDataPicker.completion = ^(NSDictionary *rowDataInFirstComponent,NSDictionary *rowDataInSecondComponent,NSDictionary *rowDataInThirdComponent)
    {
        model.value = rowDataInFirstComponent[@"name"];
        weakself.req_jobExperienceID = rowDataInFirstComponent[@"id"];
        [weakself.tableView reloadData];
    };
    [self.mutableDataPicker showPickerWithDataSource:dataSource firstComponentSelectedValue:model.value secondComponentSelectedValue:nil thirdComponentSelectedValue:nil];
}

#pragma mark --- getter

- (NSMutableArray<RecruitmentInfoCellModel *> *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _tableViewDataSource;
}

- (NSArray *)jobExperienceDataSource
{
    if (!_jobExperienceDataSource) {
        _jobExperienceDataSource = [NSArray array];
    }
    return _jobExperienceDataSource;
}

- (SWMutableDataPicker *)mutableDataPicker
{
    if (!_mutableDataPicker) {
        
        _mutableDataPicker  = [[SWMutableDataPicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _mutableDataPicker;
}


#pragma mark --- button action

- (IBAction)clickHeaderViewAction:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    
    [actionSheet showInView:self.view];

    
}
- (IBAction)clickFooterViewAction:(id)sender {
    
   [self requestUpdateOrAddBaseInfoWithSuccessBlock:^(NSDictionary *result) {
       self.resumeID = NSValueToString(result[@"id"]);
       [self requestInfoWithRequest:@"job_resume_education/list" successBlock:^(NSArray *data) {
           CreateRecruitmentEducationInfoViewController *educationInfoVC = [[CreateRecruitmentEducationInfoViewController alloc] init];
           self.resumeID = NSValueToString(result[@"id"]);
           educationInfoVC.resumeID = NSValueToString(result[@"id"]);
           if (data && [data isKindOfClass:[NSArray class]] && data.count > 0) {
               educationInfoVC.educationInfoID = NSValueToString(data.firstObject[@"id"]);
               educationInfoVC.educationData = data.firstObject;
           }
           educationInfoVC.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:educationInfoVC animated:YES];
       }];
       
   }];

}


#pragma mark --- request

- (void)requestInfoWithRequest:(NSString *)requestStr successBlock:(void(^)(NSArray *data))completeBlcok
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               [DWUserDataManager standardUserDefaults].userID,@"uid",
               nil];
    if ([NSValueToString(self.resumeID) length] > 0) {
        [exprame setObject:NSValueToString(self.resumeID) forKey:@"resume_id"];
    }
    [HaoConnect request:requestStr params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
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

- (BOOL)reqBefore
{
    if (!validInfo(self.req_name) || !validInfo(self.req_sex) || !validInfo(self.req_birthday) || !validInfo(self.req_jobExperienceID) || !validInfo(self.req_email) || !validInfo(self.req_phoneNumber) || !validInfo(self.req_sdistrict)) {
        NSString * errorInfo = nil;
        if (!validInfo(self.req_name)) {
            errorInfo = @"请填写姓名";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_sex)) {
            errorInfo = @"请选择性别";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_birthday)) {
            errorInfo = @"请选择生日";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_sdistrict)) {
            errorInfo = @"请选择所在城市";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
            
        }

        if (!validInfo(self.req_jobExperienceID)) {
            errorInfo = @"请选择工作经验";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }
        if (!validInfo(self.req_phoneNumber) || [NSValueToString(self.req_phoneNumber) length] != 11) {
            errorInfo = @"请输入正确的手机号码";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
            
        }
        if (!validInfo(self.req_email)) {
            errorInfo = @"请填写邮箱";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
        }


        return NO;
    } else
    {
        if (!validInfo(self.req_phoneNumber) || [NSValueToString(self.req_phoneNumber) length] != 11) {
            
            NSString * errorInfo = @"请输入正确的手机号码";
            [MBProgressHUD showError:errorInfo ToView:nil];
            return NO;
            
        }
        return YES;
    }
}

- (void)requestUpdateOrAddBaseInfoWithSuccessBlock:(void(^)(NSDictionary *result))successBlock
{
    [self.view endEditing:YES];
    if ([self reqBefore] == NO) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               _req_name,@"realname",
               _req_sex,@"sex",
               _req_birthday,@"birthday",
               _req_jobExperienceID,@"experience",
               _req_email,@"email",
               _req_phoneNumber,@"phone",
               _req_sdistrict,@"sdistrict",
//               self.req_avatar,@"photo_img",
               nil];
    if ([NSValueToString(self.req_avatar) length] > 0) {
        [exprame setObject:NSValueToString(self.req_avatar) forKey:@"photo_img"];
    }
    NSString *request = @"job_resume/add";
    if ([NSValueToString(self.resumeID) length] > 0) {
        request = @"job_resume/update";
        [exprame setObject:NSValueToString(self.resumeID) forKey:@"id"];
    }
    [HaoConnect request:request params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if (successBlock) {
                successBlock(result.results);
            }
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}


#pragma mark --- textFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self setupForKeyboardWithScrolledView:self.tableView clickedView:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    RecruitmentInfoCellModel *model = self.tableViewDataSource[textField.tag];
    if ([model.title isEqualToString:@"姓名"]) {
        model.value = trimming(textField.text);
        self.req_name = trimming(textField.text);
    } else if ([model.title isEqualToString:@"手机"])
    {
        model.value = trimming(textField.text);
        self.req_phoneNumber = trimming(textField.text);
    } else if ([model.title isEqualToString:@"邮箱"])
    {
        model.value = trimming(textField.text);
        self.req_email = trimming(textField.text);
    }
    
    [self uploadKeyBoardManager];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = %d", (int)buttonIndex);
    
    
    switch (buttonIndex) {
            
        case 0:
        {
            [self takePhoto];
        }
            break;
        case 1:
        {
            [self localPhoto];
        }
            break;
        default:
            break;
    }
}

- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
}


- (void)localPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        self.headerImageView.image = image;
        NSData *data = UIImageJPEGRepresentation([Tool imageWithImage:image scaledToSize:CGSizeMake(image.size.width/2, image.size.height/2)], 1.0);
        
//        [HaoQiNiu requestUpLoadQiNiu:data onCompletion:^(NSString *urlPreview) {
//            if (urlPreview) {
//                self.req_avatar = [urlPreview mutableCopy];
//                self.headerImageView.image = [UIImage imageNamed:urlPreview];
//            }
//            
//            [self.tableView reloadData];
//            NSLog(@"真正页面的UI：%@",urlPreview);
//        } onError:^(NSError *error) {
//            
//        } progress:^(double progress) {
//            if (progress >= 1) {
//                //                [self requestzteInfoKey:@"head_img" value:picUrl];
//            }
//        }];
        MKNetworkOperation * op = [HaoQiNiu uploadImage:[NSString stringWithFormat:@"%@job/third/ueditor/php/controller.php?action=uploadimage", [HaoConfig getHtmlHost]] params:@{@"path_name_of_config":@"resume_photo_dir"}.mutableCopy imageDatas:data Method:METHOD_POST onCompletion:^(NSData *responseData) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic);
            self.req_avatar = [NSValueToString(dic[@"url"]) mutableCopy];
//            [Tool imageView:self.headerImageView configImageWithUrl:NSValueToString(dic[@"url"]) placeholderImageName:@""];
            
        }onError:^(NSError *error) {
            
        }];
        [op onUploadProgressChanged:^(double progress) {
            NSLog(@"真正上传的：%f",progress);
            
        }];

                       

        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
