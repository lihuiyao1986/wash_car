//
//  UIColor+UIColor.h
//  NaChe
//
//  Created by yanshengli on 14-11-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor(UIColor)

#pragma mark 生成16进制的颜色
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;

#pragma mark 根据颜色生成对应的图片
- (UIImage *)createImageWithColor;
@end
