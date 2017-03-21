#import "PubUserConnect.h"

@implementation PubUserConnect

/**
* 用户:查看表结构（限管理员）
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestColumns:(NSMutableDictionary *)params
                          OnCompletion:(void (^)(HaoResult *result))completionBlock
                               onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"pub_user/columns" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 用户:新建
* @param  NSMutableDictionary * params  参数
*                        pub_id              integer                       登录用户ID（其他引用表或为uid）
*                        user_name           string              *         登录用户名
*                        utype               integer             *         用户类型：1公司，2个人
*                        landline_tel        string              *         固定电话
*                        email               string              *         
*                        email_audit         integer             *         
*                        email_remind_time   integer             *         邮箱密码找回时间
*                        mobile              string              *         
*                        mobile_audit        integer             *         
*                        user_pwd            string              *         
*                        create_time         integer             *         
*                        update_time         integer             *         
*                        is_effect           integer             *         用户状态（0无效，1有效）
*                        login_ip            string              *         
*                        login_time          integer             *         
*                        password_verify     string              *         找回密码的验证号
*                        avatars             string              *         登录图像(存放路径）
*                        sector              string              *         用户初始注册的系统业务版块
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestAdd:(NSMutableDictionary *)params
                      OnCompletion:(void (^)(HaoResult *result))completionBlock
                           onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"pub_user/add" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 用户:更新
* @param  NSMutableDictionary * params  参数
*                        id                  int                 *         id
*                        pub_id              integer                       登录用户ID（其他引用表或为uid）
*                        user_name           string                        登录用户名
*                        utype               integer                       用户类型：1公司，2个人
*                        landline_tel        string                        固定电话
*                        email               string                        
*                        email_audit         integer                       
*                        email_remind_time   integer                       邮箱密码找回时间
*                        mobile              string                        
*                        mobile_audit        integer                       
*                        user_pwd            string                        
*                        create_time         integer                       
*                        update_time         integer                       
*                        is_effect           integer                       用户状态（0无效，1有效）
*                        login_ip            string                        
*                        login_time          integer                       
*                        password_verify     string                        找回密码的验证号
*                        avatars             string                        登录图像(存放路径）
*                        sector              string                        用户初始注册的系统业务版块
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestUpdate:(NSMutableDictionary *)params
                         OnCompletion:(void (^)(HaoResult *result))completionBlock
                              onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"pub_user/update" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 用户:列表
* @param  NSMutableDictionary * params  参数
*                        page                int                 *         分页，第一页为1，第二页为2，最后一页为-1
*                        size                int                 *         分页大小
*                        iscountall          bool                          是否统计总数 1是 0否
*                        order               string                        排序方式
*                        isreverse           int                           是否倒序 0否 1是
*                        ids                 string                        多个id用逗号隔开
*                        pub_id              integer                       登录用户ID（其他引用表或为uid）
*                        user_name           string                        登录用户名
*                        utype               integer                       用户类型：1公司，2个人
*                        landline_tel        string                        固定电话
*                        email               string                        
*                        email_audit         integer                       
*                        email_remind_time   integer                       邮箱密码找回时间
*                        mobile              string                        
*                        mobile_audit        integer                       
*                        user_pwd            string                        
*                        create_time         integer                       
*                        update_time         integer                       
*                        is_effect           integer                       用户状态（0无效，1有效）
*                        login_ip            string                        
*                        login_time          integer                       
*                        password_verify     string                        找回密码的验证号
*                        avatars             string                        登录图像(存放路径）
*                        sector              string                        用户初始注册的系统业务版块
*                        keyword             string                        检索关键字
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestList:(NSMutableDictionary *)params
                       OnCompletion:(void (^)(HaoResult *result))completionBlock
                            onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"pub_user/list" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 用户:详情
* @param  NSMutableDictionary * params  参数
*                        id                  int                 *         id
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestDetail:(NSMutableDictionary *)params
                         OnCompletion:(void (^)(HaoResult *result))completionBlock
                              onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"pub_user/detail" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 用户:我的信息
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestGetMyDetail:(NSMutableDictionary *)params
                              OnCompletion:(void (^)(HaoResult *result))completionBlock
                                   onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"pub_user/get_my_detail" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

@end