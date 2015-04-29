//
//  ImageBrowserWidget.m
//  WashCar
//
//  Created by yanshengli on 15-1-4.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "ImageBrowserWidget.h"
#import "TapImageViewWidget.h"
#import "ImageCache.h"
#import "UIView+WashCarUtility.h"

#define tarViewBarHeight 40.f

@interface  ImageBrowserWidget()
<UIScrollViewDelegate,
TapImageViewWidgetDelegate>
{
    UIScrollView *_imageScrollView;
    UIPageControl *_imagePageControl;
    UIView *_tarBar;
    UIView *_bgView;
    UILabel *_pageInfoLabel;
}

@end

/***
 *
 *@description:图片浏览视图--实现
 *@since:2014-12-29
 *@author:liys
 *@corp:cheletong
 */
@implementation ImageBrowserWidget

#pragma mark 图片
@synthesize images;

#pragma mark 类型
@synthesize type;

#pragma mark 被选择的图片
@synthesize selectedIndex;

#pragma mark 图片正在加载时显示的图片
@synthesize placeholderImages;

-(void)drawRect:(CGRect)rect
{
    //重置子视图
    [self removeAllSubviews];
    
    //背景视图
    _bgView = [[UIView alloc ]initWithFrame:self.frame];
    _bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:_bgView];
    
    //图片对应的scrollView
    _imageScrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    _imageScrollView.contentSize = CGSizeMake(self.frame.size.width * images.count , self.frame.size.height);
    [self addSubview:_imageScrollView];
    //添加图片
    for (int index = 0; index < images.count; index ++)
    {
        CGFloat imageX = index * CGRectGetWidth(_imageScrollView.frame);
        CGFloat imageY = CGRectGetMinY(_imageScrollView.frame);
        CGFloat imageH = CGRectGetHeight(_imageScrollView.frame);
        CGFloat imageW = CGRectGetWidth(_imageScrollView.frame);
        CGRect  imageFrame = (CGRect){imageX,imageY,imageW,imageH};
        TapImageViewWidget *imageView = [[TapImageViewWidget alloc]initWithFrame:imageFrame];
        if (self.type == ImageBrowserPicType_Net)
        {
            [ImageCache loadImageWithUrl:[images objectAtIndex:index]
                               imageView:imageView
                        placeholderImage:[placeholderImages objectAtIndex:index]
                              cacheImage:NO];
        }
        else
        {
            imageView.image = [UIImage imageNamed:[images objectAtIndex:index]];
        }
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.delegate = self;
        [_imageScrollView addSubview:imageView];
 
    }
    _imageScrollView.contentOffset = CGPointMake(self.selectedIndex * _imageScrollView.frame.size.width , 0);
    
    //分页控件
    CGFloat pageX = 0.f;
    CGFloat pageH = 20.f;
    CGFloat pageY = self.frame.size.height - pageH - tarBarHeight;
    CGFloat pageW = self.frame.size.width;
    CGRect  pageFrame = (CGRect){pageX,pageY,pageW,pageH};
    _imagePageControl = [[UIPageControl alloc]initWithFrame:pageFrame];
    _imagePageControl.numberOfPages = images.count;
    _imagePageControl.hidesForSinglePage = YES;
    _imagePageControl.currentPage = self.selectedIndex;
    [_imagePageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_imagePageControl];
    
    //tarbar视图
    CGFloat tarBarX = 0.f;
    CGFloat tarBarH = tarBarHeight;
    CGFloat tarBarY = CGRectGetMaxY(_imagePageControl.frame);
    CGFloat tarBarW = self.frame.size.width;
    CGRect  tarBarFrame = (CGRect){tarBarX,tarBarY,tarBarW,tarBarH};
    _tarBar = [[UIView alloc]initWithFrame:tarBarFrame];
    [self addSubview:_tarBar];
    
    //图片信息
    _pageInfoLabel = [[UILabel alloc]initWithFrame:Rect(0.f, 0.f, _tarBar.frame.size.width, _tarBar.frame.size.height)];
    _pageInfoLabel.textAlignment = NSTextAlignmentCenter;
    _pageInfoLabel.font = [UIFont boldSystemFontOfSize:15];
    _pageInfoLabel.textColor = [UIColor whiteColor];
    [_tarBar addSubview:_pageInfoLabel];
    [self updatePageInfo];
    
}

#pragma mark 图片改变
-(void)pageControlChanged:(UIPageControl*)pageControl
{
    [UIView animateWithDuration:0.5 animations:^{
        _imageScrollView.contentOffset = CGPointMake(pageControl.currentPage * _imageScrollView.frame.size.width , 0);
        self.selectedIndex = pageControl.currentPage;
        [self updatePageInfo];
    }];
}

#pragma mark UIScrollViewDelegate代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _imageScrollView) {
        CGFloat xoffset = scrollView.contentOffset.x;
        CGFloat width = scrollView.frame.size.width;
        int currentPage = floor(xoffset/width);
        [UIView animateWithDuration:0.5 animations:^{
            _imagePageControl.currentPage = currentPage;
             self.selectedIndex = currentPage;
            [self updatePageInfo];
        }];
    }
}

#pragma mark 更新页码信息
-(void)updatePageInfo
{
    _pageInfoLabel.text = [NSString stringWithFormat:@"%i/%i",(self.selectedIndex+1),self.images.count];
}

#pragma mark TapImageViewWidgetDelegate代理方法
-(void)imageTap:(id)sender imageView:(UIImageView*)imageView
{
    __weak __block UIView *selfView = self;
    [UIView animateWithDuration:0.5 animations:^{
        [selfView removeFromSuperview];
        selfView = nil;
   }];
    
}
@end
