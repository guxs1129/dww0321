//
//  JobPositionDetailViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/11.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "JobPositionDetailViewController.h"
#import "CompanyDetailViewController.h"
#import "SendRecruitmentSuccessViewController.h"
#import "HXMapViewController.h"
#import "BaseWebView.h"
#import "UIWebView+ChangeBaseStringAttributes.h"
#import "UIViewController+Share.h"

@interface JobPositionDetailViewController ()<UIWebViewDelegate>

@property (nonatomic) BOOL isApply;
@property (strong, nonatomic) NSString *companyID;
@property (strong, nonatomic) UIButton *collecButton;
@property (strong, nonatomic) IBOutlet UIWebView *jobDescriptionWebView;

@property (strong, nonatomic) IBOutlet UILabel *jobPositionLabel;
@property (strong, nonatomic) IBOutlet UIButton *sendRecruitmentButton;
@property (strong, nonatomic) IBOutlet UILabel *wageLabel;
@property (strong, nonatomic) IBOutlet UIButton *cityButton;
@property (strong, nonatomic) IBOutlet UIButton *jobExperienceButton;
@property (strong, nonatomic) IBOutlet UIButton *educationInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *positonNatureButton;
@property (strong, nonatomic) IBOutlet UIImageView *companyAvatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyCategoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNatrueAndScaleLabel;
@property (strong, nonatomic) IBOutlet UIView *jobContentWebViewBackgroundView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *jobContentWebViewBackgroundViewHeight;
@property (strong, nonatomic) IBOutlet UIView *companyTagLabelsBackgroundView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *companyTagLabelsBackgroundViewHeight;

@property (strong, nonatomic) IBOutlet UIImageView *authenticationImageView;
@property (strong, nonatomic) IBOutlet UIButton *companyAddressButton;

@property (strong, nonatomic) NSString *shareTitle;

@property (strong, nonatomic) NSMutableArray *tagLabelsArray;

@end

@implementation JobPositionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"职位描述";
    self.jobDescriptionWebView.opaque = NO;
    self.jobDescriptionWebView.backgroundColor = [UIColor clearColor];
    self.wageLabel.adjustsFontSizeToFitWidth = YES;
    self.jobDescriptionWebView.delegate = self;
    [self addRightItems];
    [self requestJobPositonDetailData];
}

- (void)addRightItems
{
    UIButton *shareButton = [self createButtonWithImageName:@"jobPosition_share" selectedImageName:nil action:@selector(clickShareButtonAction:)];
    self.collecButton = [self createButtonWithImageName:@"jobPositon_collection_normal" selectedImageName:@"jobPositon_collection_selected" action:@selector(clickCollectionButtonAction:)];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.collecButton], [[UIBarButtonItem alloc] initWithCustomView:shareButton]];
}

- (void)clickShareButtonAction:(UIButton *)shareBtn
{
    [self snsSocialWithText:NSValueToString(self.jobPositionLabel.text) url:[NSString stringWithFormat:@"%@job/module/myjob/MyPositionDesc.html?id=%@", [HaoConfig getHtmlHost],NSValueToString(self.jobPositionID)] imageUrl:@""];
}

- (void)clickCollectionButtonAction:(UIButton *)collectionBtn
{
    if (collectionBtn.selected) {
        [self cancelCollection];
    } else
    {
        [self addCollection];
    }
}

- (void)cancelCollection
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:

               NSValueToString(self.jobPositionID),@"position_id",
               nil];
    [HaoConnect request:@"job_personal_position_op/cancel" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            self.collecButton.selected = NO;
            [MBProgressHUD showSuccess:@"取消收藏" ToView:nil];
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)addCollection
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.jobPositionID),@"position_id",
               @"2",@"sourcefrom",
               nil];
    [HaoConnect request:@"job_personal_position_op/add" params:exprame httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            self.collecButton.selected = YES;
            [MBProgressHUD showSuccess:@"收藏成功" ToView:nil];
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (UIButton *)createButtonWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 40);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectedImageName && [NSValueToString(selectedImageName) length] > 0) {
        [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CGFloat w = 0;//保存前一个label的宽以及前一个label距离屏幕边缘的距离
    CGFloat h = 0;//用来控制label距离父视图的高
    if (self.tagLabelsArray && self.tagLabelsArray.count > 0) {
        
        for (int i = 0; i < self.tagLabelsArray.count; i++) {
            
            UILabel *tagLabel = self.tagLabelsArray[i];
            
            CGFloat tagLabelHeight = 19;
            CGFloat tagLabelWidthSpace = 10;
            CGFloat tagLabelHeightSapce = 5;
            
            //根据计算文字的大小
            CGFloat length = 44;
//            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:9]};
//            CGFloat length = [tagLabel.text boundingRectWithSize:CGSizeMake(self.companyTagLabelsBackgroundView.frame.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //设置button的frame
            tagLabel.frame = CGRectMake(tagLabelWidthSpace + w, h, length + tagLabelWidthSpace / 2, tagLabelHeight);
            //当label的位置超出父视图边缘时换行
            if(tagLabelWidthSpace + w + length + tagLabelWidthSpace > self.companyTagLabelsBackgroundView.frame.size.width){
                w = 0; //换行时将w置为0
                h = h + tagLabel.frame.size.height + tagLabelHeightSapce;//距离父视图也变化
                tagLabel.frame = CGRectMake(tagLabelWidthSpace + w, h, length+ tagLabelWidthSpace / 2, tagLabelHeight);//重设label的frame
            }
            w = tagLabel.frame.size.width + tagLabel.frame.origin.x;
            self.companyTagLabelsBackgroundViewHeight.constant = CGRectGetMaxY(tagLabel.frame);
        }
    }

}


#pragma mark --- getter

- (NSMutableArray *)tagLabelsArray
{
    if (!_tagLabelsArray) {
        _tagLabelsArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _tagLabelsArray;
}


#pragma mark --- request

- (void)requestJobPositonDetailData
{
    if ([NSValueToString(self.jobPositionID) length] < 1) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.jobPositionID),@"id",
               @"1",@"show_relate_of_uid",
               nil];
    [HaoConnect request:@"job_position/detail" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
            [self configJobPostionInfoViewWithJobPositionData:result.results];
            [self requestJobPostionTagData];
        }
        
    } onError:^(HaoResult *errorResult) {
        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            [self requestJobPositonDetailData];
        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (void)requestJobPostionTagData
{
    if ([NSValueToString(self.jobPositionID) length] < 1) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               NSValueToString(self.jobPositionID),@"position_id",
               @"1",@"page",
               @"100",@"size",
               nil];
    [HaoConnect request:@"job_position_tag/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            if (result.results && [result.results isKindOfClass:[NSArray class]]) {
                [result.results enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    UILabel *label = [[UILabel alloc] init];
                    label.tag = 1000 + idx;
                    label.backgroundColor = [UIColor whiteColor];
                    label.textColor = LIGHTTEXTCOLOR;
                    label.layer.cornerRadius = 2;
                    label.layer.borderColor = LIGHTTEXTCOLOR.CGColor;
                    label.layer.borderWidth = 0.5;
                    label.font = [UIFont systemFontOfSize:9];
                    label.layer.cornerRadius = 2.0;
                    label.clipsToBounds = YES;
                    label.text = obj[@"tagname"];
                    label.textAlignment = NSTextAlignmentCenter;
                    [self.companyTagLabelsBackgroundView addSubview:label];
                    [self.tagLabelsArray addObject:label];
                }];
            }
        }
        
    } onError:^(HaoResult *errorResult) {
//        [self.view configBlankPage:EaseBlankPageTypeRequestTimeout hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
//            
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

- (void)configJobPostionInfoViewWithJobPositionData:(NSDictionary *)data
{
    self.companyID = NSValueToString(data[@"companyID"]);
    self.isApply = [NSValueToString(data[@"isApply"]) boolValue];
    [self resetSendRecruitmentButtonState:self.sendRecruitmentButton withIsApply:self.isApply];
    self.collecButton.selected = [NSValueToString(data[@"isFavorite"]) boolValue];
    self.jobPositionLabel.text = NSValueToString(data[@"positionName"]);
    self.wageLabel.text = [NSString stringWithFormat:@"%@-%@元/月", NSValueToString(data[@"wageBegin"]), NSValueToString(data[@"wageEnd"])];
    [self.cityButton setTitle:NSValueToString(data[@"districtCn"]) forState:UIControlStateNormal];
    [self.jobExperienceButton setTitle:[NSString stringWithFormat:@"%@经验", NSValueToString(data[@"experienceCn"])] forState:UIControlStateNormal];
    [self.educationInfoButton setTitle:NSValueToString(data[@"educationCn"]) forState:UIControlStateNormal];
    [self.positonNatureButton setTitle:NSValueToString(data[@"natureCn"]) forState:UIControlStateNormal];
    [self.companyAddressButton setTitle:NSValueToString(data[@"streetCn"]) forState:UIControlStateNormal];
//    [self.jobContentWebView loadRequestWithUrlOrContentString:NSValueToString(data[@"contents"])];
    [self.jobDescriptionWebView loadHTMLString:[self.jobDescriptionWebView changeBaseStringAttributesWithHtmlString:NSValueToString(data[@"contents"]) fontSize:13 textColorStr:@"#666666"] baseURL:nil];
    self.jobDescriptionWebView.scrollView.scrollEnabled = NO;
    NSString *companyType = @"";
    NSString *comopanyScale = @"";
    if (!kDictIsEmpty(data[@"companyIDLocal"])) {
        self.companyNameLabel.text = NSValueToString(data[@"companyIDLocal"][@"companyname"]);
        companyType = NSValueToString(data[@"companyIDLocal"][@"companyTypeCn"]);
        
        [Tool imageView:self.companyAvatarImageView configImageWithUrl:NSValueToString(data[@"companyIDLocal"][@"companylogoLocal"]) placeholderImageName:@""];
        
        //0 未认证 1 认证中 2 已认证
        if ([NSValueToString(data[@"companyIDLocal"][@"status"]) isEqualToString:@"2"]) {
            self.authenticationImageView.hidden = NO;
        } else
        {
            self.authenticationImageView.hidden = YES;
        }
    }
    if (!kDictIsEmpty(data[@"companyIDProfLocal"])) {
        self.companyCategoryLabel.text = NSValueToString(data[@"companyIDProfLocal"][@"tradeCn"]);
        comopanyScale = NSValueToString(data[@"companyIDProfLocal"][@"scaleCn"]);
    }
    self.companyNatrueAndScaleLabel.text = companyType;
    if (self.companyNatrueAndScaleLabel.text.length > 0) {
        self.companyNatrueAndScaleLabel.text = [NSString stringWithFormat:@"%@ | %@", self.companyNatrueAndScaleLabel.text, comopanyScale];
    } else
    {
        self.companyNatrueAndScaleLabel.text = [NSString stringWithFormat:@"%@", comopanyScale];
    }
    

    [self.view updateConstraints];
    
    
}



#pragma mark --- webview delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];

    self.jobContentWebViewBackgroundViewHeight.constant = [fitHeight floatValue];//(self.jobDescriptionWebView.subviews.firstObject.subviews.firstObject.frame.size.height - 1);
  
    [self.view layoutIfNeeded];

}

#pragma mark --- button action

- (IBAction)clickSendRecruitmentButtonAction:(id)sender {
    
    [self sendRecruitmentActionWithSuccessBlock:^(NSDictionary *data){
        self.isApply = YES;
        [self resetSendRecruitmentButtonState:self.sendRecruitmentButton withIsApply:YES];
        SendRecruitmentSuccessViewController *successVC = [[SendRecruitmentSuccessViewController alloc] init];
        [self.navigationController pushViewController:successVC animated:YES];
    }];
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
        
//        } customButtonBlock:nil];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (IBAction)clickGotoMapViewButtonAction:(id)sender {
    
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
        mapVC.navigationItem.title = NSValueToString(self.companyNameLabel.text);
        mapVC.isApply = self.isApply;
        mapVC.jobPositionID = self.jobPositionID;
        mapVC.annotationTitle = NSValueToString(self.companyAddressButton.titleLabel.text);
        mapVC.didClickApplyButtonAction = ^(UIButton *applyButton)
        {
            [self sendRecruitmentActionWithSuccessBlock:^(NSDictionary *data){
                [self resetSendRecruitmentButtonState:applyButton withIsApply:YES];
                [self resetSendRecruitmentButtonState:self.sendRecruitmentButton withIsApply:YES];
                SendRecruitmentSuccessViewController *successVC = [[SendRecruitmentSuccessViewController alloc] init];
                [self.navigationController pushViewController:successVC animated:YES];
            }];
        };
        [self.navigationController pushViewController:mapVC animated:YES];
    }];
}

- (IBAction)clickGotoCompanyDetailViewButtonAction:(id)sender {
    
    CompanyDetailViewController *companyDetailVC = [[CompanyDetailViewController alloc] init];
    companyDetailVC.companyID = self.companyID;
    companyDetailVC.jobPositionID = self.jobPositionID;
    companyDetailVC.isApply = self.isApply;
    [self.navigationController pushViewController:companyDetailVC animated:YES];
    
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
