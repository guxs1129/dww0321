#import "HaoConnect.h"

@interface AxapiConnect : HaoConnect

/**     接口工具:Say Hello*/
+ (MKNetworkOperation *)requestSayHello:(NSMutableDictionary *)params
              OnCompletion:(void (^)(HaoResult *result))completionBlock
                   onError:(void (^)( HaoResult * error))errorBlock;

/**     接口工具:测试首页数据*/
+ (MKNetworkOperation *)requestGetHomeTableForTest:(NSMutableDictionary *)params
                         OnCompletion:(void (^)(HaoResult *result))completionBlock
                              onError:(void (^)( HaoResult * error))errorBlock;

/**     接口工具:查看日志（限管理员）*/
+ (MKNetworkOperation *)requestLoadLogList:(NSMutableDictionary *)params
                 OnCompletion:(void (^)(HaoResult *result))completionBlock
                      onError:(void (^)( HaoResult * error))errorBlock;

/**     接口工具:MHC代码文件快速生成（限管理员）*/
+ (MKNetworkOperation *)requestCreateMhcWithTableName:(NSMutableDictionary *)params
                            OnCompletion:(void (^)(HaoResult *result))completionBlock
                                 onError:(void (^)( HaoResult * error))errorBlock;

/**     接口工具:HaoConnect代码文件快速生成（限管理员）*/
+ (MKNetworkOperation *)requestUpdateCodesOfHaoConnect:(NSMutableDictionary *)params
                             OnCompletion:(void (^)(HaoResult *result))completionBlock
                                  onError:(void (^)( HaoResult * error))errorBlock;

/**     接口工具:获得Model对应字段的描述*/
+ (MKNetworkOperation *)requestGetDescriptionsInModel:(NSMutableDictionary *)params
                            OnCompletion:(void (^)(HaoResult *result))completionBlock
                                 onError:(void (^)( HaoResult * error))errorBlock;

/**     接口工具:获得一个验证码图像*/
+ (MKNetworkOperation *)requestGetCaptcha:(NSMutableDictionary *)params
                OnCompletion:(void (^)(HaoResult *result))completionBlock
                     onError:(void (^)( HaoResult * error))errorBlock;

/**     接口工具:确认图像验证码是否正确*/
+ (MKNetworkOperation *)requestCheckCaptcha:(NSMutableDictionary *)params
                  OnCompletion:(void (^)(HaoResult *result))completionBlock
                       onError:(void (^)( HaoResult * error))errorBlock;

@end