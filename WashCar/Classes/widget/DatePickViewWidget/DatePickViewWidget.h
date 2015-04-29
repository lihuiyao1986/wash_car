//
//  DatePickViewWidget.h
//  NaChe
//
//  Created by nachebang on 14-11-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickViewWidgetDelegate <NSObject>

@optional
//日期改变后的回调
- (void) dateChanged:(UIDatePicker *)datePicker withDateStr:(NSString *)dateStr;
- (void) leftBtnClicked:(UIBarButtonItem *)leftBtn datePickerView:(UIDatePicker *)datePicker dateStr:(NSString *)dateStr;
- (void) centerBtnClicked:(UIBarButtonItem *)centerBtn datePickerView:(UIDatePicker *)datePicker dateStr:(NSString *)dateStr;
- (void) rightBtnClicked:(UIBarButtonItem *)rightBtn datePickerView:(UIDatePicker *)datePicker dateStr:(NSString *)dateStr;
@end
@interface DatePickViewWidget : UIView{
    NSString *leftTitle;//左边按钮的标题
    NSString *centerTitle;//中间按钮标题
    NSString *rightTitle;//右边按钮标题
    NSString *leftImage;//左边按钮的图片
    NSString *rightImage;//右边按钮图片
    NSString *centerImage;//中间按钮图片
    UIBarButtonItem *_leftBtn;
    UIBarButtonItem *_centerBtn;
    UIBarButtonItem *_rightBtn;
    UIDatePicker *_datePickView;
    NSDateFormatter *_dateFormatter;
}
@property(nonatomic,strong)NSString *leftTitle;
@property(nonatomic,strong)NSString *centerTitle;
@property(nonatomic,strong)NSString *rightTitle;
@property(nonatomic,strong)NSString *leftImage;
@property(nonatomic,strong)NSString *rightImage;
@property(nonatomic,strong)NSString *centerImage;
@property(nonatomic,assign)id<DatePickViewWidgetDelegate> delegate;
- (id)initWithFormatter:(NSString *)formatter;
- (id)initWithFormatter:(NSString *) formatter andLeftTitle:(NSString *) newLeftTitle andLeftImage:(NSString *) newLeftImage andRightTitle:(NSString *)newRightTitle
          andRightImage:(NSString *)newRightImage andCenterTitle:(NSString *)newCenterTitle andCenterImage:(NSString *)newCenterImage;
@end



