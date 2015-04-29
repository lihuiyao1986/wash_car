//
//  AreaPickWidget.m
//  NaChe
//
//  Created by nachebang on 14-11-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AreaPickWidget.h"

@interface  AreaPickWidget()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation AreaPickWidget
@synthesize leftImage,leftTitle,rightImage;
@synthesize rightTitle,centerImage,centerTitle;
@synthesize delegate;
- (id)init{
    return [self initLeftTitle:nil andLeftImage:nil andRightTitle:nil andRightImage:nil andCenterTitle:nil andCenterImage:nil];
}
- (id)initLeftTitle:(NSString *) newLeftTitle andLeftImage:(NSString *) newLeftImage andRightTitle:(NSString *)newRightTitle
      andRightImage:(NSString *)newRightImage andCenterTitle:(NSString *)newCenterTitle andCenterImage:(NSString *)newCenterImage{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 216 + 44);
        self.leftImage = (newLeftImage == NULL || [newLeftImage isEqualToString:@""]) ?  @"" : newLeftImage;
        self.leftTitle = (newLeftTitle == NULL || [newLeftTitle isEqualToString:@""]) ?  @"" : newLeftTitle;
        self.centerImage = (newCenterImage == NULL || [newCenterImage isEqualToString:@""]) ?  @"" : newCenterImage;
        self.centerTitle = (newCenterTitle == NULL || [newCenterTitle isEqualToString:@""]) ?  @"" : newCenterTitle;
        self.rightTitle = (newRightTitle == NULL || [newRightTitle isEqualToString:@""]) ?  @"完成" : newRightTitle;
        self.rightImage = (newRightImage == NULL || [newRightImage isEqualToString:@""]) ?  @"" : newRightImage;
        _provinces =[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
        _cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
        _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
        _provinceSelectedIndex = 0;
        _citySelectedIndex = 0;
        _areaSelectedIndex = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //toolbar
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
    
    //pickview
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    _pickView.backgroundColor = DEFAULT_BG_COLOR;
    _pickView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _pickView.showsSelectionIndicator = YES;
    [self addSubview:_pickView];
}


-(void)btnClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem*)sender;
    NSString *provinceStr = @"";
    NSString *cityStr = @"";
    NSString *areaStr = @"";
    if(_provinces.count > 0){
        provinceStr = [[_provinces objectAtIndex:_provinceSelectedIndex] objectForKey:@"state"];
    }
    if(_cities.count > 0){
        cityStr = [[_cities objectAtIndex:_citySelectedIndex]objectForKey:@"city"];
    }
    if(_areas.count > 0){
        areaStr =[_areas objectAtIndex:_areaSelectedIndex];
    }
    if(btn == _leftBtn){
        if(delegate && [delegate respondsToSelector:@selector(leftBtnClicked:province:city:area:)]){
            [delegate leftBtnClicked:btn province:provinceStr city:cityStr area:areaStr];
        }
    }else if(btn == _rightBtn){
        if(delegate && [delegate respondsToSelector:@selector(rightBtnClicked:province:city:area:)])
        {
            [delegate rightBtnClicked:btn province:provinceStr city:cityStr area:areaStr];
        }
    }else if(btn == _centerBtn){
        if(delegate && [delegate respondsToSelector:@selector(centerBtnClicked:province:city:area:)]){
            [delegate centerBtnClicked:btn province:provinceStr city:cityStr area:areaStr];
        }
    }
}

#pragma UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [[_provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[_cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([_areas count] > 0) {
                return [_areas objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        _cities = [[_provinces objectAtIndex:row] objectForKey:@"cities"];
        _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
        [_pickView reloadComponent:1];
        [_pickView selectRow:0 inComponent:1 animated:YES];
        [_pickView reloadComponent:2];
        [_pickView selectRow:0 inComponent:2 animated:YES];
        _provinceSelectedIndex = row;
        _citySelectedIndex = 0;
        _areaSelectedIndex = 0;
    }else if(component == 1){
        _areas = [[_cities objectAtIndex:row] objectForKey:@"areas"];
        [_pickView reloadComponent:2];
        [_pickView selectRow:0 inComponent:2 animated:YES];
        _citySelectedIndex = row;
        _areaSelectedIndex = 0;
    }else if(component == 2){
        _areaSelectedIndex = row;
    }
    NSString *provinceStr = @"";
    NSString *cityStr = @"";
    NSString *areaStr = @"";
    if(_provinces.count > 0){
       provinceStr = [[_provinces objectAtIndex:_provinceSelectedIndex] objectForKey:@"state"];
    }
    if(_cities.count > 0){
        cityStr = [[_cities objectAtIndex:_citySelectedIndex]objectForKey:@"city"];
    }
    if(_areas.count > 0){
        areaStr =[_areas objectAtIndex:_areaSelectedIndex];
    }
    if(delegate && [delegate respondsToSelector:@selector(didSelectedProvince:city:area:)]){
        [delegate didSelectedProvince:provinceStr city:cityStr area:areaStr];
    }
}

#pragma UIPickerViewDataSource method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return _provinces.count;
            break;
        case 1:
            return _cities.count;
            break;
        case 2:
            return _areas.count;
            break;
        default:
            return 0;
            break;
    }
}
@end
