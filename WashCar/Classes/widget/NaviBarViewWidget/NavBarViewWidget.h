//
//  NavBarViewWidget.h
//  NaChe
//
//  Created by nachebang on 14-11-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNaviBarWidget.h"

@protocol NavBarViewWidgetDelegate <BaseNaviBarWidgetDelegate>
@end

@interface NavBarViewWidget : BaseNaviBarWidget{
    
    UIColor *bgcolor;//背景颜色
    UIImage *bgImage;//背景图片
    
    UIImage *leftIcon;//左边图标
    UIImage *centerIcon;//中间图标
    UIImage *rightIcon;//右边图标
    
    NSString *leftTitle;//左边标题
    NSString *centerTitle;//中间标题
    NSString *rightTitle;//右边标题
    
    UIView *_leftView;//左边视图
    UIView *_rightView;//右边视图
    UIView *_centerView;//中间视图
    
    UIImageView *_leftIconImg;
    UILabel *_leftLabel;
    
    UIImageView *_centerIconImg;
    UILabel *_centerLabel;
    
    UIImageView *_rightIconImg;
    UILabel *_rightLabel;
}

@property(nonatomic,strong)UIColor *bgcolor;
@property(nonatomic,strong)UIImage *bgImage;

@property(nonatomic,strong)UIImage *leftIcon;
@property(nonatomic,strong)UIImage *centerIcon;
@property(nonatomic,strong)UIImage *rightIcon;

@property(nonatomic,strong)NSString *leftTitle;
@property(nonatomic,strong)NSString *centerTitle;
@property(nonatomic,strong)NSString *rightTitle;

@property(nonatomic,strong)UIColor *leftTitleColor;
@property(nonatomic,strong)UIColor *centerTitleColor;
@property(nonatomic,strong)UIColor *rightTitleColor;

@property(nonatomic,strong)UIFont *leftTitleFont;
@property(nonatomic,strong)UIFont *centerTitleFont;
@property(nonatomic,strong)UIFont *rightTitleFont;

@property(nonatomic,assign)id<NavBarViewWidgetDelegate> delegate;

- (id)init;

-(id)initWithLeftTitle:(NSString*)newLeftTitle andLeftIcon:(UIImage*)newLeftIcon;

-(id)initWithLeftTitle:(NSString*)newLeftTitle andLeftIcon:(UIImage*)newLeftIcon andRightIcon:(UIImage *)newRightIcon andRightTitle:(NSString *)newRightTitle;

- (id)initWithLeftIcon:(UIImage *)newLeftIcon andLeftTitle:(NSString *)newLeftTitle andCenterTitle:(NSString*)newCenterTitle andCenterIcon:(UIImage *)newCenterIcon andRightIcon:(UIImage *)newRightIcon andRightTitle:(NSString *)newRightTitle andBgcolor:(UIColor *)newBgcolor andBgImage:(UIImage *)newBgImage;

@end
