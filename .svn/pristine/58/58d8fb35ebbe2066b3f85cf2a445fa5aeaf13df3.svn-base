//
//  Global.h
//  东方赢家
//
//  Created by dfzq on 16/6/3.
//  Copyright © 2016年 Orientsec. All rights reserved.
//

#ifndef                                                                          Global_h
#define                                                                          Global_h

// 友盟分享相关
#define WXAPPID         @"wx419c24f499ccbdc8"
#define WXAPPSECRECT    @"227b43779b8f36a0337ade12bb4bd720"
#define QQAPPID         @"1105878485"
#define QQAPPKEY        @"6Ew9QEVdM9SFdKHy"
#define SINAAPPKEY      @"2919711087"
#define SINAAPPSECRECT  @"6f79ec65e33a91677f2a44b9ac9cbbef"
#define UMENGSDKKEY     @"587f68a7c895767121000352"

// 导航标题字体大小
#define kNavTitleFontSize              18
// 导航标题字体颜色
#define kNavTitleFontColor             [UIColor whiteColor]
// 导航背景色
#define kNavBackgroundColor            [UIColor colorWithHexString:@"0x632D8F"]
// 导航色彩颜色
#define kNavTintColor                  [UIColor colorWithHexString:@"0x632D8F"]
// UITextField光标颜色
#define kTextFieldMouseColor           [UIColor colorWithHexString:@"0xF16D1A"]
// UITextView光标颜色
#define kTextViewMouseColor            [UIColor colorWithHexString:@"0xF16D1A"]
#define kColorTableSectionBg           [UIColor colorWithHexString:@"0xeeeeee"]

#define RUNIN_MAINQUEUE(b)             dispatch_async(dispatch_get_main_queue(), b)
#define Promise                               PMKPromise

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

// 短信验证码位数
#define mobileTelCodeLength             6
// 短信验证码重发时间（精确到秒数）
#define mobileTelCodeTimeout            60
// 手机号码长度
#define mobileTelLength                 11
// 身份证编号长度
#define idNoLength                      18
// 姓名长度
#define nameLength                      8
// 密码长度
#define passwordLength                  8

// ISNULL
#define MAYBENULL(s)                    s == nil || s == NULL || [s isKindOfClass:[NSNull class]] || [[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ? @"" : s

// 布局相关配置值设置
// TableView的默认背景色
#define kTableViewDefaultBg [UIColor colorWithHexString:@"0xEFEFF1"]
// TableViewCell默认高度
#define kTableViewCellDefaultHeight     kDevice_Is_iPhone4 ? 38.0 : 48.0
// TableViewCellLeftPadding
#define kTableViewCellLeftPadding       20.0
// 业务单元格重用标识
#define kMobileTableViewCell            @"kMobileTableViewCell"
#define kMobilePasswordTableViewCell    @"kMobilePasswordTableViewCell"
#define kAccountTableViewCell           @"kAccountTableViewCell"
#define kAccountPasswordTableViewCell   @"kAccountPasswordTableViewCell"
// 通用单元格重用标识
#define kInputTextCell                  @"kInputTextCell"
#define kInputPasswordTextCell          @"kInputPasswordTextCell"
#define kInputPhoneCodeTextCell         @"kInputPhoneCodeTextCell"
// UILine默认背景色
#define kLineDefaultBg [UIColor colorWithHexString:@"0xD7D8DA"]

// Button默认高度
#define kButtonDefaultHeight            40.0

// 滑块segmentControl默认高度
#define kMySegmentControl_Height        44.0

// OBStatusBar停留时间
#define OBStatusBarDockTimeInterval     3.5f

// enum转String描述
#define enumToString(value)             @#value
// enum转String值
#define enumToStringValue(value)        [NSString stringWithFormat:@"%ld", (long)value]

#define APIVERSION @"2.6"

#endif /* Global_h */
