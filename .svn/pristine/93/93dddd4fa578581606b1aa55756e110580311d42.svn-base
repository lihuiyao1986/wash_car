//
//  TapImageViewWidget.m
//  NaChe
//
//  Created by yanshengli on 14-12-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TapImageViewWidget.h"

@implementation TapImageViewWidget
@synthesize delegate;
#pragma  初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initImageView];
    }
    return self;
}

-(instancetype)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
    if (self) {
        [self initImageView];
    }
    return self;
}

-(instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage{
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self initImageView];
    }
    return self;
}

#pragma 图片被点击之后触发
-(void)imageTaped:(UITapGestureRecognizer*)gesture{
    if ([self.delegate respondsToSelector:@selector(imageTap:imageView:)]) {
        [self.delegate imageTap:gesture imageView:self];
    }
}

#pragma 初始化imageview
-(void)initImageView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped:)];
    [self addGestureRecognizer:tapGesture];
    self.clipsToBounds = YES;
    //self.contentMode = UIViewContentModeScaleAspectFill;
    self.userInteractionEnabled = YES;
}

@end
