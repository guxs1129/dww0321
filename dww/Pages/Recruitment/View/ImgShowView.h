//
//  ImgShowView.h
//  canzhaopin
//
//  Created by lianghuigui on 16/3/28.
//  Copyright © 2016年 lianghuigui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgShowView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView * iMgView;
@property(nonatomic,strong)NSString * imgUrlStr;
-(void)loadImgView;
@end
