//
//  Config.h
//  AnXin
//
//  Created by wt on 15-4-19.
//  Copyright (c) 2014年 wt. All rights reserved.
//



//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();

#define IsIOS7              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define iPhone4             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(960, 1704), [[UIScreen mainScreen] currentMode].size) : NO)

#define ScreenSizeWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenSizeHeight    ([UIScreen mainScreen].bounds.size.height)

// 界面通用颜色
#define DARKLINECOLOR [UIColor colorWithHexString:@"0xD7D7D7"]
#define LIGHTLINECOLOR [UIColor colorWithHexString:@"0xEEEEEE"]
#define DARKTEXTCOLOR [UIColor colorWithHexString:@"0x333333"]
#define MIDDLEDARKTEXTCOLOR [UIColor colorWithHexString:@"0x666666"]
#define LIGHTTEXTCOLOR [UIColor colorWithHexString:@"0x999999"]
#define TABLEVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]
#define CUSTOMCOLOR         [UIColor colorWithRed:213/255.0 green:143/255.0 blue:03/255.0 alpha:1]
#define CUSTOMREDCOLOR      [UIColor colorWithHexString:@"0xf64515"]

#define CUSTOMBUTTONORANGECOLOR      [UIColor colorWithHexString:@"0xffa200"]

#define CUSTOMORANGECOLOR       [UIColor colorWithHexString:@"0xfda128"]

#define CUSTOMLIGHTGRYCOLOR     [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1]


#define ProductName         [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]

#define Version             [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

#define ShortVersion        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define XINGEAPPKEY         @"I4F7S871QTZR"

#define MAPKEY              @"e4acbe83d3053fd3de6e5a28b1333ed6"

#define UMENGSDKKEY @"56ad7f8a67e58eaf5500159d"

#define SELECTLASTINDEHIS   @"onclickSelect"
#define SHENGFENZHENG       @"shengfenzheng"
#define SELECTINDEX         @"selectIndex"

#define g_App               ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define UserLoginStatus              [UserLoginStatusManager sharedManager]

#define NSValueToString(a)  ([[NSString stringWithFormat:@"%@",a] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",a] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",a] isEqualToString:@"null"])?@"":[NSString stringWithFormat:@"%@",a]

//#define GoOpenAccount       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.dfzq.com.cn/dfzq/mobile/download_zx.html"]]

//#define GoOpenAccount       [HsActionUITool GoToHsOpenAccountViewController]

//分享相关
#define WXAppKey      @"wx2b7cf6dc8d2c5ac6"
#define WBAppKey      @"4108759421"
#define kRedirectURL  @"https://api.weibo.com/oauth2/default.html"
#define QQAppID       @"1105584653"


//个推相关
#define kGtAppId           @"sOtgr6saBx8GsqjmXaMBb"
#define kGtAppKey          @"S6GvwjkWij6LAiQsLMeSe4"
#define kGtAppSecret       @"SmMwsY1x9GAPDyUZJtd5GA"

//协议编号相关
//港股通协议 开始//
#define SGTSectionProtocolCodeP      @"SGT-P"               // 深港通协议区域编号（个人）
#define SGTRiskProtocolCodeP         @"SGT-RISK-P"          // 深港通风险揭示书（个人）
#define SGTPromiseProtocolCodeP      @"SGT-COMMITMENT-P"    // 深港通承诺函（个人）
#define SGTDelegateProtocolCodeP     @"SGT-ENTRUSTMENT-P"   // 深港通委托协议书（个人）

#define SGTSectionProtocolCodeC      @"SGT-C"               // 深港通协议区域编号（机构）
#define SGTRiskProtocolCodeC         @"SGT-RISK-C"          // 深港通风险揭示书（机构）
#define SGTPromiseProtocolCodeC      @"SGT-COMMITMENT-C"    // 深港通承诺函（机构）
#define SGTDelegateProtocolCodeC     @"SGT-ENTRUSTMENT-C"   // 深港通委托协议书（机构）

#define HGTSectionProtocolCodeP      @"HGT-P"               // 沪港通协议区域编号（个人）
#define HGTRiskProtocolCodeP         @"HGT-RISK-P"          // 沪港通风险揭示书（个人）
#define HGTPromiseProtocolCodeP      @"HGT-COMMITMENT-P"    // 沪港通承诺函（个人）
#define HGTDelegateProtocolCodeP     @"HGT-ENTRUSTMENT-P"   // 沪港通委托协议书（个人）

#define HGTSectionProtocolCodeC      @"HGT-C"               // 沪港通协议区域编号（机构）
#define HGTRiskProtocolCodeC         @"HGT-RISK-C"          // 沪港通风险揭示书（机构）
#define HGTPromiseProtocolCodeC      @"HGT-COMMITMENT-C"    // 沪港通承诺函（机构）
#define HGTDelegateProtocolCodeC     @"HGT-ENTRUSTMENT-C"   // 沪港通委托协议书（机构）
//港股通协议 结束//

//退市整理股票协议签署 开始//
#define SMRSectionSHProtocolCodeP      @"SGT-P1"             // 退市整理股票上海市场区域编号（个人）
#define SMRSectionSZProtocolCodeP      @"SGT-P2"             // 退市整理股票深圳市场区域编号（个人）
#define SMRSectionSHProtocolCodeC      @"SGT-P3"             // 退市整理股票上海市场区域编号（机构）
#define SMRSectionSZProtocolCodeC      @"SGT-P4"             // 退市整理股票深圳市场区域编号（机构）
//退市整理股票协议签署 结束//

//债券逆回购协议签署 开始//
#define SMQSectionProtocolCodeP      @"SGT-P5"               // 债券逆回购区域编号（个人）
#define SMQSectionProtocolCodeC      @"SGT-P6"               // 债券逆回购区域编号（机构）
//债券逆回购协议签署 结束//

//风险警示股票协议签署 开始//
#define SMWSectionProtocolCodeP      @"SGT-P7"               // 风险警示股票区域编号（个人）
#define SMWSectionProtocolCodeC      @"SGT-P8"               // 风险警示股票区域编号（机构）
//风险警示股票协议签署 结束//

//单元格样式
#define kPaddingLeftWidth 15.0
#define kBottomSectionHeight  iPhone4 ? 44.0 : 55.0
#define kMargin 10.0
#define kViewHeight iPhone4 ? 44.0 : (iPhone5 ? 50.0 : 55.0)
#define kTabBarSegmentHeight 30.0
#define kTableCellApartMargin 8.0

#define BundleFirstLungtch  @"BundleFirstLungtch"
#define BaseTableViewCellIdentifier  @"BaseTableViewCellIdentifier"
#define Empty_Placeholder @"-"

// Block
typedef void (^VoidBlock)();

#define KEYBOARDSHOWASSIC   @"getASCIICodeList"

// Webview URL
// 月度对账单
#define KMouthBillURL       @"http://itest.dfzq.com.cn/app/views/billMonth.html"
// 小I机器人
#define xiaoIURL            @"http://101.231.210.67:4001/robot-dfzq-h5/index.html?theme=red&platform=ios&isShow=false"

//#ifndef __OPTIMIZE__
//
////#define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt"\n\n"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//
//#define NSLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__)
//
//#else
//
//#define NSLog(...) {}
//
//#endif
