//
//  DatePickViewWidget.m
//  NaChe
//
//  Created by nachebang on 14-11-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DatePickViewWidget.h"
//默认的日期格式
#define DEFAULT_DATE_FORMATTER_STR @"yyyy-MM-dd"
@interface DatePickViewWidget ()
@end

@implementation DatePickViewWidget
@synthesize leftImage,leftTitle,rightImage;
@synthesize rightTitle,centerImage,centerTitle;
@synthesize delegate;

- (id)init{
   return [self initWithFormatter:DEFAULT_DATE_FORMATTER_STR];
}

- (id)initWithFormatter:(NSString *)formatter{
   return [self initWithFormatter:formatter andLeftTitle:nil andLeftImage:nil andRightTitle:nil andRightImage:nil andCenterTitle:nil andCenterImage:nil];
}

- (id)initWithFormatter:(NSString *) formatter andLeftTitle:(NSString *) newLeftTitle andLeftImage:(NSString *) newLeftImage andRightTitle:(NSString *)newRightTitle
          andRightImage:(NSString *)newRightImage andCenterTitle:(NSString *)newCenterTitle andCenterImage:(NSString *)newCenterImage{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
        self.leftImage = (newLeftImage == NULL || [newLeftImage isEqualToString:@""]) ?  @"" : newLeftImage;
        self.leftTitle = (newLeftTitle == NULL || [newLeftTitle isEqualToString:@""]) ?  @"" : newLeftTitle;
        self.centerImage = (newCenterImage == NULL || [newCenterImage isEqualToString:@""]) ?  @"" : newCenterImage;
        self.centerTitle = (newCenterTitle == NULL || [newCenterTitle isEqualToString:@""]) ?  @"" : newCenterTitle;
        self.rightTitle = (newRightTitle == NULL || [newRightTitle isEqualToString:@""]) ?  @"完成" : newRightTitle;
        self.rightImage = (newRightImage == NULL || [newRightImage isEqualToString:@""]) ?  @"" : newRightImage;
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = formatter;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //UIToolBar
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,44)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _leftBtn = [[UIBarButtonItem alloc]initWithTitle:leftTitle style:UIBarButtonItemStyleBordered target:self action:@selector(btnClicked:)];
    _rightBtn = [[UIBarButtonItem alloc]initWithTitle:rightTitle style:UIBarButtonItemStyleBordered target:self action:@selector(btnClicked:)];
    _centerBtn = [[UIBarButtonItem alloc]initWithTitle:centerTitle style:UIBarButtonItemStyleBordered target:self action:@selector(btnClicked:)];
    [toolbar setItems:[NSArray arrayWithObjects:_leftBtn,flexible,_centerBtn,flexible,_rightBtn, nil]];
    [self addSubview:toolbar];
    
    //UIDatePickView
    _datePickView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    _datePickView.datePickerMode = UIDatePickerModeDate;
    _datePickView.backgroundColor = DEFAULT_BG_COLOR;
    [_datePickView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePickView];
}



-(void)dateChanged{
    if(delegate){
        if([delegate respondsToSelector:@selector(dateChanged:withDateStr:)]){
            [delegate dateChanged:_datePickView withDateStr:[_dateFormatter stringFromDate:_datePickView.date]];
        }
    }
}

-(void)btnClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    if(btn == _leftBtn){
        if(delegate && [delegate respondsToSelector:@selector(leftBtnClicked:datePickerView:dateStr:)]){
            [delegate leftBtnClicked:btn datePickerView:_datePickView dateStr:[_dateFormatter stringFromDate:_datePickView.date]];
        }
    }else if(btn == _rightBtn){
        if(delegate && [delegate respondsToSelector:@selector(rightBtnClicked:datePickerView:dateStr:)]){
            [delegate rightBtnClicked:btn datePickerView:_datePickView dateStr:[_dateFormatter stringFromDate:_datePickView.date]];
        }
    }else if(btn == _centerBtn){
        if(delegate && [delegate respondsToSelector:@selector(centerBtnClicked:datePickerView:dateStr:)]){
            [delegate centerBtnClicked:btn datePickerView:_datePickView dateStr:[_dateFormatter stringFromDate:_datePickView.date]];
        }
    }
}

@end
