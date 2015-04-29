//
//  HyperlinksButton.m
//  WashCar
//
//  Created by yanshengli on 15-1-8.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "HyperlinksButton.h"

@implementation HyperlinksButton

-(void)setColor:(UIColor *)color
{
    _lineColor = [color copy];
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat descender = self.titleLabel.font.descender;
    if([_lineColor isKindOfClass:[UIColor class]]){
        CGContextSetStrokeColorWithColor(contextRef, _lineColor.CGColor);
    }
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+1);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+1);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}
@end
