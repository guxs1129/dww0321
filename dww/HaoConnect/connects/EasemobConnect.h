#import "HaoConnect.h"

@interface EasemobConnect : HaoConnect

/**     环信:我的环信账号*/
+ (MKNetworkOperation *)requestGetMyAuthInfo:(NSMutableDictionary *)params
                   OnCompletion:(void (^)(HaoResult *result))completionBlock
                        onError:(void (^)( HaoResult * error))errorBlock;

/**     环信:重置我的环信账号密码*/
+ (MKNetworkOperation *)requestResetMyAuthInfo:(NSMutableDictionary *)params
                     OnCompletion:(void (^)(HaoResult *result))completionBlock
                          onError:(void (^)( HaoResult * error))errorBlock;

/**     环信:发送消息给用户*/
+ (MKNetworkOperation *)requestPushMessage:(NSMutableDictionary *)params
                 OnCompletion:(void (^)(HaoResult *result))completionBlock
                      onError:(void (^)( HaoResult * error))errorBlock;

@end