//
//  PickViewWidget.h
//  NaChe
//
//  Created by nachebang on 14-11-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickViewWidgetDelegate <NSObject>
@optional
- (void) leftBtnClicked:(UIBarButtonItem *)leftBtn pickView:(UIPickerView *)pickView withItem:(NSString*)item;
- (void) centerBtnClicked:(UIBarButtonItem *)centerBtn pickView:(UIPickerView *)pickView withItem:(NSString*)item;
- (void) rightBtnClicked:(UIBarButtonItem *)centerBtn pickView:(UIPickerView *)pickView withItem:(NSString*)item;
- (void) didSelectedItem:(NSString*)item inPickView:(UIPickerView*)pickerView;
@end

@interface PickViewWidget : UIView{
    NSString *leftTitle;//左边按钮的标题
    NSString *centerTitle;//中间按钮标题
    NSString *rightTitle;//右边按钮标题
    NSString *leftImage;//左边按钮的图片
    NSString *rightImage;//右边按钮图片
    NSString *centerImage;//中间按钮图片
    NSMutableArray *data;//数据
    NSInteger _selectedIndex;
    CGFloat _pickViewHeight;//pickview高度
    UIBarButtonItem *_leftBtn;
    UIBarButtonItem *_centerBtn;
    UIBarButtonItem *_rightBtn;
    UIPickerView *_pickView;
}
@property(nonatomic,strong)NSString *leftTitle;
@property(nonatomic,strong)NSString *centerTitle;
@property(nonatomic,strong)NSString *rightTitle;
@property(nonatomic,strong)NSString *leftImage;
@property(nonatomic,strong)NSString *rightImage;
@property(nonatomic,strong)NSString *centerImage;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,assign)id<PickViewWidgetDelegate> delegate;
- (id)initWithData:(NSMutableArray *)newData;
- (id)initWithData:(NSMutableArray *)newData andPickViewHeight:(CGFloat)newPickViewHeight;
- (id)initWithData:(NSMutableArray *)newData andPickViewHeight:(CGFloat)newPickViewHeight andLeftTitle:(NSString *) newLeftTitle andLeftImage:(NSString *) newLeftImage andRightTitle:(NSString *)newRightTitle
          andRightImage:(NSString *)newRightImage andCenterTitle:(NSString *)newCenterTitle andCenterImage:(NSString *)newCenterImage;
@end
