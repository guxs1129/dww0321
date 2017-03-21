#import "HaoConnect.h"

@interface QiniuConnect : HaoConnect

/**     七牛:取得一个授权凭证用于直传文件给七牛 (推荐：步骤1）*/
+ (MKNetworkOperation *)requestGetUploadTokenForQiniu:(NSMutableDictionary *)params
                            OnCompletion:(void (^)(HaoResult *result))completionBlock
                                 onError:(void (^)( HaoResult * error))errorBlock;

/**     七牛:直传文件到七牛服务器 (推荐：步骤2）*/
+ (MKNetworkOperation *)requestUploadQiniuCom:(NSMutableDictionary *)params
                    OnCompletion:(void (^)(HaoResult *result))completionBlock
                         onError:(void (^)( HaoResult * error))errorBlock;

/**     七牛:上传本地单个文件经服务器中转到七牛*/
+ (MKNetworkOperation *)requestUploadSingleFile:(NSMutableDictionary *)params
                      OnCompletion:(void (^)(HaoResult *result))completionBlock
                           onError:(void (^)( HaoResult * error))errorBlock;

/**     七牛:上传本地多个文件经服务器中转到七牛*/
+ (MKNetworkOperation *)requestUploadMultipleFiles:(NSMutableDictionary *)params
                         OnCompletion:(void (^)(HaoResult *result))completionBlock
                              onError:(void (^)( HaoResult * error))errorBlock;

/**     七牛:直接抓取网络资源到七牛*/
+ (MKNetworkOperation *)requestFetchUrlToQiniu:(NSMutableDictionary *)params
                     OnCompletion:(void (^)(HaoResult *result))completionBlock
                          onError:(void (^)( HaoResult * error))errorBlock;

@end