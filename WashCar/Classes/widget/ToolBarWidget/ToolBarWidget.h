//
//  ToolBarWidget.h
//  NaChe
//
//  Created by nachebang on 14-11-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RightBtnClickedBlock)();
typedef void(^LeftBtnClickedBlock)();
typedef void(^CenterBtnClickedBlock)();
@class ToolBarWidget;
#pragma mark 代理方法
@protocol ToolBarWidgetDelegate <NSObject>
@optional
-(void)toolbarLeftBtnClicked:(UIButton*)btnItem toolBar:(ToolBarWidget *)toolBar;
-(void)toolbarRightBtnClicked:(UIButton*)btnItem toolBar:(ToolBarWidget *)toolBar;
-(void)toolbarCenterBtnClicked:(UIButton*)btnItem toolBar:(ToolBarWidget *)toolBar;
@end

@interface ToolBarWidget : UIView
{
    NSString *leftTitle;//左边按钮的标题
    NSString *centerTitle;//中间按钮标题
    NSString *rightTitle;//右边按钮标题
    NSString *leftImage;//左边按钮的图片
    NSString *rightImage;//右边按钮图片
    NSString *centerImage;//中间按钮图片
    UIView *_toolBar;
    UIButton *_leftBtn;
    UIButton *_centerBtn;
    UIButton *_rightBtn;
}
@property(nonatomic,strong)NSString *leftTitle;
@property(nonatomic,strong)NSString *centerTitle;
@property(nonatomic,strong)NSString *rightTitle;
@property(nonatomic,strong)NSString *leftImage;
@property(nonatomic,strong)NSString *rightImage;
@property(nonatomic,strong)NSString *centerImage;
@property(nonatomic,strong)UIColor *bgColor;
@property(nonatomic,strong)UIColor *leftBtnColor;
@property(nonatomic,strong)UIColor *centerBtnColor;
@property(nonatomic,strong)UIColor *rightBtnColor;
@property(nonatomic,strong)UIFont *leftFont;
@property(nonatomic,strong)UIFont *centerFont;
@property(nonatomic,strong)UIFont *rightFont;
@property(nonatomic,weak)id<ToolBarWidgetDelegate>delegate;
@property(nonatomic,copy) RightBtnClickedBlock rightClickedCallBack;
@property(nonatomic,copy) LeftBtnClickedBlock leftClickedCallBack;
@property(nonatomic,copy) CenterBtnClickedBlock centerClickedCallBack;
@end