    //
    //  MainTabBarController.m
    //  eService
    //
    //  Created by 顾新生 on 2016/12/19.
    //  Copyright © 2016年 guxinsheng. All rights reserved.
    //

#import "CrowdTabBarController.h"
#import "Page1ViewController.h"
#import "Page2ViewController.h"
#import "Page3ViewController.h"
#import "Page4ViewController.h"
#import "RTRootNavigationController.h"
#import "BaseNaviViewController.h"
@interface CrowdTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *barTitles;

@property(nonatomic,strong)NSArray *imgs;
@property(nonatomic,strong)NSArray *selectedImgs;

@end

@implementation CrowdTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.tabBar.tintColor=kNavBackgroundColor;
    self.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
-(instancetype)init{
    if (self=[super init]) {
        if (self=[super init]) {
            Page1ViewController *vc1=(Page1ViewController *)[self createVC:[Page1ViewController class] atIndex:0];
            BaseNaviViewController *navi1=[[BaseNaviViewController alloc]initWithRootViewController:vc1];
            
            Page2ViewController *vc2=(Page2ViewController *)[self createVC:[Page2ViewController class] atIndex:1];
            RTRootNavigationController *navi2=[[RTRootNavigationController alloc]initWithRootViewController:vc2];
            
            Page3ViewController *vc3=(Page3ViewController *)[self createVC:[Page3ViewController class] atIndex:2];
            BaseNaviViewController *navi3=[[BaseNaviViewController alloc]initWithRootViewController:vc3];
            
            Page4ViewController *vc4=(Page4ViewController *)[self createVC:[Page4ViewController class] atIndex:3];
            BaseNaviViewController *navi4=[[BaseNaviViewController alloc]initWithRootViewController:vc4];
            [self setViewControllers:@[navi1,navi2,navi3,navi4] animated:YES];

        }
        self.selectedIndex=1;
        return self;
    }
    return self;
}

#pragma mark -create children viewcontroller inherit BaseViewController
-(UIViewController *)createVC:(Class)vcClass atIndex:(NSInteger)index{
    return [self createVCFrom:vcClass title:self.titles[index] barTitle:self.barTitles[index] img:self.imgs[index] selectedImg:self.selectedImgs[index]];
}

-(UIViewController *)createVCFrom:(Class )vcClass title:(NSString *)title barTitle:(NSString *)barTitle img:(NSString *)imgName selectedImg:(NSString *)selectedImg{
    BaseViewController *vc;
    if ([vcClass isSubclassOfClass:[BaseViewController class]]) {
        vc =[[vcClass alloc]init];
        vc.title=title;
        vc.tabBarItem.title=barTitle;
        vc.tabBarItem.image=[UIImage imageNamed:imgName];
        vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImg];
        return vc;
    }
    return nil;
}

#pragma mark
#pragma mark ---------------tabbarcontroller delegate---------------
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    BaseNaviViewController *navi=(BaseNaviViewController *)viewController;
    if ([[navi.viewControllers objectAtIndex:0] isKindOfClass:[Page1ViewController class]]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }

}

#pragma mark
#pragma mark ---------------setter & getter---------------
-(NSArray *)titles{
    if (_titles==nil) {
        _titles=@[@"首页",@"项目",@"消息",@"我的"];
    }
    return _titles;
}
-(NSArray *)barTitles{
    if (_barTitles==nil) {
        _barTitles=@[@"首页",@"项目",@"消息",@"我的"];
    }
    return _barTitles;
}
-(NSArray *)imgs{
    if (_imgs==nil) {
        _imgs=@[@"tab_home_normal",@"tab_job_normal",@"tab_recruitment_normal",@"tab_user_normal"];
    }
    return _imgs;
}
-(NSArray *)selectedImgs{
    if (_selectedImgs==nil) {
        _selectedImgs=@[@"tab_home_selected",@"tab_job_selected",@"tab_recruitment_selected",@"tab_user_selected"];
    }
    return _selectedImgs;
}
@end
