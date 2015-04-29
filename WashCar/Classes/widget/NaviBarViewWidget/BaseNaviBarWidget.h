//
//  BaseNaviBarWidget.h
//  NaChe
//
//  Created by yanshengli on 14-12-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseNaviBarWidgetDelegate <NSObject>
@optional
-(void)leftNavBarBtnClicked:(UIButton *)leftNavBarBtn;
-(void)centerNavBarBtnClicked:(UIButton *)centerNavBarBtn;
-(void)rightNavBarBtnClicked:(UIButton *)rightNavBarBtn;
@end
/**
 *
 *导航栏对应的基类
 */
@interface BaseNaviBarWidget : UIView

@end
