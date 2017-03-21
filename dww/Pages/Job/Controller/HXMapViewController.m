//
//  HXMapViewController.m
//  10000care
//
//  Created by Shadow.G on 16/5/8.
//  Copyright © 2016年 haoxi. All rights reserved.
//

#import "HXMapViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface HXMapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *_mapView;
    MKPointAnnotation *_annotation;
    CLLocationManager *_locationManager;
    CLLocationCoordinate2D _currentLocationCoordinate;
//    BOOL _isCanNavigation;
}
@property (strong, nonatomic) IBOutlet UIButton *destinationAddressButton;
@property (strong, nonatomic) IBOutlet UIView *destinationAddressBackgroundView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *applyButtonHeight;
@property (strong, nonatomic) IBOutlet UIButton *applyButton;

@property (strong, nonatomic) NSString *addressString;
@end

@implementation HXMapViewController
@synthesize addressString = _addressString;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        _isCanNavigation = NO;
    }
    
    return self;
}
- (instancetype)initWithLocation:(CLLocationCoordinate2D)locationCoordinate
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
//        _isCanNavigation = YES;
        _currentLocationCoordinate = locationCoordinate;
    }

    return self;
}


#pragma mark --- button action

- (IBAction)clickApplyButtonAction:(id)sender {
    if (self.didClickApplyButtonAction) {
        self.didClickApplyButtonAction(self.applyButton);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (trimming(self.jobPositionID).length < 1) {
        self.applyButtonHeight.constant = 0;
    } else
    {
        self.applyButtonHeight.constant = 45;
    }
    if (self.isApply) {
        self.applyButton.userInteractionEnabled = NO;
        self.applyButton.backgroundColor = [UIColor lightGrayColor];
        [self.applyButton setTitle:@"简历已投递" forState:UIControlStateNormal];
    } else
    {
        self.applyButton.userInteractionEnabled = YES;
        self.applyButton.backgroundColor = CUSTOMORANGECOLOR;
        [self.applyButton setTitle:@"立即申请" forState:UIControlStateNormal];
    }
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.zoomEnabled = YES;
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.destinationAddressBackgroundView.mas_top).offset(0);
    }];
    [self.destinationAddressButton setTitle:NSValueToString(self.annotationTitle) forState:UIControlStateNormal];
//    if (_isCanNavigation == NO) {
        _mapView.showsUserLocation = YES;//显示当前位置
        [self startLocation];
        [self removeToLocation:_currentLocationCoordinate];
//    }
//    else{
//        UIButton *naButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
//        [naButton setTitle:@"导航" forState:UIControlStateNormal];
//        [naButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        [naButton addTarget:self action:@selector(naLocation) forControlEvents:UIControlEventTouchUpInside];
//        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:naButton]];
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//        [self removeToLocation:_currentLocationCoordinate];
//    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    __weak typeof(self) weakSelf = self;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (!error && array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            weakSelf.addressString = placemark.name;
            userLocation.title = placemark.name;
//            [self removeToLocation:userLocation.coordinate];
        }
    }];
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
        float zoomLevel = 0.01;
        MKCoordinateRegion region = MKCoordinateRegionMake(_currentLocationCoordinate, MKCoordinateSpanMake(zoomLevel, zoomLevel));
        [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];

}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (error.code == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:[error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey]
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            break;
        case kCLAuthorizationStatusDenied:
        {
            
        }
        default:
            break;
    }
}

#pragma mark - public

- (void)startLocation
{
    if([CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 5;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;//kCLLocationAccuracyBest;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
        _mapView.userTrackingMode=MKUserTrackingModeFollow;
    }
    
//    if (_isCanNavigation) {
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)createAnnotationWithCoords:(CLLocationCoordinate2D)coords
{
    if (_annotation == nil) {
        _annotation = [[MKPointAnnotation alloc] init];
    }
    else{
        [_mapView removeAnnotation:_annotation];
    }
    _annotation.coordinate = coords;
    _annotation.title = NSValueToString(self.annotationTitle);
//    _annotation.subtitle = @"副标题";
    
    [_mapView addAnnotation:_annotation];
    [_mapView selectAnnotation:_annotation animated:YES];
}

- (void)removeToLocation:(CLLocationCoordinate2D)locationCoordinate
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    _currentLocationCoordinate = locationCoordinate;
//    float zoomLevel = 0.01;
//    MKCoordinateRegion region = MKCoordinateRegionMake(_currentLocationCoordinate, MKCoordinateSpanMake(zoomLevel, zoomLevel));
//    [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    
//    if (_isCanNavigation) {
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//    }
    
    [self createAnnotationWithCoords:_currentLocationCoordinate];
}

- (void)naLocation
{
    
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
