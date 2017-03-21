#import "HaoResult.h"

@interface PubUserResult : HaoResult

/**登录用户ID（其他引用表或为uid）**/
-(id)findPubID;

/**登录用户名**/
-(id)findUserName;

/**用户类型：1公司，2个人**/
-(id)findUtype;

/**固定电话**/
-(id)findLandlineTel;

/****/
-(id)findEmail;

/****/
-(id)findEmailAudit;

/**邮箱密码找回时间**/
-(id)findEmailRemindTime;

/****/
-(id)findMobile;

/****/
-(id)findMobileAudit;

/****/
-(id)findUserPwd;

/****/
-(id)findCreateTime;

/****/
-(id)findUpdateTime;

/**用户状态（0无效，1有效）**/
-(id)findIsEffect;

/****/
-(id)findLoginIp;

/****/
-(id)findLoginTime;

/**找回密码的验证号**/
-(id)findPasswordVerify;

/**登录图像(存放路径）**/
-(id)findAvatars;

/**用户初始注册的系统业务版块**/
-(id)findSector;

@end