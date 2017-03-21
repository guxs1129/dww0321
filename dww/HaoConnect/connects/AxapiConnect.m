#import "AxapiConnect.h"

@implementation AxapiConnect

/**
* 接口工具:Say Hello
* @param  NSMutableDictionary * params  参数
*                        name                string                        name
*                        password            md5                           password
*                        avatar              file                          avatar
*                        photos[]            file                          avatar
*                        age                 int                           age
*                        content             string                        content
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestSayHello:(NSMutableDictionary *)params
                           OnCompletion:(void (^)(HaoResult *result))completionBlock
                                onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/SayHello" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 接口工具:测试首页数据
* @param  NSMutableDictionary * params  参数
*                        sleep               int                           延迟时间（单位：秒）
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestGetHomeTableForTest:(NSMutableDictionary *)params
                                      OnCompletion:(void (^)(HaoResult *result))completionBlock
                                           onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/get_home_table_for_test" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 接口工具:查看日志（限管理员）
* @param  NSMutableDictionary * params  参数
*                        page                int                 *         分页，第一页为1，第二页为2，最后一页为-1
*                        size                int                 *         分页大小
*                        type                string              *         日志类型
*                        datetime            datetime                      指定日志所在日期（默认当日）
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestLoadLogList:(NSMutableDictionary *)params
                              OnCompletion:(void (^)(HaoResult *result))completionBlock
                                   onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/LoadLogList" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 接口工具:MHC代码文件快速生成（限管理员）
* @param  NSMutableDictionary * params  参数
*                        -t                  string              *         表名
*                        -name               string                        接口分类（中文）如：用户、设备、留言
*                        -pri                string                        默认取PRI且auto_increment的字段。若取不到，则可以在此处填一个字段，否则就是空了哦
*                        -rm                 string                        是否删除代码文件
*                        -update             string                        是否更新代码文件
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestCreateMhcWithTableName:(NSMutableDictionary *)params
                                         OnCompletion:(void (^)(HaoResult *result))completionBlock
                                              onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/create_mhc_with_table_name" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 接口工具:HaoConnect代码文件快速生成（限管理员）
* @param  NSMutableDictionary * params  参数
*                        -clear              string                        是否先清理代码文件再重新生成
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestUpdateCodesOfHaoConnect:(NSMutableDictionary *)params
                                          OnCompletion:(void (^)(HaoResult *result))completionBlock
                                               onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/update_codes_of_hao_connect" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 接口工具:获得Model对应字段的描述
* @param  NSMutableDictionary * params  参数
*                        model_name          string              *         model名
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestGetDescriptionsInModel:(NSMutableDictionary *)params
                                         OnCompletion:(void (^)(HaoResult *result))completionBlock
                                              onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/get_descriptions_in_model" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 接口工具:获得一个验证码图像
* @param  NSMutableDictionary * params  参数
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestGetCaptcha:(NSMutableDictionary *)params
                             OnCompletion:(void (^)(HaoResult *result))completionBlock
                                  onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/get_captcha" params:params httpMethod:METHOD_GET onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

/**
* 接口工具:确认图像验证码是否正确
* @param  NSMutableDictionary * params  参数
*                        captcha_key         string              *         验证码对应的key
*                        captcha_code        string              *         验证码
* @param completionBlock(HaoResult *result)   请求成功
* @param      errorBlock(HaoResult *error)         请求失败
*/
+ (MKNetworkOperation *)requestCheckCaptcha:(NSMutableDictionary *)params
                               OnCompletion:(void (^)(HaoResult *result))completionBlock
                                    onError:(void (^)( HaoResult *error))errorBlock
{

    return [self request:@"axapi/check_captcha" params:params httpMethod:METHOD_POST onCompletion:^(HaoResult *result) {
        completionBlock(result);
    } onError:^(HaoResult *error) {
        errorBlock(error);
    }];
}

@end