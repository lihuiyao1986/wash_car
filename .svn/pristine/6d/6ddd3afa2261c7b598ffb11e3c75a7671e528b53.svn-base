//
//  AreaPickWidget.h
//  NaChe
//
//  Created by nachebang on 14-11-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AreaPickWidgetDelegate<NSObject>
@optional
- (void) leftBtnClicked:(UIBarButtonItem *)leftBtn province:(NSString*)province city:(NSString *)city area:(NSString *)area;
- (void) centerBtnClicked:(UIBarButtonItem *)centerBtn province:(NSString*)province city:(NSString *)city area:(NSString *)area;
- (void) rightBtnClicked:(UIBarButtonItem *)rightBtn province:(NSString*)province city:(NSString *)city area:(NSString *)area;
- (void) didSelectedProvince:(NSString*)province city:(NSString *)city area:(NSString *)area;
@end

@interface AreaPickWidget : UIView{
    NSArray *_items;
    UIPickerView *_pickView;
    NSString *leftTitle;//左边按钮的标题
    NSString *centerTitle;//中间按钮标题
    NSString *rightTitle;//右边按钮标题
    NSString *leftImage;//左边按钮的图片
    NSString *rightImage;//右边按钮图片
    NSString *centerImage;//中间按钮图片
    UIBarButtonItem *_leftBtn;
    UIBarButtonItem *_centerBtn;
    UIBarButtonItem *_rightBtn;
    NSArray *_provinces, *_cities, *_areas;
    NSInteger _provinceSelectedIndex,_citySelectedIndex,_areaSelectedIndex;
}
@property(nonatomic,strong)NSString *leftTitle;
@property(nonatomic,strong)NSString *centerTitle;
@property(nonatomic,strong)NSString *rightTitle;
@property(nonatomic,strong)NSString *leftImage;
@property(nonatomic,strong)NSString *rightImage;
@property(nonatomic,strong)NSString *centerImage;
@property(nonatomic,assign)id<AreaPickWidgetDelegate> delegate;
- (id)init;
- (id)initLeftTitle:(NSString *) newLeftTitle andLeftImage:(NSString *) newLeftImage andRightTitle:(NSString *)newRightTitle
     andRightImage:(NSString *)newRightImage andCenterTitle:(NSString *)newCenterTitle andCenterImage:(NSString *)newCenterImage;
@end
