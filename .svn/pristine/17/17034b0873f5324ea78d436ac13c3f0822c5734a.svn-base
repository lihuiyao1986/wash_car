//
//  PickViewWidget.m
//  NaChe
//
//  Created by nachebang on 14-11-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PickViewWidget.h"

#define DEFAULT_PICKVIEW_HEIGHT 216
#define DEFAULT_TOOLBAR_HEIGHT 44
@interface  PickViewWidget()<UIPickerViewDataSource,UIPickerViewDelegate>
@end

@implementation PickViewWidget
@synthesize leftImage,leftTitle,rightImage;
@synthesize rightTitle,centerImage,centerTitle;
@synthesize delegate;
@synthesize data;

- (id)init{
    return [self initWithData:nil];
}

- (id)initWithData:(NSMutableArray *)newData{
    return [self initWithData:newData andPickViewHeight:DEFAULT_PICKVIEW_HEIGHT];
}

- (id)initWithData:(NSMutableArray *)newData andPickViewHeight:(CGFloat)newPickViewHeight{
    return [self initWithData:newData andPickViewHeight:newPickViewHeight andLeftTitle:nil andLeftImage:nil andRightTitle:nil andRightImage:nil andCenterTitle:nil andCenterImage:nil];
}

- (id)initWithData:(NSMutableArray *)newData andPickViewHeight:(CGFloat)newPickViewHeight andLeftTitle:(NSString *) newLeftTitle andLeftImage:(NSString *) newLeftImage andRightTitle:(NSString *)newRightTitle
          andRightImage:(NSString *)newRightImage andCenterTitle:(NSString *)newCenterTitle andCenterImage:(NSString *)newCenterImage{
    self = [super init];
    if (self) {
        _pickViewHeight = newPickViewHeight;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, _pickViewHeight + 44);
        self.leftImage = (newLeftImage == NULL || [newLeftImage isEqualToString:@""]) ?  @"" : newLeftImage;
        self.leftTitle = (newLeftTitle == NULL || [newLeftTitle isEqualToString:@""]) ?  @"" : newLeftTitle;
        self.centerImage = (newCenterImage == NULL || [newCenterImage isEqualToString:@""]) ?  @"" : newCenterImage;
        self.centerTitle = (newCenterTitle == NULL || [newCenterTitle isEqualToString:@""]) ?  @"" : newCenterTitle;
        self.rightTitle = (newRightTitle == NULL || [newRightTitle isEqualToString:@""]) ?  @"完成" : newRightTitle;
        self.rightImage = (newRightImage == NULL || [newRightImage isEqualToString:@""]) ?  @"" : newRightImage;
        self.data = newData;
        _selectedIndex = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,44)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _leftBtn = [[UIBarButtonItem alloc]initWithTitle:leftTitle style:UIBarButtonItemStyleBordered target:self action:@selector(btnClicked:)];
    _leftBtn.image = [UIImage imageNamed:leftImage];
    
    _rightBtn = [[UIBarButtonItem alloc]initWithTitle:rightTitle style:UIBarButtonItemStyleBordered target:self action:@selector(btnClicked:)];
    _rightBtn.image = [UIImage imageNamed:rightImage];
    
    _centerBtn = [[UIBarButtonItem alloc]initWithTitle:centerTitle style:UIBarButtonItemStyleBordered target:self action:@selector(btnClicked:)];
    _centerBtn.image = [UIImage imageNamed:centerImage];
    [toolbar setItems:[NSArray arrayWithObjects:_leftBtn,flexible,_centerBtn,flexible,_rightBtn, nil]];
    [self addSubview:toolbar];
    
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, _pickViewHeight)];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    _pickView.backgroundColor = DEFAULT_BG_COLOR;
    _pickView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _pickView.showsSelectionIndicator = YES;
    [self addSubview:_pickView];

}


-(void)btnClicked: (id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    if(btn == _leftBtn){
        if(delegate && [delegate respondsToSelector:@selector(leftBtnClicked:pickView:withItem:)]){
            [delegate leftBtnClicked:btn pickView:_pickView withItem:[self.data objectAtIndex:_selectedIndex]];
        }
    }else if(btn == _rightBtn){
        if(delegate && [delegate respondsToSelector:@selector(rightBtnClicked:pickView:withItem:)]){
            [delegate rightBtnClicked:btn pickView:_pickView withItem:[self.data objectAtIndex:_selectedIndex]];
        }
    }else if(btn == _centerBtn){
        if(delegate && [delegate respondsToSelector:@selector(centerBtnClicked:pickView:withItem:)]){
            [delegate centerBtnClicked:btn pickView:_pickView withItem:[self.data objectAtIndex:_selectedIndex]];
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.data objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(delegate && [delegate respondsToSelector:@selector(didSelectedItem:inPickView:)]){
        _selectedIndex = row;
        NSString *item = [self.data objectAtIndex:_selectedIndex];
        [delegate didSelectedItem:item inPickView:pickerView];
    }
}

@end
