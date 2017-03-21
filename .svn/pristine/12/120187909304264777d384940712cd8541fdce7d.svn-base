//
//  SystemSettingViewController.m
//  dww
//
//  Created by Shadow. G on 2017/1/6.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "ChangePasswordViewController.h"
#import "PrivateSettingViewController.h"
#import "SystemSettingTableViewCell.h"
#import "AppDelegate.h"
#import "UIViewController+Login.h"

@interface SystemSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableViewDataSource;

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"SystemSettingTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([SystemSettingTableViewCell class])];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self setupDataSource];
}

- (void)setupDataSource
{
    self.tableViewDataSource = @[@[@"修改密码"],
                                 @[@"清空缓存", @"版本号"],
                                 @[@"隐私设置"]].mutableCopy;
}

#pragma mark --- tableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewDataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, 10)];
    view.backgroundColor = TABLEVIEWBACKGROUNDCOLOR;
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 0.5)];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"0XD7D7D7"];
    [view addSubview:topLineView];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, view.frame.size.width, 0.5)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"0XD7D7D7"];
    [view addSubview:bottomLineView];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SystemSettingTableViewCell class])];
    cell.titleLabel.text = self.tableViewDataSource[indexPath.section][indexPath.row];
    if ([cell.titleLabel.text isEqualToString:@"清空缓存"] || [cell.titleLabel.text isEqualToString:@"版本号"]) {
        cell.arrowRightImageView.hidden = YES;
    } else
    {
        cell.arrowRightImageView.hidden = NO;
    }
    if ([cell.titleLabel.text isEqualToString:@"清空缓存"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.contentLabel.text = [self Display_cache];
    } else if ([cell.titleLabel.text isEqualToString:@"版本号"])
    {
        cell.contentLabel.text = appMPVersion;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.contentLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.tableViewDataSource[indexPath.section][indexPath.row] isEqualToString:@"修改密码"]) {
        [self changePassword];
    } else if ([self.tableViewDataSource[indexPath.section][indexPath.row] isEqualToString:@"清空缓存"])
    {
        [self cleanCacheCellAction];
    } else if ([self.tableViewDataSource[indexPath.section][indexPath.row] isEqualToString:@"版本更新"])
    {
        
    } else if ([self.tableViewDataSource[indexPath.section][indexPath.row] isEqualToString:@"隐私设置"])
    {
        [self gotoPrivateSettingView];
    }
}


#pragma mark --- cell action

- (void)changePassword
{
    ChangePasswordViewController *changePasswordVC = [[ChangePasswordViewController alloc] init];
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}

- (void)cleanCacheCellAction
{
    [SWAlertView showAlertWithTitle:@"是否清理缓存" message:nil completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
        
        if (buttonIndex == 1) {
            [self clearCash];
        }
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

}

- (void)gotoPrivateSettingView
{
    PrivateSettingViewController *privateSettingVC = [[PrivateSettingViewController alloc] init];
    privateSettingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:privateSettingVC animated:YES];
}

//显示缓存大小
-(NSString *)Display_cache{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [NSString stringWithFormat:@"%@",[paths objectAtIndex:0]];
    float roomMax=0;
    roomMax=[self folderSizeAtPath:documentDirectory];
    if (roomMax>1024.0&&roomMax<1024.0*1024.0) {
        return [NSString stringWithFormat:@"%.fKB",roomMax/1024.0];
    }else if (roomMax>1024.0*1024.0){
        return [NSString stringWithFormat:@"%.2fMB",roomMax/(1024.0*1024.0)];
    }else{
        return @"0KB";
    }
}

-(float )folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

#pragma mark - 查看文件夹大小,用来删除缓存
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//清除缓存
-(void)clearCash{
    
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%ld",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];}
                   );
}
-(void)clearCacheSuccess{
    
    //    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"清理成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alertView show];
    [MBProgressHUD showSuccess:@"清理成功" ToView:nil];
    [self.tableView reloadData];
}


- (IBAction)clickExitLoginAction:(id)sender {
    
    [SWAlertView showAlertWithTitle:@"是否退出登录" message:nil completionBlock:^(NSUInteger buttonIndex, SWAlertView *alertView) {
        
        if (buttonIndex == 1) {
            [g_App appExit];
            [self goLoginWithAnimation:YES completeAction:^{
                [[DWTabBarControllerConfig sharedInstance].tabBarController setSelectedIndex:0];
                [self.navigationController popToRootViewControllerAnimated:NO];
            }];
        }
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
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
