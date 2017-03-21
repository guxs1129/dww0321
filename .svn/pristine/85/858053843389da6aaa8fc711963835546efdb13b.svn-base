//
//  JobPositionChooseCityViewController.m
//  dww
//
//  Created by Shadow. G on 2016/12/26.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "JobPositionChooseCityViewController.h"
#import "JobPositonChooseCityCollectionHeaderView.h"
#import "JobPositionChooseCityCollectionViewCell.h"
#import "SWIndexView.h"
#import "HaoConnect.h"
#import "DWAreaDataManager.h"
#import "SWLocationManager.h"

#define kCollectionViewBackgroundColor  [UIColor colorWithHexString:@"0XF5F5F5"]
#define kNavigationBarHeight 64
#define kTabBarHeight 49
#define kHotCitiesSectionTitle @"热门城市"
#define kLocationCitySectionTitle @"定位城市"
@interface JobPositionChooseCityViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) SWIndexView *indexView;
@property (nonatomic, strong) NSArray *citiesIndexDataSource;
@property (nonatomic, strong) NSMutableArray *sectionTitles;
@property (nonatomic, strong) NSMutableArray *collectionItems;
@property (nonatomic, strong) completeChooseCity completeChooseBlock;

@end

@implementation JobPositionChooseCityViewController

static NSString * const reuseIdentifier = @"ChooseCityCollectionViewCellId";
static NSString * const headerReuseIdentifier = @"ChooseCityCollectionViewHeaderViewId";
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = kCollectionViewBackgroundColor;

    // collectionView config
    self.flowLayout = [self setupCollectionLayout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = kCollectionViewBackgroundColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[JobPositionChooseCityCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JobPositonChooseCityCollectionHeaderView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.top.mas_equalTo(0);
    }];
    
    // create IndexView
    [self createIndexView];
    [self requestHotCitiesDataWithCompleteBlock:^(BOOL isNeedUpdateAllCitiesCache) {
        if (isNeedUpdateAllCitiesCache) {
            [self requestCitiesListDataWithCompleteBlock:^{
                [self setupCollectionViewDataSource];
            }];
        } else
        {
            [self setupCollectionViewDataSource];
        }
    }];
    
}

- (void)setupCollectionViewDataSource
{
//    [MBProgressHUD showMessage:@"定位中..." ToView:self.view];
    // 获取全部城市
    self.collectionItems = [NSMutableArray arrayWithArray:[DWAreaDataManager getAllCitiesDataWithSorted]];
    NSMutableArray *indexArray = [NSMutableArray arrayWithCapacity:1];
    [self.collectionItems enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexArray addObject:[obj allKeys].firstObject];
    }];
    self.sectionTitles = indexArray;
    
    // 获取热门城市
    NSMutableArray *hotCities = [NSMutableArray arrayWithArray:[DWAreaDataManager getHotCitiesData]];
    if (!_isorNotShowQuanGuo) {
        [hotCities insertObject:@{kCityNameKey:@"全国", kCityIDKey:@""} atIndex:0];
    }
    if (hotCities && [hotCities isKindOfClass:[NSArray class]] && hotCities.count > 0) {
        [self.collectionItems insertObject:@{kHotCitiesSectionTitle:hotCities} atIndex:0];
        [self.sectionTitles insertObject:kHotCitiesSectionTitle atIndex:0];
    }
    // 获取定位城市
    if ([NSValueToString([SWLocationManager sharedInstance].cityName) length] > 0) {
        NSString *cityID = [DWAreaDataManager getCityIDWithCityName:NSValueToString([SWLocationManager sharedInstance].cityName)];
        if (self.collectionItems.firstObject && [self.collectionItems.firstObject isKindOfClass:[NSDictionary class]]) {
            if ([[self.collectionItems.firstObject allKeys] containsObject:kLocationCitySectionTitle]) {
                
            }else
            {
                [self.collectionItems insertObject:@{kLocationCitySectionTitle:@[@{kCityNameKey:NSValueToString([SWLocationManager sharedInstance].cityName), kCityIDKey:cityID}]} atIndex:0];
                [self.sectionTitles insertObject:kLocationCitySectionTitle atIndex:0];
            }
        }

    }
    DISPATCH_ON_MAIN_THREAD(^{
        [self.collectionView reloadData];
    });
    [[SWLocationManager sharedInstance] startLocationWithBlock:^(BOOL getOK, NSString *lat, NSString *lng, NSString *errorMsg, NSString *cityName) {
        
        NSString *cityID = [DWAreaDataManager getCityIDWithCityName:cityName];
        if (getOK && [NSValueToString(cityName) length] > 0 && [NSValueToString(cityID) length] > 0) {
            if (self.collectionItems.firstObject && [self.collectionItems.firstObject isKindOfClass:[NSDictionary class]]) {
                if ([[self.collectionItems.firstObject allKeys] containsObject:kLocationCitySectionTitle]) {
                    
                }else
                {
                    [self.collectionItems insertObject:@{kLocationCitySectionTitle:@[@{kCityNameKey:cityName, kCityIDKey:cityID}]} atIndex:0];
                    [self.sectionTitles insertObject:kLocationCitySectionTitle atIndex:0];
                }
            }

        }
        DISPATCH_ON_MAIN_THREAD(^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.collectionView reloadData];
        });
        
    }];

}

#pragma mark --- request

- (void)requestCitiesListDataWithCompleteBlock:(void(^)())block
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"2",@"g_r_a_d_e",
               nil];
    [HaoConnect request:@"pub_category_district/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {

            [DWAreaDataManager saveCityListToCache:result.results lastUpdateTime:@"" cachePath:[DWAreaDataManager cachePathOfAllCities] withCompletion:^{
                
                if (block) {
                    block();
                }
                
            }];
 
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (void)requestHotCitiesDataWithCompleteBlock:(void(^)(BOOL isNeedUpdateAllCitiesCache))completeBlock
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * exprame  = nil;
    exprame = [NSMutableDictionary dictionaryWithObjectsAndKeys:
               @"1",@"page",
               @"999",@"size",
               @"1",@"hotcity",
               @"2",@"g_r_a_d_e",
               nil];
    [HaoConnect request:@"pub_category_district/list" params:exprame httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result.isResultsOK) {
            
//            if ([DWAreaDataManager cacheUpdateIfNeedWith:[[NSDate date] stringWithFormat:kDateFormatString] cachePath:[DWAreaDataManager cachePathOfHotCities]]) {
            
                [DWAreaDataManager saveCityListToCache:result.results lastUpdateTime:[[NSDate date] stringWithFormat:kDateFormatString] cachePath:[DWAreaDataManager cachePathOfHotCities] withCompletion:^{
                    if (completeBlock) {
                        completeBlock(YES);
                    }
                }];
//            } else
//            {
//                if (completeBlock) {
//                    completeBlock(NO);
//                }
//            }
            
        }
        
    } onError:^(HaoResult *errorResult) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

-(void)createIndexView
{
    NSMutableArray * arr = [NSMutableArray new];
    for (int i = 0; i < 26; i ++)
    {
        unichar ch = 65 + i;
        NSString * str = [NSString stringWithUTF8String:(char *)&ch];
        [arr addObject:str];
    }
    
    [arr insertObject:@"#" atIndex:0];
    
    self.citiesIndexDataSource = arr;

    CGFloat contentInsetTop = 10;
    CGFloat contentInsetBottom = 10;
    CGFloat viewWidth = 30;
    self.indexView = [[SWIndexView alloc]initWithFrame:CGRectMake(ScreenSizeWidth - viewWidth, contentInsetTop, viewWidth, ScreenSizeHeight - kNavigationBarHeight - kTabBarHeight - contentInsetTop - contentInsetBottom) indexArray:arr];
    [self.view addSubview:self.indexView];
    
    [self.indexView selectIndexBlock:^(NSInteger section, NSString *title)
     {
         if (section == 0) {
             [self.collectionView setContentOffset:CGPointZero];
         } else
         {
             if ([self sectionForSectionTitle:title] != NSNotFound) {
                 [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[self sectionForSectionTitle:title]] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
             }
         }
        
     }];
}

- (NSUInteger)sectionForSectionTitle:(NSString *)title
{
    __block NSUInteger index = NSNotFound;
    [self.sectionTitles enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:title]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

#pragma mark --- navigation bar appearance

- (BOOL)hideNavigationBottomLine
{
    return NO;
}
- (UIButton *)set_leftButton
{
    return [[UIButton alloc] initWithFrame:CGRectZero];
}

- (UIImage *)set_rightBarButtonItemWithImage
{
    return [[UIImage imageNamed:@"chooseCity_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)right_button_event:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableAttributedString *)setTitle
{
    return [[NSMutableAttributedString alloc] initWithString:@"选择城市"];
}
- (UICollectionViewFlowLayout *)setupCollectionLayout
{
    NSInteger numberOfRow = 3;
    CGFloat itemHeight = 35;
    CGFloat itemSpace = 21;
    CGFloat minimumLineSpacing = 12;
    CGFloat contentInsetLeft = 24;
    CGFloat contentInsetRight = 24;
    CGFloat contentInsetTop = 12;
    CGFloat contentInsetBottom = 12;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((ScreenSizeWidth - contentInsetLeft - contentInsetRight - (numberOfRow - 1) * itemSpace) / numberOfRow, itemHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(contentInsetTop, contentInsetLeft, contentInsetBottom, contentInsetRight);
    flowLayout.minimumLineSpacing = minimumLineSpacing;
    return flowLayout;
}


#pragma mark --- getter

- (NSArray *)citiesIndexDataSource
{
    if (!_citiesIndexDataSource) {
        _citiesIndexDataSource = [NSArray array];
    }
    return _citiesIndexDataSource;
}

- (NSMutableArray *)collectionItems
{
    if (!_collectionItems) {
        _collectionItems = [NSMutableArray arrayWithCapacity:1];
    }
    return _collectionItems;
}

- (NSMutableArray *)sectionTitles
{
    if (!_sectionTitles) {
        _sectionTitles = [NSMutableArray arrayWithCapacity:1];
    }
    return _sectionTitles;
}

#pragma mark --- collectionView DataSource & delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.collectionItems.count;
}
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   
    CGSize size = {0, 40};
    return size;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        JobPositonChooseCityCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        
        headerView.titleLabel.text = [self.collectionItems[indexPath.section] allKeys].firstObject;
        reusableview = headerView;
        
    }
   
    return reusableview;
    
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionItems[section][self.sectionTitles[section]] count];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JobPositionChooseCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.contentButton setTitle:self.collectionItems[indexPath.section][self.sectionTitles[indexPath.section]][indexPath.item][kCityNameKey] forState:UIControlStateNormal];
    if ([self.sectionTitles[indexPath.section] isEqualToString:kLocationCitySectionTitle]) {
        [cell.contentButton setImage:[UIImage imageNamed:@"chooseCity_location"] forState:UIControlStateNormal];
    } else
    {
        [cell.contentButton setImage:nil forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.completeChooseBlock) {
        self.completeChooseBlock(self.collectionItems[indexPath.section][self.sectionTitles[indexPath.section]][indexPath.item][kCityNameKey], self.collectionItems[indexPath.section][self.sectionTitles[indexPath.section]][indexPath.item][kCityIDKey]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark --- set completeChooseBlock

-(void)setCompleteChooseCityBlock:(completeChooseCity)block
{
    if (block) {
        self.completeChooseBlock = [block copy];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
