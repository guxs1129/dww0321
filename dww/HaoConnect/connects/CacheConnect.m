#import "CacheConnect.h"

@implementation CacheConnect

/**
* 缓存:缓存服务器状态（限管理员）
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestInfo:(NSMutableDictionary *)params
                       OnCompletion:(void (^)(HaoResult *result))completionBlock
                            onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"cache/info" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 缓存:清空所有缓存（限管理员）
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestEmptyCache:(NSMutableDictionary *)params
                             OnCompletion:(void (^)(HaoResult *result))completionBlock
                                  onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"cache/empty_cache" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 缓存:重置统计功能（限管理员）
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestResetStat:(NSMutableDictionary *)params
                            OnCompletion:(void (^)(HaoResult *result))completionBlock
                                 onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"cache/reset_stat" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

@end