//
//  CustBgViewWidget.m
//  WashCar
//
//  Created by yanshengli on 15-1-7.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "CustBgViewWidget.h"
#import "UIView+WashCarUtility.h"

//圆角半径
#define custBgViewCornerRadius 2.f
//背景颜色
#define bgViewColor RGB_TextColor_C0
//背景的阴影颜色
#define bgViewShadowColor hexColor(0x878787,1.0).CGColor
//背景的阴影偏移量
#define bgViewShadowOffset CGSizeMake(0.f,1.f)
//背景的阴影的透明度
#define bgViewShadowOpacity 0.1
//背景的阴影半径
#define bgViewShadowRadius 0.5f


/***
 *
 *@description:自定义的背景视图--实现
 *@author:liys
 *@since:2014-1-7
 *@corp:cheletong
 */
@implementation CustBgViewWidget

#pragma mark 初始化方法-1
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //设置背景颜色
        self.layer.cornerRadius = custBgViewCornerRadius;
        self.backgroundColor = DEFAULT_BG_COLOR;
        //添加背景视图
        UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
        bgView.backgroundColor = bgViewColor;
        bgView.layer.cornerRadius = custBgViewCornerRadius;
        bgView.layer.shadowColor = bgViewShadowColor;
        bgView.layer.shadowOffset = bgViewShadowOffset;
        bgView.layer.shadowOpacity = bgViewShadowOpacity;
        bgView.layer.shadowRadius = bgViewShadowRadius;
        [self addSubview:bgView];
        [self sendSubviewToBack:bgView];
    }
    return self;
}

#pragma mark 初始化方法-2
- (instancetype)initWithFrame:(CGRect)frame shadowOpacity:(CGFloat)shadowOpacity shadowColor:(long)shadowColor shadowRadius:(CGFloat)shadowRadius bgColor:(long)bgColor cornerRadius:(CGFloat)cornerRadius shadowYOffset:(CGFloat)shadowYOffset shadowXOffset:(CGFloat)shadowXOffset
{
    return [self initWithFrame:frame
                 shadowOpacity:shadowOpacity
                   shadowColor:shadowColor
                  shadowRadius:shadowRadius
                       bgColor:bgColor
                  bgColorAlpha:1.0
                  cornerRadius:cornerRadius
                 shadowYOffset:shadowYOffset
                 shadowXOffset:shadowXOffset];
    
}

#pragma mark 初始化方法-3
- (instancetype)initWithFrame:(CGRect)frame shadowOpacity:(CGFloat)shadowOpacity shadowColor:(long)shadowColor shadowRadius:(CGFloat)shadowRadius bgColor:(long)bgColor bgColorAlpha:(CGFloat)bgColorAlpha cornerRadius:(CGFloat)cornerRadius shadowYOffset:(CGFloat)shadowYOffset shadowXOffset:(CGFloat)shadowXOffset
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //设置背景颜色和圆角半径
        self.layer.cornerRadius = cornerRadius;
        self.backgroundColor = DEFAULT_BG_COLOR;
        
        //添加背景视图
        UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
        if (bgColor <= 0)
        {
            bgColor = 0xffffff;
        }
        
        //背景色
        bgView.backgroundColor = hexColor(bgColor, bgColorAlpha);
        
        //圆角半径
        bgView.layer.cornerRadius = cornerRadius;
        if (shadowColor <= 0)
        {
            bgView.layer.shadowColor = bgViewShadowColor;
        }
        else
        {
            bgView.layer.shadowColor = hexColor(shadowColor, 1.0).CGColor;
        }
        
        //阴影偏移量
        bgView.layer.shadowOffset = CGSizeMake(shadowXOffset, shadowYOffset);
        
        //阴影透明度
        bgView.layer.shadowOpacity = shadowOpacity;
        
        //阴影阴影半径
        bgView.layer.shadowRadius = shadowRadius;
        
        //加入到视图中
        [self addSubview:bgView];
        //[self sendSubviewToBack:bgView];
    }
    return self;
}

@end
