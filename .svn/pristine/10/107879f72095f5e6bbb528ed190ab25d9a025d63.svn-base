//
//  IndexNavBarWidget.h
//  WashCar
//
//  Created by yanshengli on 15-1-13.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseNaviBarWidget.h"

#pragma mark IndexNavBarWidgetDelegate协议
@protocol  IndexNavBarWidgetDelegate<BaseNaviBarWidgetDelegate>

@optional
#pragma mark 位置label被tap
-(void)locationLabelTap;

@end

/**
 *
 *@description:首页导航栏--接口
 @author:liys
 *@since 2014-1-13
 *
 */
@interface IndexNavBarWidget : BaseNaviBarWidget

#pragma mark 代理
@property(nonatomic,weak)id<IndexNavBarWidgetDelegate>delegate;

#pragma mark 地理位置信息
@property(nonatomic,copy)NSString *addressInfo;

@property(nonatomic,copy)UILabel *addresslb;

-(void)updateInfo:(NSString*)newInfo;

@end
