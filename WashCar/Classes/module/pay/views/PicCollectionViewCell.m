//
//  PicCollectionViewCell.m
//  WashCar
//
//  Created by Cheletong on 15-1-16.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "PicCollectionViewCell.h"

#define scaleIconH 20.f
#define scaleIconW 20.f


@interface  PicCollectionViewCell()
{
    UIImageView *_scaleIcon;
    UIImageView *_picImg;
}
@end

@implementation PicCollectionViewCell

#pragma mark 初始化方法
- (instancetype)initWithFrame:(CGRect)frame image:(NSString*)image
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _picImg = [[UIImageView alloc]initWithFrame:self.bounds];
        _picImg.image = [UIImage imageNamed:image];
        [self addSubview:_picImg];
        
        CGFloat scaleIconX = self.frame.size.width -scaleIconW;
        CGFloat scaleIconY = self.frame.size.height - scaleIconH;
        CGRect  scaleIconFrame = Rect(scaleIconX, scaleIconY , scaleIconH, scaleIconW);
        _scaleIcon = [[UIImageView alloc]initWithFrame:scaleIconFrame];
        _scaleIcon.image = [UIImage imageNamed:@"glass.png"];
        self.backgroundColor=[UIColor  greenColor];
        [self addSubview:_scaleIcon];
    }
    return self;
}



@end