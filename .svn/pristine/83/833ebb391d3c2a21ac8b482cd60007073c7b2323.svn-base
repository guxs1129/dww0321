#import "HaoConnect.h"

@interface PubUserConnect : HaoConnect

/**     用户:查看表结构（限管理员）*/
+ (MKNetworkOperation *)requestColumns:(NSMutableDictionary *)params
             OnCompletion:(void (^)(HaoResult *result))completionBlock
                  onError:(void (^)( HaoResult * error))errorBlock;

/**     用户:新建*/
+ (MKNetworkOperation *)requestAdd:(NSMutableDictionary *)params
         OnCompletion:(void (^)(HaoResult *result))completionBlock
              onError:(void (^)( HaoResult * error))errorBlock;

/**     用户:更新*/
+ (MKNetworkOperation *)requestUpdate:(NSMutableDictionary *)params
            OnCompletion:(void (^)(HaoResult *result))completionBlock
                 onError:(void (^)( HaoResult * error))errorBlock;

/**     用户:列表*/
+ (MKNetworkOperation *)requestList:(NSMutableDictionary *)params
          OnCompletion:(void (^)(HaoResult *result))completionBlock
               onError:(void (^)( HaoResult * error))errorBlock;

/**     用户:详情*/
+ (MKNetworkOperation *)requestDetail:(NSMutableDictionary *)params
            OnCompletion:(void (^)(HaoResult *result))completionBlock
                 onError:(void (^)( HaoResult * error))errorBlock;

/**     用户:我的信息*/
+ (MKNetworkOperation *)requestGetMyDetail:(NSMutableDictionary *)params
                 OnCompletion:(void (^)(HaoResult *result))completionBlock
                      onError:(void (^)( HaoResult * error))errorBlock;


@end