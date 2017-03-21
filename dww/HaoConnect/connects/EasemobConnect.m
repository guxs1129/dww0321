#import "EasemobConnect.h"

@implementation EasemobConnect

/**
* 环信:我的环信账号
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestGetMyAuthInfo:(NSMutableDictionary *)params
                                OnCompletion:(void (^)(HaoResult *result))completionBlock
                                     onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"easemob/get_my_auth_info" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 环信:重置我的环信账号密码
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestResetMyAuthInfo:(NSMutableDictionary *)params
                                  OnCompletion:(void (^)(HaoResult *result))completionBlock
                                       onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"easemob/reset_my_auth_info" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 环信:发送消息给用户
* @param  NSMutableDictionary * params  参数
*                        type                int                 *         1单人
*                        content             string              *         内容
*                        t                   id                            自定义类型 客户端用t取
*                        v                   string                        自定义值 客户端用v取
*                        userid              id                            用户ID
*                        telephone           string                        用户手机号
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestPushMessage:(NSMutableDictionary *)params
                              OnCompletion:(void (^)(HaoResult *result))completionBlock
                                   onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"easemob/push_message" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

@end