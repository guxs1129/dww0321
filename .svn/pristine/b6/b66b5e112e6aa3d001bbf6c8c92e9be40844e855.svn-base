//
//  DWTabBarController.m
//  dww
//
//  Created by Shadow.G on 16/12/21.
//  Copyright © 2016年 haoxitech. All rights reserved.
//

#import "DWTabBarController.h"
#import "DWTabBar.h"

@interface DWTabBarController ()

@end

@implementation DWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
//    [self setUpTabBar];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    //去除 TabBar 自带的顶部阴影
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];

    //设置导航控制器颜色
    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:kNavBackgroundColor] forBarMetrics:UIBarMetricsDefault];


}
#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    [self setValue:[[DWTabBar alloc] init] forKey:@"tabBar"];
}


/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kNavBackgroundColor;

    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateHighlighted];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}


/**
 *  添加子控制器
 */
- (void)setUpChildViewController{
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[UIViewController alloc]init]]
                          WithTitle:@"首页"
                          imageName:@"tab_home_normal"
                  selectedImageName:@"tab_home_selected"];
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[UIViewController alloc] init]]
                          WithTitle:@"职位"
                          imageName:@"tab_job_normal"
                  selectedImageName:@"tab_job_selected"];
    
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[UIViewController alloc]init]]
                          WithTitle:@"简历"
                          imageName:@"tab_recruitment_normal"
                  selectedImageName:@"tab_recruitment_selected"];
    
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[UIViewController alloc]init]]
                          WithTitle:@"我的"
                          imageName:@"tab_user_normal"
                  selectedImageName:@"tab_user_selected"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.view.backgroundColor     = [UIColor whiteColor];
    viewController.tabBarItem.title         = title;
    viewController.tabBarItem.image         = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    [self addChildViewController:viewController];
    
}


//这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
