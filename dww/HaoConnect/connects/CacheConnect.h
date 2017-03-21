#import "HaoConnect.h"

@interface CacheConnect : HaoConnect

/**     缓存:缓存服务器状态（限管理员）*/
+ (MKNetworkOperation *)requestInfo:(NSMutableDictionary *)params
          OnCompletion:(void (^)(HaoResult *result))completionBlock
               onError:(void (^)( HaoResult * error))errorBlock;

/**     缓存:清空所有缓存（限管理员）*/
+ (MKNetworkOperation *)requestEmptyCache:(NSMutableDictionary *)params
                OnCompletion:(void (^)(HaoResult *result))completionBlock
                     onError:(void (^)( HaoResult * error))errorBlock;

/**     缓存:重置统计功能（限管理员）*/
+ (MKNetworkOperation *)requestResetStat:(NSMutableDictionary *)params
               OnCompletion:(void (^)(HaoResult *result))completionBlock
                    onError:(void (^)( HaoResult * error))errorBlock;

@end