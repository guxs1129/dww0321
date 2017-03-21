//
//  GlobalEnum.h
//  东方赢家
//
//  Created by dfzq on 16/6/30.
//  Copyright © 2016年 orientsec. All rights reserved.
//

#ifndef GlobalEnum_h
#define GlobalEnum_h

typedef enum{
    IdentifyCard = 0        // 身份证
}OBIDType;

typedef enum{
    LoginMethodPhone = 0,       // 手机号登录
    LoginMethodAccount          // 资金账号登录
}LoginMethodType;

//枚举未知状态
typedef NS_ENUM(NSUInteger, UNKNOWNENUM) {
    unKnown = 9999              // 未知状态类型
};

//财富账户状态(清不清洗看0084，这个字段只和财富账户有关)
typedef NS_OPTIONS(NSInteger, CIFCATEGORY){
    //    // 原始理解
    //    NoRealName = 0,             // 未实名(有财富账户未关联)
    //    NoCleaned,                  // 无账户(无财富账户)
    //    AlreadyRealName             // 已实名(有财富账户已关联)
    
    // 正确理解
    hasCifNoRelated = 0,        // 有财富账户未关联
    noCif,                      // 无账户(无财富账户)
    hasCifHasRelated            // 有财富账户已关联
};

//证件类型
typedef enum {
    idtypeCardType = 0,         //身份证
}IDTYPEENUM;

// 客户类型
typedef NS_OPTIONS(NSInteger, CLIENTTYPE) {
    personal = 0,               //个人
    institutions,               //机构
    proprietary,                //自营
    product,                    //产品
    ofTheHousehold,             //特法户
};

//业务系统编号
typedef enum {
    CentralizedTrading = 3,     //集中交易
    SecuritiesLendingAndBorrowing = 6,  //融资融券
    ManyFinancial = 15,     //多金融
    AddRicHui = 1008        //汇添富
}BIZSYSIDNUM;

// 是否签约
typedef NS_OPTIONS(NSInteger, SIGNDLAG) {
    DidNotSignup = 0,       //未签约
    HavedSignup = 1         //已签约
};

// 性别
typedef NS_ENUM(NSInteger, GENDER) {
    boy,            //男
    girl,           //女
    ANaturalPerson,  //非自然人(如机构)
};

// 风险等级
typedef enum {
    DefaultLevel = 0,       // 默认等级
    HighLevel = 001,        //高风险承受级别
    MidHighLevel = 002,     //中高风险承受级别
    MidLevel = 003,         //中风险承受级别
    MidLowLevel = 004,      //中低风险承受级别
    LowLevel = 005          //低风险承受级别
    
}RISKLEVEL;

// 资产类型
typedef NS_ENUM(NSUInteger, ASSETTYPE) {
    CurrencyFund = 1,       // 货基
    OTCFix,                 // otc
    Fund,                   // 场外基金
};

// 委托交易类型
typedef NS_ENUM(NSUInteger, ENTRUSTFLOWTYPE) {
    Recharge = 1,           // 充值
    WithdrawCash = 2,       // 取现(普取都为取现)
    WithWidnthsho =3,       // 快速取现
    Subscription = 4,       // 认购（OTC流水都为认购 )
    Maturitypayment = 5,    // 到期兑付
    Purchase = 6,           // 申购
    Redempition = 7,        // 赎回
    SubscriptionRevoke = 8,  //认购撤单
    PurchaseRevoke = 9,      //申购撤单
    RedempitionRevoke = 10,   //赎回撤单
    Dividended          = 11   //分红
};

// 委托状态
typedef NS_ENUM(NSUInteger, ENTRUSTFLOWSTATUS) {
    TradeSuccess = 1,       // 交易成功
    TradeFailure,           // 交易失败
    Unconfirmed,            // 待确认
    PFL,                    // 部分成交
    RevokeOrder,            // 撤销订单(撤单)
    Refund                  // 退款
};


// 东方红业务标志
typedef NS_ENUM(NSUInteger,DFHongBusiFlag){
    
   SubScription =1,
   PurChase = 2,
   DFRedempition = 3,
   Dividend = 4,
   AllowBack = 5,

};
// 是否可以撤销
typedef NS_ENUM(NSUInteger,ALLOWBACK){
    
    notAllowed = 0,
    Allowed

};

//分红类型
typedef NS_ENUM(NSUInteger,SHARETYPES){
   marketShare = 0,
   cashShare
   
};

// 资金支付状态
typedef NS_ENUM(NSUInteger, INVPAYSTATUS) {
    Untreated = 0,          // 未处理
    Confirmed,              // 已确认
    success,                // 成功
    failure,                // 失败(OTC需要)
};

// 银行卡状态
typedef NS_ENUM(NSUInteger, BANKCARDSTATUS) {
    UnbindCard = 0,         // 未绑卡
    BindedNewCard,          // 已绑新卡
    BindedOldCard,          // 已绑旧卡
};

// 币种
typedef NS_ENUM(NSUInteger, MONEYTYPE) {
    RMB = 0,                // 人民币
    DOLLAR,                 // 美元
    GB,                     // 港币
};

// 账户开通状态
typedef enum
{
    noAccount = 0,           // 无注册账户无财富账户(未实名)
    hasRegAccount,           // 有注册账户无财富账户(未清洗)
    hasCifAccount            // 有注册账户有财富账户(已实名)
}ACCTOPENSTATE;

typedef NS_ENUM(NSUInteger, PAYPASSWORDSTATUS) {
    NewPassword = 0,        // 财富设置(已设置)
    OldPassword,            // 金士达迁移(未设置)
    NoPassword,             // 没有(未设置)
};

typedef NS_ENUM(NSUInteger, ALERTSHOW_TAG_ENUM) {
    AlertShowTagTokenExpire = 100001,// Token过期
    AlertShowTagNetWorkLost,// 网络开小差
};

typedef NS_ENUM(NSUInteger, PUSH_CONTROLLER_TAG_ENUM) {
    PushControllerNone = 0,//默认
    PushControllerHundsun,//恒生跳转
    
};

// 业务办理 开始 //
// 证券市场
typedef NS_ENUM(NSUInteger, SM_MARKET_TYPE) {
    SM_SH = 0,    // 上海市场
    SM_SZ,        // 深圳市场
    SM_ALL        // 所有市场
};

// 业务方式
typedef NS_ENUM(NSUInteger, SM_BUSINESS_METHOD) {
    SM_BUSINESS_PERSONAL = 0,      // 个人业务办理
    SM_BUSINESS_ORGAN              // 机构业务办理
};

// 业务类型
typedef NS_ENUM(NSUInteger, SM_BUSINESS_TYPE) {
    SMR = 0,      // 退市整理股票协议签署
    SMQ,          // 债券逆回购协议签署
    SMW,          // 风险警示股票协议签署
};

// 业务办理 结束 //

// 港股通&深港通 开始 //
// 题目类型
typedef NS_ENUM(NSUInteger, SMP_QUESTION_TYPE) {
    SMP_QUESTION_TYPE_JUDGE = 0,    // 判断题
    SMP_QUESTION_TYPE_SELECT,       // 单选题
    SMP_QUESTION_TYPE_MUTILSELECT   // 多选题
};

// 业务类型
typedef NS_ENUM(NSUInteger, SMP_BUSINESS_TYPE) {
    SMP_BUSINESS_HGT = 0,           // 沪港通
    SMP_BUSINESS_SGT                // 深港通
};

// 业务方式
typedef NS_ENUM(NSUInteger, SMP_BUSINESS_METHOD) {
    SMP_BUSINESS_PERSONAL = 0,      // 个人业务办理
    SMP_BUSINESS_ORGAN              // 机构业务办理
};

// 业务办理状态
typedef NS_ENUM(NSUInteger, SMP_BUSINESS_STATUS) {
    SMP_STATUS_DEFAULT = 999,   // 初始
    SMP_STATUS_FAIL = -1,      // 失败
    SMP_STATUS_NONE = 0,       // 未开通
    SMP_STATUS_ING = 1,        // 处理中
    SMP_STATUS_SUCCESS = 2     // 成功
};

// 做题模式
typedef NS_ENUM(NSUInteger, SMP_QUESTION_MODE) {
    SMP_New_Mode = 0,     // 新做模式
    SMP_View_Mode = 1,    // 阅卷模式
    SMP_Reset_Mode = 2,   // 重做模式
};

// 做题模式
typedef NS_ENUM(NSUInteger, SMP_ANSWER_RESULT) {
    SMP_RIGHT = 0,        // 正确
    SMP_ERROR = 1         // 错误
};

// 港股通&深港通 结束 //

// 退市整理股票协议签署 开始 //
typedef NS_ENUM(NSUInteger, SMR_BUSINESS_STATUS) {
    SMR_STATUS_DEFAULT = 999,   // 初始
    SMR_STATUS_FAIL = -1,      // 失败
    SMR_STATUS_NONE = 0,       // 未开通
    SMR_STATUS_ING = 1,        // 处理中
    SMR_STATUS_SUCCESS = 2     // 成功
};

// 退市整理股票协议签署 结束 //

// 债券逆回购 开始 //
typedef NS_ENUM(NSUInteger, SMQ_BUSINESS_STATUS) {
    SMQ_STATUS_DEFAULT = 999,   // 初始
    SMQ_STATUS_FAIL = -1,      // 失败
    SMQ_STATUS_NONE = 0,       // 未开通
    SMQ_STATUS_ING = 1,        // 处理中
    SMQ_STATUS_SUCCESS = 2     // 成功
};

// 债券逆回购 结束 //

// 风险警示股票协议签署 开始 //
typedef NS_ENUM(NSUInteger, SMW_BUSINESS_STATUS) {
    SMW_STATUS_DEFAULT = 999,   // 初始
    SMW_STATUS_FAIL = -1,      // 失败
    SMW_STATUS_NONE = 0,       // 未开通
    SMW_STATUS_ING = 1,        // 处理中
    SMW_STATUS_SUCCESS = 2     // 成功
};

// 风险警示股票协议签署 结束 //

#endif /* GlobalEnum_h */
