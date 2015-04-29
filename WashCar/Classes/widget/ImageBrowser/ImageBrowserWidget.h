//
//  ImageBrowserWidget.h
//  WashCar
//
//  Created by yanshengli on 15-1-4.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark 图片类型的枚举
typedef NS_ENUM(NSInteger,ImageBrowserPicType)
{
    ImageBrowserPicType_Local  = 0,//本地图片
    ImageBrowserPicType_Net  = 1,//网络图片
};


/***
 *
 *@description:图片浏览视图--接口
 *@since:2014-12-29
 *@author:liys
 *@corp:cheletong
 */
@interface ImageBrowserWidget : UIView

#pragma mark 需要展示的图片
@property (nonatomic,strong)NSArray *images;

#pragma mark 图片正在加载时显示的图片
@property (nonatomic,strong)NSArray *placeholderImages;

#pragma mark 图片类型
@property (nonatomic,assign)ImageBrowserPicType type;

#pragma mark 当前选中的图片
@property (nonatomic,assign)int selectedIndex;

@end
