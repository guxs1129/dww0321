//
//  CompanyDetailViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/15.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "CompanyDetailViewController.h"
#import "SendRecruitmentSuccessViewController.h"
#import "JobPositionDetailViewController.h"
#import "CompanyHotPositionTableViewCell.h"
#import "HXMapViewController.h"
#import "UIWebView+ChangeBaseStringAttributes.h"

@interface CompanyDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
{

    CGFloat fitHeight;
}
@property (strong, nonatomic) IBOutlet UIWebView *contentWebView;
@property (strong, nonatomic) IBOutlet UIButton *arrowButton;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *companyCategoryLabel;
@property (strong, nonatomic) IBOutlet UIImageView *companyAvatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *companyAddressButton;
@property (strong, nonatomic) IBOutlet UILabel *companyNatureAndScaleLabel;
@property (assign, nonatomic) CGFloat defaultWebViewHeight;

@end

@implementation CompanyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"企业主页";
    self.contentWebView.opaque = NO;
    self.contentWebView.backgroundColor = [UIColor clearColor];
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyHotPositionTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CompanyHotPositionTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableHeaderView = self.headerView;
    self.defaultWebViewHeight = 74;
    [self requestCompanyDetailData];
}


#pragma mark --- request

- (void)requestCompanyDetailData
{
    if ([NSValueToString(self.companyID) length] < 1) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.companyID),@"id",
               nil];
    [HaoConnect request:@"pub_company/detail" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [self configCompanyViewWithData:result.results];
        }
        
    } onError:^(HaoResult *errorResult) {
        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestCompanyDetailData];
        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)configCompanyViewWithData:(NSDictionary *)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.companyNameLabel.text = NSValueToString(data[@"companyname"]);
        self.companyCategoryLabel.text = NSValueToString(data[@"companyname"]);
        self.companyNatureAndScaleLabel.text = NSValueToString(data[@"companyTypeCn"]);
        [Tool imageView:self.companyAvatarImageView configImageWithUrl:NSValueToString(data[@"companylogoLocal"]) placeholderImageName:@""];
        if ([NSValueToString(data[@"introduction"]) length] > 0) {
            self.arrowButton.hidden = NO;
        } else
        {
            self.arrowButton.hidden = YES;
        }
        [self.contentWebView loadHTMLString:[self.contentWebView changeBaseStringAttributesWithHtmlString:NSValueToString(data[@"introduction"]) fontSize:13 textColorStr:@"#666666"] baseURL:nil];
        self.contentWebView.scrollView.scrollEnabled = NO;
        [self requestCompanyExtraInfoData];
    }
}

- (void)requestCompanyExtraInfoData
{
    if ([NSValueToString(self.companyID) length] < 1) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.companyID),@"id",
               nil];
    [HaoConnect request:@"pub_company_prof_job/detail" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [self configCompanyViewWithExtraData:result.results];
            [self requestHotPositionListData];
        }
        
    } onError:^(HaoResult *errorResult) {
        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestCompanyDetailData];
        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)requestHotPositionListData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"302",@"position_status",
               NSValueToString(self.companyID),@"company_id",
               nil];
 
    [HaoConnect request:@"job_position/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            self.dataSource = [result.results mutableCopy];
            [self.tableView reloadData];
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)configCompanyViewWithExtraData:(NSDictionary *)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.companyCategoryLabel.text = NSValueToString(data[@"tradeCn"]);
        if (self.companyNatureAndScaleLabel.text.length > 0) {
            self.companyNatureAndScaleLabel.text = [NSString stringWithFormat:@"%@ | %@", self.companyNatureAndScaleLabel.text, NSValueToString(data[@"scaleCn"])];
        } else
        {
            self.companyNatureAndScaleLabel.text = [NSString stringWithFormat:@"%@", NSValueToString(data[@"scaleCn"])];
        }
        
        [self.companyAddressButton setTitle:[NSString stringWithFormat:@"工作地址 : %@", NSValueToString(data[@"officeaddress"])] forState:UIControlStateNormal];
    }
}

- (void)sendRecruitmentActionWithSuccessBlock:(void(^)(NSDictionary *data))successBlock
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.jobPositionID),@"position_id",
               nil];
    [HaoConnect request:@"job_personal_position_apply/add" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if (successBlock) {
                successBlock(result.results);
            }
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}


#pragma mark --- button action
- (IBAction)clickCompanyAddressButtonAction:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:NSValueToString(self.companyAddressButton.titleLabel.text) completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        
        CLLocation *location = placemark.location;//位置
        //        CLRegion *region=placemark.region;//区域
        //        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        //        NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        HXMapViewController *mapVC = [[HXMapViewController alloc] initWithLocation:location.coordinate];
        mapVC.navigationItem.title = NSValueToString(self.companyAddressButton.titleLabel.text);
        mapVC.isApply = self.isApply;
        mapVC.jobPositionID = self.jobPositionID;
        mapVC.annotationTitle = NSValueToString(self.companyAddressButton.titleLabel.text);
        mapVC.didClickApplyButtonAction = ^(UIButton *applyButton)
        {
            [self sendRecruitmentActionWithSuccessBlock:^(NSDictionary *data){
                [self resetSendRecruitmentButtonState:applyButton withIsApply:YES];
         
                SendRecruitmentSuccessViewController *successVC = [[SendRecruitmentSuccessViewController alloc] init];
                [self.navigationController pushViewController:successVC animated:YES];
            }];
        };
        [self.navigationController pushViewController:mapVC animated:YES];
    }];

}

- (void)resetSendRecruitmentButtonState:(UIButton *)button withIsApply:(BOOL)isApply
{
    if (isApply) {
        
        button.userInteractionEnabled = NO;
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitle:@"简历已投递" forState:UIControlStateNormal];
    } else
    {
        button.userInteractionEnabled = YES;
        button.backgroundColor = CUSTOMORANGECOLOR;
        [button setTitle:@"投递简历" forState:UIControlStateNormal];
    }
    
}

- (IBAction)clickWebViewArrowButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        CGRect frame = self.headerView.frame;
        frame.size.height -= self.defaultWebViewHeight;
        frame.size.height += fitHeight;
        self.headerView.frame = frame;
        self.tableView.tableHeaderView = self.headerView;
        [self.view updateConstraints];
    } else
    {
        CGRect frame = self.headerView.frame;
        frame.size.height -= fitHeight;
        frame.size.height += self.defaultWebViewHeight;
        self.headerView.frame = frame;
        self.tableView.tableHeaderView = self.headerView;
        [self.view updateConstraints];

    }
}


#pragma mark --- webview delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    fitHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"] floatValue];

    if (fitHeight - _defaultWebViewHeight < 5) {
        self.arrowButton.hidden = YES;
    }else{
        self.arrowButton.hidden = NO;
    }

}


#pragma mark --- tableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 33)];
    
    UIView *titleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 33)];
    titleBackgroundView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenSizeWidth - 40, 33)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = MIDDLEDARKTEXTCOLOR;
    titleLabel.text = @"热招职位";
    [titleBackgroundView addSubview:titleLabel];
    
    // light line
    
    UIView *lightLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleBackgroundView.frame.size.height - 0.5, ScreenSizeWidth, 0.5)];
    lightLineView.backgroundColor = LIGHTLINECOLOR;
    [titleBackgroundView addSubview:lightLineView];
    [sectionView addSubview:titleBackgroundView];
    

    return sectionView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyHotPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CompanyHotPositionTableViewCell class])];
    
    [cell resetCellWithData:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobPositionDetailViewController *detailVC = [[JobPositionDetailViewController alloc] init];
    detailVC.jobPositionID = NSValueToString(self.dataSource[indexPath.row][@"id"]);
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark --- getter

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
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
