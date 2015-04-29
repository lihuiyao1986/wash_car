//
//  ColorPickViewWidget.h
//  WashCar
//
//  Created by yanshengli on 15-1-6.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark ColorPickViewWidget代理
@protocol ColorPickViewWidgetDelegate <NSObject>

@optional
#pragma mark 点击取消按钮
-(void)colorPickViewCancelBtnClicked:(UIButton*)cancelBtn;

#pragma mark 确认按钮被点击
-(void)colorPickViewConfirmBtnClicked:(UIButton*)confirmBtn color:(NSString*)selectedColor;

@end

/***
 *
 *@description:选择颜色的pickview--接口
 *@author:liys
 *@since:2014-1-6
 *@corp:cheletong
 */
@interface ColorPickViewWidget : UIView
{
    //tableview
    UITableView *_colorTV;
    //颜色
    NSArray *_colors;
    //toolBar按钮
    UIView *_toolBar;
    //提示文字
    UILabel *_titlelb;
    //取消按钮
    UIButton *_cancelBtn;
    //确认按钮
    UIButton *_confirmBtn;
    //选中颜色
    NSString *_selectedItem;
}

#pragma mark 颜色数组
@property (nonatomic,strong)NSArray *colors;

#pragma mark 选中的颜色
@property (nonatomic,copy)NSString *selectedColor;

#pragma mark 标题
@property (nonatomic,copy)NSString *title;

#pragma mark 取消按钮的标题
@property (nonatomic,copy)NSString *cancelBtnTitle;

#pragma mark 确认按钮标题
@property (nonatomic,copy)NSString *confirmBtnTitle;

#pragma mark 代理属性
@property (nonatomic,weak)id<ColorPickViewWidgetDelegate> delegate;

@end
