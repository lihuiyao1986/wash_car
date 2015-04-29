//
//  NavBarViewWidget.m
//  NaChe
//
//  Created by nachebang on 14-11-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NavBarViewWidget.h"
#import "UIView+WashCarUtility.h"

#define NAV_VIEW_ITEM_WIDTH  SCREEN_WIDTH / 3
#define leftLabelFont [UIFont systemFontOfSize:16]
#define centerLabelFont [UIFont boldSystemFontOfSize:20]
#define rightLabelFont [UIFont systemFontOfSize:16]

#define leftLabelColor [UIColor grayColor]
#define centerLabelColor [UIColor whiteColor]
#define rightLabelColor [UIColor whiteColor]

//圆角半径
#define custBgViewCornerRadius 4.f
//背景颜色
#define bgViewColor [UIColor whiteColor]
//背景的阴影颜色 
#define bgViewShadowColor hexColor(0x878787,1.0).CGColor
//背景的阴影X偏移量
#define bgViewShadowOffsetX 0.f
//背景的阴影Y偏移量
#define bgViewShadowOffsetY 1.f
//背景的阴影偏移量
#define bgViewShadowOffset CGSizeMake(bgViewShadowOffsetX,bgViewShadowOffsetY)
//背景的阴影的透明度
#define bgViewShadowOpacity 0.4
//背景的阴影半径
#define bgViewShadowRadius 3.f


@interface  NavBarViewWidget()

@end
@implementation NavBarViewWidget
@synthesize bgcolor,bgImage;
@synthesize leftIcon,rightIcon,centerIcon;
@synthesize leftTitle,rightTitle,centerTitle;
@synthesize leftTitleColor,centerTitleColor,rightTitleColor;
@synthesize leftTitleFont,rightTitleFont,centerTitleFont;
@synthesize delegate;

- (id)init
{
    return [self initWithLeftTitle:nil andLeftIcon:nil];
}

-(id)initWithLeftTitle:(NSString*)newLeftTitle andLeftIcon:(UIImage*)newLeftIcon{
    return [self initWithLeftIcon:newLeftIcon andLeftTitle:newLeftTitle andCenterTitle:nil andCenterIcon:nil andRightIcon:nil andRightTitle:nil andBgcolor:[UIColor clearColor] andBgImage:nil];
}

-(id)initWithLeftTitle:(NSString*)newLeftTitle andLeftIcon:(UIImage*)newLeftIcon andRightIcon:(UIImage *)newRightIcon andRightTitle:(NSString *)newRightTitle{
    return [self initWithLeftIcon:newLeftIcon andLeftTitle:newLeftTitle andCenterTitle:nil andCenterIcon:nil andRightIcon:newRightIcon andRightTitle:newRightTitle andBgcolor:[UIColor clearColor] andBgImage:nil];
}

- (id)initWithLeftIcon:(UIImage *)newLeftIcon andLeftTitle:(NSString *)newLeftTitle andCenterTitle:(NSString*)newCenterTitle andCenterIcon:(UIImage *)newCenterIcon andRightIcon:(UIImage *)newRightIcon andRightTitle:(NSString *)newRightTitle andBgcolor:(UIColor *)newBgcolor andBgImage:(UIImage *)newBgImage
{
    self = [super init];
    if (self) {
        CGFloat navBarX = 0.f;
        CGFloat navBarY = 0.f;
        CGFloat navBarW = SCREEN_WIDTH;
        CGFloat navBarH = TOP_BLANNER_HEIGHT + SCREEN_HEIGHT_START;
        CGRect navBarFrame = (CGRect){navBarX,navBarY,navBarW,navBarH};
        self.frame = navBarFrame;
        self.leftIcon = newLeftIcon;
        self.leftTitle = newLeftTitle;
        self.rightTitle = newRightTitle;
        self.rightIcon = newRightIcon;
        self.centerTitle = newCenterTitle;
        self.centerIcon = newCenterIcon;
        self.bgcolor = newBgcolor;
        self.bgImage = newBgImage;
        self.autoresizesSubviews = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //重置子视图
    [self removeAllSubviews];
    
    //背景图片
    CGFloat bgImgX = 0.f;
    CGFloat bgImgY = 0.f;
    CGFloat bgImgW = self.frame.size.width;
    CGFloat bgImgH = self.frame.size.height - bgViewShadowOffsetY;
    CGRect  bgImgFrame = (CGRect){bgImgX,bgImgY,bgImgW,bgImgH};
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:bgImgFrame];
    imageView.image = self.bgImage;
    imageView.backgroundColor = self.bgcolor;
    imageView.userInteractionEnabled = YES;
    imageView.layer.shadowColor = bgViewShadowColor;
    imageView.layer.shadowOffset = bgViewShadowOffset;
    imageView.layer.shadowOpacity = bgViewShadowOpacity;
    imageView.layer.shadowRadius = bgViewShadowRadius;
    [self addSubview:imageView];
    
    //左边视图
    CGFloat leftViewX = 0.f;
    CGFloat leftViewY = SCREEN_HEIGHT_START;
    CGFloat leftViewW = NAV_VIEW_ITEM_WIDTH;
    CGFloat leftViewH = TOP_BLANNER_HEIGHT-bgViewShadowOffsetY;
    CGRect leftViewFrame = (CGRect){leftViewX,leftViewY,leftViewW,leftViewH};
    _leftView = [[UIView alloc]initWithFrame:leftViewFrame];
    UITapGestureRecognizer *leftTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftBtnClicked:)];
    [_leftView addGestureRecognizer:leftTapGesture];
    [imageView addSubview:_leftView];
    
    //左边图片视图
    if (self.leftIcon) {
        CGFloat leftIconX = 12.f;
        CGFloat leftIconW = MIN(35.f, self.leftIcon.size.width);
        CGFloat leftIconH = MIN(self.leftIcon.size.height, CGRectGetHeight(_leftView.frame));
        CGFloat leftIconY = (CGRectGetHeight(_leftView.frame) - leftIconH)/2;
        CGRect leftIconFrame = (CGRect){leftIconX,leftIconY,leftIconW,leftIconH};
        _leftIconImg = [[UIImageView alloc]initWithFrame:leftIconFrame];
        _leftIconImg.userInteractionEnabled = YES;
        _leftIconImg.contentMode = UIViewContentModeScaleAspectFit;
        _leftIconImg.image = leftIcon;
        [_leftView addSubview:_leftIconImg];
    }
    
    //左边标题视图
    if (self.leftTitle) {
        CGFloat leftLabelX = (_leftIconImg == nil) ? 20.f : CGRectGetMaxX(_leftIconImg.frame);
        CGFloat leftLabelY = (_leftIconImg == nil) ? 0.f :CGRectGetMinY(_leftIconImg.frame);
        CGFloat leftLabelW = CGRectGetWidth(_leftView.frame) - leftLabelX;
        CGFloat leftLabelH = CGRectGetHeight(_leftView.frame);
        CGRect  leftLabelFrame = (CGRect){leftLabelX,leftLabelY,leftLabelW,leftLabelH};
        _leftLabel = [[UILabel alloc]initWithFrame:leftLabelFrame];
        _leftLabel.text = self.leftTitle;
        _leftLabel.textColor = (self.leftTitleColor == nil) ? leftLabelColor : self.leftTitleColor;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.font = (self.leftTitleFont == nil) ? leftLabelFont : self.leftTitleFont;
        [_leftView addSubview:_leftLabel];
    }
    
    //中间视图
    CGFloat centerViewX = CGRectGetMaxX(_leftView.frame);
    CGFloat centerViewY = CGRectGetMinY(_leftView.frame);
    CGFloat centerViewW = NAV_VIEW_ITEM_WIDTH;
    CGFloat centerViewH = TOP_BLANNER_HEIGHT - bgViewShadowOffsetY;
    CGRect  centerViewFrame = (CGRect){centerViewX,centerViewY,centerViewW,centerViewH};
    _centerView = [[UIView alloc]initWithFrame:centerViewFrame];
    UITapGestureRecognizer *centerTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerClicked:)];
    [_centerView addGestureRecognizer:centerTapGesture];
    [imageView addSubview:_centerView];
    
    //中间图片视图
    if (self.centerIcon) {
        CGFloat centerIconX = 0.f;
        CGFloat centerIconY = 0.f;
        CGFloat centerIconW = 35.f;
        CGFloat centerIconH = CGRectGetHeight(_centerView.frame);
        CGRect  centerIconFrame = (CGRect){centerIconX,centerIconY,centerIconW,centerIconH};
        _centerIconImg = [[UIImageView alloc]initWithFrame:centerIconFrame];
        _centerIconImg.userInteractionEnabled = YES;
        _centerIconImg.image = self.centerIcon;
        [_centerView addSubview:_centerIconImg];
    }
    
    //中间标题视图
    if (self.centerTitle) {
        CGFloat centerLabelX = (_centerIconImg == nil) ? 0.f : CGRectGetMaxX(_centerIconImg.frame);
        CGFloat centerLabelY = (_centerIconImg == nil) ? 0.f :CGRectGetMinY(_centerIconImg.frame);
        CGFloat centerLabelW = CGRectGetWidth(_centerView.frame) - centerLabelX;
        CGFloat centerLabelH = CGRectGetHeight(_centerView.frame);
        CGRect  centerLabelFrame = (CGRect){centerLabelX,centerLabelY,centerLabelW,centerLabelH};
        _centerLabel = [[UILabel alloc]initWithFrame:centerLabelFrame];
        _centerLabel.text = self.centerTitle;
        _centerLabel.textColor = (self.centerTitleColor == nil) ? centerLabelColor : self.centerTitleColor;
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.font = centerLabelFont;
        [_centerView addSubview:_centerLabel];
    }
    
    //右侧视图
    CGFloat rightViewX = CGRectGetMaxX(_centerView.frame);
    CGFloat rightViewY = CGRectGetMinY(_centerView.frame);
    CGFloat rightViewW = NAV_VIEW_ITEM_WIDTH;
    CGFloat rightViewH = TOP_BLANNER_HEIGHT - bgViewShadowOffsetY;
    CGRect  rightViewFrame = (CGRect){rightViewX,rightViewY,rightViewW,rightViewH};
    _rightView = [[UIView alloc]initWithFrame:rightViewFrame];
    UITapGestureRecognizer *rightTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightBtnClicked:)];
    [_rightView addGestureRecognizer:rightTapGesture];
    
    //右侧标题视图
    if (self.rightTitle) {
        CGFloat rightLabelW = 44.f;
        CGFloat rightLabelX = CGRectGetWidth(_rightView.frame) - 10.f - rightLabelW;
        CGFloat rightLabelY = 0.f;
        CGFloat rightLabelH = CGRectGetHeight(_rightView.frame);
        CGRect  rightLabelFrame = (CGRect){rightLabelX,rightLabelY,rightLabelW,rightLabelH};
        _rightLabel = [[UILabel alloc]initWithFrame:rightLabelFrame];
        _rightLabel.text = self.rightTitle;
        _rightLabel.textColor = self.rightTitleColor == nil ? rightLabelColor : self.rightTitleColor;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = rightLabelFont;
        [_rightView addSubview:_rightLabel];
    }

    //右边图片视图
    if (self.rightIcon) {
        CGFloat rightIconW = 35.f;
        CGFloat rightIconX = CGRectGetMinY(_rightLabel.frame) - rightIconW;
        CGFloat rightIconY = 0.f;
        CGFloat rightIconH = CGRectGetHeight(_rightView.frame);
        CGRect  rightIconFrame = (CGRect){rightIconX,rightIconY,rightIconW,rightIconH};
        _rightIconImg = [[UIImageView alloc]initWithFrame:rightIconFrame];
        _rightIconImg.userInteractionEnabled = YES;
        _rightIconImg.image = self.rightIcon;
        [_rightView addSubview:_rightIconImg];
    }

    [imageView addSubview:_rightView];
}


-(void)leftBtnClicked:(id)sender{
    if(delegate && [delegate respondsToSelector:@selector(leftNavBarBtnClicked:)]){
        [delegate leftNavBarBtnClicked:sender];
    }
}

-(void) centerClicked:(id)sender{
    if(delegate && [delegate respondsToSelector:@selector(centerNavBarBtnClicked:)]){
        [delegate centerNavBarBtnClicked:sender];
    }
}


-(void)rightBtnClicked:(id)sender{
    if(delegate && [delegate respondsToSelector:@selector(rightNavBarBtnClicked:)]){
        [delegate rightNavBarBtnClicked:sender];
    }
}
@end
