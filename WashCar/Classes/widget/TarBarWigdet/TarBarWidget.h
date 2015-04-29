//
//  TarBarWidget.h
//  NaChe
//
//  Created by yanshengli on 14-11-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TarBarWidget : UIView{
    NSArray *_tarBarTitles;
    NSArray *_contentViews;
    UIEdgeInsets _indicatorInsets;
    NSInteger _selectedIndex;
    UIColor *_tarBarBgColor;
    UIColor *_seperatorColor;
    UIColor *_indicatorBgColor;
    CGFloat _indicatorLineHeight;
    UIColor *_tarBarItemTextColor;
}
@property (nonatomic,strong)NSArray *contentViews;
@property (nonatomic,strong)NSArray *tarBarTitles;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,assign)UIEdgeInsets indicatorInsets;
@property (nonatomic,strong)UIColor *tarBarBgColor;
@property (nonatomic,strong)UIColor *seperatorColor;
@property (nonatomic,strong)UIColor *indicatorBgColor;
@property (nonatomic,assign)CGFloat indicatorLineHeight;
@property (nonatomic,strong)UIColor *tarBarItemTextColor;

@end
