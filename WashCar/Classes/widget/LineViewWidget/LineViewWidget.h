//
//  LineViewWidget.h
//  WashCar
//
//  Created by yanshengli on 15-1-8.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import <UIKit/UIKit.h>


/***
 *
 *@description:划线视图--接口
 *@author:liys
 *@since:2014-1-7
 *@corp:cheletong
 */
@interface LineViewWidget : UIView

#pragma mark 线的16进制颜色
@property (nonatomic,assign)long lineColor;

#pragma mark 线的宽度
@property (nonatomic,assign)int lineWidth;

#pragma mark 线的高度
@property (nonatomic,assign)int lineHeight;

#pragma mark线的透明度
@property (nonatomic,assign)CGFloat lineAlpha;

#pragma mark 距离父视图的x方向的偏移
@property (nonatomic,assign)CGFloat xOffset;

#pragma mark 距离父视图的y方向的偏移
@property (nonatomic,assign)CGFloat yOffset;

#pragma mark 初始化方法
- (id)initWithXoffset:(CGFloat)nXOffset yOffset:(CGFloat)nYOffset lineHeight:(CGFloat)nLineHeight lineWidth:(CGFloat)nLineWidth lineColor:(long)nLineColor lineAlpha:(CGFloat)nLineAlpha;

@end
