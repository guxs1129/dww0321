//
//  UIViewController+Share.m
//  dww
//
//  Created by Shadow. G on 2017/1/18.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "UIViewController+Share.h"

@implementation UIViewController (Share)

// 快速分享
- (void)snsSocialWithText:(NSString *)text url:(NSString *)url imageUrl:(NSString *)imageUrl
{
    NSMutableArray *apps = [NSMutableArray array];
    NSString *shareText  = [NSString stringWithFormat:@"%@", text];
    
    //    [UMSocialData defaultData].urlResource = resource;
    //设置微信AppId，设置分享url，默认使用友盟的网址  801555504  moren:wxd930ea5d5a258f4f
    [UMSocialWechatHandler setWXAppId:WXAPPID appSecret:WXAPPSECRECT url:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //设置分享到QQ空间的应用Id，和分享url 链接  demo:appid-100424468  c7394704798a158208a74ab60104f0ba
    [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKEY url:url];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@ ( %@ )", text, url];
    
    if ([QQApiInterface isQQInstalled])
    {
        [apps addObject:UMShareToQQ];
        [apps addObject:UMShareToQzone];
        //        [UMSocialData defaultData].extConfig.qqData.url = self.currentURL;
        //                [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageNamed:@"180X180@2x.png"];
        //                [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        
    }
    
    if ([WXApi isWXAppInstalled])
    {
        [apps addObject:UMShareToWechatSession];
        [apps addObject:UMShareToWechatTimeline];
        
    }
    
    UIImage *shareImage = nil;
    if (imageUrl && imageUrl.length > 0) {
        shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    }
    if (!shareImage) {
        shareImage = [UIImage imageNamed:@"logo_60@3x.png"];
    }
    
    [apps addObject:UMShareToSina];
    //    [apps addObject:UMShareToTencent];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENGSDKKEY
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:apps
                                       delegate:self];
    
}

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didClose is %d",fromViewControllerType);
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
//        [MBProgressHUD showSuccess:@"分享成功" ToView:nil];
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}



// 自定义分享
- (void)customShareWithText:(NSString *)text imageUrl:(NSString *)imageUrl title:(NSString *)title clickUrl:(NSString *)clickUrl shareToSnsName:(NSString *)snsName
{
    
    UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    if ([snsName isEqualToString:UMShareToQQ]) {
        
        [UMSocialData defaultData].extConfig.qqData.title = title;
        [UMSocialData defaultData].extConfig.qqData.url = clickUrl;
        //        [UMSocialData defaultData].extConfig.qqData.urlResource = resource;
        
    } else if ([snsName isEqualToString:UMShareToQzone])
    {
        [UMSocialData defaultData].extConfig.qzoneData.title = title;
        [UMSocialData defaultData].extConfig.qzoneData.url = clickUrl;
        //        [UMSocialData defaultData].extConfig.qzoneData.urlResource = resource;
    }
    else if ([snsName isEqualToString:UMShareToWechatSession])
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = clickUrl;
        //        [UMSocialData defaultData].extConfig.wechatSessionData.urlResource = resource;
        
    } else if ([snsName isEqualToString:UMShareToWechatTimeline])
    {
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        //        [UMSocialData defaultData].extConfig.wechatTimelineData.urlResource = resource;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = clickUrl;
    } else if ([snsName isEqualToString:UMShareToSina])
    {
        [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@\n\r%@ ( %@ )", title, text, clickUrl];
        //        [UMSocialData defaultData].extConfig.sinaData.urlResource = resource;
    }
    
    
    if ([NSValueToString(imageUrl) length] > 0) {
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[snsName] content:text image:[UIImage imageNamed:@"logo_60@3x.png"] location:nil urlResource:resource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                
            }
        }];
        
    } else
    {
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[snsName] content:text image:[UIImage imageNamed:@"logo_60@3x.png"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                
            }
        }];
        
    }
    
}


@end
