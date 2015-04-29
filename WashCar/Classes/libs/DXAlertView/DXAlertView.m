//
//  ILSMLAlertView.m
//  MoreLikers
//
//  Created by xiekw on 13-9-9.
//  Copyright (c) 2013年 谢凯伟. All rights reserved.
//

#import "DXAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "LineViewWidget.h"

//弹出框的宽
#define kAlertWidth 290.f
//弹出框的高
#define kAlertHeight 140.f
//标题的y偏移
#define kTitleYOffset 15.0f
//标题的高度
#define kTitleHeight 25.0f
//按钮的高度
#define kButtonHeight 44.0f
//分割线1的高度
#define kLine1H 0.5f
//分割线2的宽度
#define kLine2W 0.5f

@interface DXAlertView ()
{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;

@end

@implementation DXAlertView

+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

+ (CGFloat)alertHeight
{
    return kAlertHeight;
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rightTitle
{
    if (self = [super init])
    {
        //1.设置自身的背景颜色和圆角半径
        self.layer.cornerRadius = 5.0;
        self.layer.backgroundColor = RGB_TextColor_C0.CGColor;
        
        //2.标题
        if(![CommonUtils isStrEmpty:title])
        {
            CGFloat titleX = 0.f;
            CGFloat titleY = kTitleYOffset;
            CGFloat titleW = kAlertWidth;
            CGFloat titleH = kTitleHeight;
            CGRect  titleFrame = Rect(titleX, titleY, titleW, titleH);
            self.alertTitleLabel = [[UILabel alloc] initWithFrame:titleFrame];
            self.alertTitleLabel.font = FONT_TextSize_S4_Bold;
            self.alertTitleLabel.textColor = RGB_TextColor_C8;
            self.alertTitleLabel.backgroundColor = [UIColor clearColor];
            self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
            self.alertTitleLabel.text = title;
            [self addSubview:self.alertTitleLabel];
        }
        
        //3.内容
        CGFloat contentLabelWidth = kAlertWidth - 16;
        CGFloat contentX = (kAlertWidth - contentLabelWidth) * 0.5;
        CGFloat contentY = 0.f;
        if (![CommonUtils isStrEmpty:title]) {
            contentY =CGRectGetMaxY(self.alertTitleLabel.frame);
        }
        CGFloat contentW = contentLabelWidth;
        CGFloat contentH = kAlertHeight - contentY - kButtonHeight - kLine1H;
        CGRect  contentFrame = Rect(contentX, contentY, contentW, contentH);
        self.alertContentLabel = [[UILabel alloc] initWithFrame:contentFrame];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textAlignment = NSTextAlignmentCenter;
        self.alertContentLabel.textColor = RGB_TextColor_C11;
        self.alertContentLabel.font = FONT_TextSize_S3;
        self.alertContentLabel.backgroundColor = [UIColor clearColor];
        self.alertContentLabel.text = content;
        [self addSubview:self.alertContentLabel];
        
        //4.分割线
        LineViewWidget *line1 = [[LineViewWidget alloc]initWithXoffset:0.f
                                                               yOffset:CGRectGetMaxY(self.alertContentLabel.frame)
                                                            lineHeight:kLine1H
                                                             lineWidth:kAlertWidth
                                                             lineColor:0xe3e2e2
                                                             lineAlpha:1.0];
        [self addSubview:line1];
        
        //5.左右按钮
        if ([CommonUtils isStrEmpty:rightTitle]) {
            //1.只有左按钮的情况
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat leftBtnX = 0.f;
            CGFloat leftBtnY = CGRectGetMaxY(line1.frame);
            CGFloat leftBtnW = kAlertWidth;
            CGFloat leftBtnH = kButtonHeight;
            CGRect  leftBtnFrame = Rect(leftBtnX, leftBtnY, leftBtnW, leftBtnH);
            self.leftBtn.frame = leftBtnFrame;
            self.leftBtn.backgroundColor = [UIColor clearColor];
            self.leftBtn.titleLabel.font = FONT_TextSize_S2;
            [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
            [self.leftBtn setTitle:leftTitle forState:UIControlStateHighlighted];
            [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB_TextColor_C13 forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB_TextColor_C13 forState:UIControlStateHighlighted];
            [self.leftBtn setTitleColor:RGB_TextColor_C13 forState:UIControlStateNormal];
            [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.leftBtn];
        }
        else
        {
            //1.左按钮都有的情况
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat leftBtnX = 0.f;
            CGFloat leftBtnY = CGRectGetMaxY(line1.frame);
            CGFloat leftBtnW = kAlertWidth * 0.5 - 0.5f;
            CGFloat leftBtnH = kButtonHeight;
            CGRect  leftBtnFrame = Rect(leftBtnX, leftBtnY, leftBtnW, leftBtnH);
            self.leftBtn.frame = leftBtnFrame;
            self.leftBtn.backgroundColor = [UIColor clearColor];
            self.leftBtn.titleLabel.font = FONT_TextSize_S2;
            [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
            [self.leftBtn setTitle:leftTitle forState:UIControlStateHighlighted];
            [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB_TextColor_C13 forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB_TextColor_C13 forState:UIControlStateHighlighted];
            [self.leftBtn setTitleColor:RGB_TextColor_C13 forState:UIControlStateNormal];
            [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.leftBtn];
            
            //2.分割线
            LineViewWidget *line2 = [[LineViewWidget alloc]initWithXoffset:CGRectGetMaxX(self.leftBtn.frame)
                                                                   yOffset:CGRectGetMaxY(line1.frame)
                                                                lineHeight:kButtonHeight
                                                                 lineWidth:kLine2W
                                                                 lineColor:0xe3e2e2
                                                                 lineAlpha:1.0];

            [self addSubview:line2];
            
            //3.右按钮
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat rightBtnX = CGRectGetMaxX(line2.frame);
            CGFloat rightBtnY = CGRectGetMaxY(line1.frame);
            CGFloat rightBtnW = kAlertWidth - rightBtnX;
            CGFloat rightBtnH = kButtonHeight;
            CGRect  rightBtnFrame = Rect(rightBtnX, rightBtnY, rightBtnW, rightBtnH);
            self.rightBtn.frame = rightBtnFrame;
            self.rightBtn.backgroundColor = [UIColor clearColor];
            self.rightBtn.titleLabel.font = FONT_TextSize_S2;
            [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
            [self.rightBtn setTitle:rightTitle forState:UIControlStateHighlighted];
            [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB_TextColor_C12 forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB_TextColor_C12 forState:UIControlStateHighlighted];
            [self.rightBtn setTitleColor:RGB_TextColor_C12 forState:UIControlStateNormal];
            [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.rightBtn];
        }
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock)
    {
        self.leftBlock();
    }
}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock)
    {
        self.rightBlock();
    }
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = Rect((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock)
    {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    return [ApplicationDelegate appRootViewController];
}


#pragma mark 移除视图
- (void)removeFromSuperview
{
    //1.先移除背景视图
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    
    //2.移除alertView
    UIViewController *topVC = [self appRootViewController];
    CGFloat afterX = (CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5;
    CGFloat afterY = CGRectGetHeight(topVC.view.bounds);
    CGFloat afterW = kAlertWidth;
    CGFloat afterH = kAlertHeight;
    CGRect afterFrame = Rect(afterX, afterY,afterW , afterH);
    
    //3.移除时添加动画效果
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        if (_leftLeave)
        {
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }else {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
    } completion:^(BOOL finished)
    {
        [super removeFromSuperview];
    }];
}


#pragma mark 添加视图
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //1.待添加的视图为空，直接返回
    if (newSuperview == nil)
    {
        return;
    }
    
    //2.添加背景视图
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView)
    {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = hexColor(0x000000, 0.4);
        self.backImageView.opaque = NO;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    //3.添加alertview视图
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGFloat afterX = (CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5;
    CGFloat afterY = (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5;
    CGFloat afterW = kAlertWidth;
    CGFloat afterH = kAlertHeight;
    CGRect afterFrame = Rect(afterX, afterY, afterW , afterH);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    
    //4.添加视图
    [super willMoveToSuperview:newSuperview];
}
@end
