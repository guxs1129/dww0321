//
//  PhotoShowViewController.m
//  canzhaopin
//
//  Created by lianghuigui on 16/3/17.
//  Copyright © 2016年 lianghuigui. All rights reserved.
//

#import "PhotoShowViewController.h"
#import <UIImageView+WebCache.h>
#import "ImgShowView.h"
#import "UITextView+Custom.h"
#import <Masonry.h>
@interface PhotoShowViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)NSMutableArray * contentArray;
@property(nonatomic,strong)UIPageControl * control;
@property(nonatomic,strong)NSMutableArray<UIScrollView *> * cgfolagData;
@property(nonatomic) CGFloat bottomViewY;

@end

@implementation PhotoShowViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.contentArray = [[NSMutableArray alloc] init];
        self.cgfolagData = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenSizeWidth-100)/2, 30, 100, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"作品描述";
    [self.view addSubview:titleLabel];

//    self.navigationItem.leftBarButtonItem = [self customBackItemWithTarget:self action:@selector(clickLeft)];
    self.view.backgroundColor = [UIColor blackColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 20, ScreenSizeWidth, ScreenSizeHeight-65-CGRectGetMaxY(titleLabel.frame) - 20)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize=CGSizeMake(CGRectGetWidth(self.scrollView.frame)*[self.dataArray count], CGRectGetHeight(self.scrollView.frame));
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.control = [[UIPageControl alloc] initWithFrame:CGRectMake((ScreenSizeWidth-100)/2, (ScreenSizeHeight-30), 100, 20)];
    self.control.numberOfPages = self.dataArray.count;
    self.control.currentPage = _bundleIndex;
    [self.view addSubview:_control];

    
    __weak typeof(self) weakSelf = self;

    for (int i=0; i < [self.dataArray count]; i++) {
        NSDictionary * item  = self.dataArray[i];
        NSString * imgurl = NSValueToString([item objectForKey:@"showImg"]);
        NSString * description = NSValueToString([item objectForKey:@"note"]);
        [self.contentArray addObject:description];
        
        UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(ScreenSizeWidth * i, 0, ScreenSizeWidth, CGRectGetHeight(self.scrollView.frame))];
        contentScrollView.tag = 1009;
        contentScrollView.delegate = self;
        UIImageView * photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenSizeWidth, CGRectGetHeight(self.scrollView.frame)-270)];
        photoView.contentMode = UIViewContentModeScaleAspectFit;
        [contentScrollView addSubview:photoView];
        
        [weakSelf.cgfolagData addObject:contentScrollView];
        [self createBottomViewWithData:item inView:contentScrollView];
        photoView.userInteractionEnabled = YES;
        [photoView sd_setImageWithURL:[NSURL URLWithString:imgurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!image) {
                return;
            }
            CGFloat img_width = photoView.image.size.width;
            CGFloat img_height = photoView.image.size.height/img_width*ScreenSizeWidth;

            CGRect recr = photoView.frame;
            recr.size.height = img_height;
            photoView.frame = recr;
            if (self.bundleIndex == i) {
                contentScrollView.contentSize = CGSizeMake(0, img_height);
                
                self.scrollView.contentOffset=CGPointMake(_bundleIndex*CGRectGetWidth(self.scrollView.frame), 0);
            }
            if (img_height <= self.scrollView.frame.size.height - 120) {
                photoView.frame = CGRectMake(photoView.frame.origin.x, (self.scrollView.frame.size.height - 120 - img_height) / 2, photoView.frame.size.width, photoView.frame.size.height);
            }
        }];
        
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBackToPreview)]];
        [self.scrollView addSubview:contentScrollView];

        
//        ImgShowView * photoView = [[ImgShowView alloc] initWithFrame:CGRectMake(ScreenSizeWidth * i, 0, ScreenSizeWidth, CGRectGetHeight(self.scrollView.frame))];
//        photoView.imgUrlStr = imgurl;
//        [photoView loadImgView];
//        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBackToPreview)]];
//        [self.scrollView addSubview:photoView];
        
    }
   
//    CGFloat  imgH = [self.cgfolagData[_bundleIndex] floatValue];
//    if (imgH <= 0) {
//        imgH = ScreenSizeHeight - 320;
//    }
    
    
}

- (void)createBottomViewWithData:(NSDictionary *)data inView:(UIView *)view
{
    CGFloat bgViewHeight = 120;
    CGFloat bgViewBottomInset = 0;
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - bgViewHeight - bgViewBottomInset, CGRectGetWidth(view.frame), bgViewHeight)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    bgView.tag = 2009;
    self.bottomViewY = bgView.frame.origin.y;
    [view addSubview:bgView];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, bgView.frame.size.height - 78, CGRectGetWidth(view.frame)-40, 78)];

    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor colorWithHexString:@"0xb3b3b3"];
    textView.text = NSValueToString(data[@"note"]);
    [textView setLineSpacing:5 text:textView.text];
    textView.editable = NO;
    [bgView addSubview:textView];
 
    UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, ScreenSizeWidth - 23 *2, 20)];
    labelText.textColor = [UIColor whiteColor];
    labelText.font = [UIFont systemFontOfSize:16];
    labelText.text = NSValueToString(data[@"title"]);
    [bgView addSubview:labelText];

}
//-(void)clickLeft{
//
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}
/*
#pragma mark--UIImgShowDelegate
-(void)imgshowCLick{
    if (self.bgView.isHidden) {
        self.bgView.hidden = NO;
        [UIView animateWithDuration:0.1f animations:^{
            CGRect rect = self.bgView.frame;
            rect.origin.y = CGRectGetHeight(self.scrollView.frame)-120;
            self.bgView.frame=rect;
        }];
        return;
    }else{
        
        [UIView animateWithDuration:0.1f animations:^{
            CGRect rect = self.bgView.frame;
            rect.origin.y = CGRectGetHeight(self.scrollView.frame);
            self.bgView.frame=rect;
        } completion:^(BOOL finished) {
            self.bgView.hidden = YES;
        }];
        
    }

}
*/
-(void)goBackToPreview{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index =_scrollView.contentOffset.x/ScreenSizeWidth + 1;
    if (scrollView==_scrollView) {

        if (index>0&& index<=self.dataArray.count) {
            self.control.currentPage = index -1;
            if (index - 1 < self.cgfolagData.count) {
                CGFloat  imgH = self.cgfolagData[index-1].subviews.firstObject.frame.size.height;
                
                //            [UIView animateWithDuration:0.2f animations:^{
                //                CGRect recr = self.bgView.frame;
                //                if (imgH+200+120 <ScreenSizeHeight) {
                //                    recr.origin.y = imgH+200;
                //                }else{
                //                    recr.origin.y = ScreenSizeHeight-120;
                //                }
                //                self.bgView.frame = recr;
                //            }];
                self.cgfolagData[index-1].contentSize = CGSizeMake(0, imgH);
            }
            
            
        }
    } else if ([self.cgfolagData[index - 1] viewWithTag:1009] == scrollView)
    {
        UIView *bgView = [[self.cgfolagData[index - 1] viewWithTag:1009] viewWithTag:2009];
        CGRect frame = bgView.frame;
        frame.origin.y = scrollView.contentOffset.y + self.bottomViewY;
        bgView.frame = frame;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
