#import "QiniuConnect.h"

@implementation QiniuConnect

/**
* 七牛:取得一个授权凭证用于直传文件给七牛 (推荐：步骤1）
* @param  NSMutableDictionary * params  参数
*                        md5                 string              *         文件的MD5值
*                        filesize            int                 *         文件大小
*                        filetype            string              *         文件后缀如jpg,png等
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestGetUploadTokenForQiniu:(NSMutableDictionary *)params
                                         OnCompletion:(void (^)(HaoResult *result))completionBlock
                                              onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"qiniu/getUploadTokenForQiniu" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 七牛:直传文件到七牛服务器 (推荐：步骤2）
* @param  NSMutableDictionary * params  参数
*                        token               string              *         来自服务器端的uploadToken数据
*                        file                file                *         本地文件（单个）
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestUploadQiniuCom:(NSMutableDictionary *)params
                                 OnCompletion:(void (^)(HaoResult *result))completionBlock
                                      onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"http://upload.qiniu.com" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 七牛:上传本地单个文件经服务器中转到七牛
* @param  NSMutableDictionary * params  参数
*                        file                file                *         本地文件（单个）
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestUploadSingleFile:(NSMutableDictionary *)params
                                   OnCompletion:(void (^)(HaoResult *result))completionBlock
                                        onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"qiniu/uploadSingleFile" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 七牛:上传本地多个文件经服务器中转到七牛
* @param  NSMutableDictionary * params  参数
*                        files[]             file                *         本地文件（单个）
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestUploadMultipleFiles:(NSMutableDictionary *)params
                                      OnCompletion:(void (^)(HaoResult *result))completionBlock
                                           onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"qiniu/uploadMultipleFiles" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 七牛:直接抓取网络资源到七牛
* @param  NSMutableDictionary * params  参数
*                        url                 string              *         目标资源文件网址
*                        filename            string                        保存到文件名，可以不传
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestFetchUrlToQiniu:(NSMutableDictionary *)params
                                  OnCompletion:(void (^)(HaoResult *result))completionBlock
                                       onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"qiniu/fetch_url_to_qiniu" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

@end