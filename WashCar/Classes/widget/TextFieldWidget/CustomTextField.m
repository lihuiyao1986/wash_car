//
//  CustomTextField.m
//  WashCar
//
//  Created by yangyixian on 15/1/12.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}
////控制左视图位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
//    return inset;
//    //return CGRectInset(bounds,50,0);
//}

//控制placeHolder的位置bounds  为俯视图的尺寸
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    if (PRE_IOS7) {
        return  CGRectMake(bounds.origin.x +20, bounds.origin.y +5, bounds.size.width, bounds.size.height);
    }else
        return  CGRectMake(bounds.origin.x +21, bounds.origin.y +15, bounds.size.width, bounds.size.height);
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    [RGB_TextColor_C8 setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:13]];

}

@end
