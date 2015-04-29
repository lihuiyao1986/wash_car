//
//  ToolBarWidget.m
//  NaChe
//
//  Created by nachebang on 14-11-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ToolBarWidget.h"
#import "UIView+WashCarUtility.h"
#import "LineViewWidget.h"

//背景颜色
#define defaultBgColor RGB_TextColor_C0
//默认的颜色
#define defaultLeftColor RGB_TextColor_C10
#define defaultRightColor RGB_TextColor_C10
#define defaultCenterColor RGB_TextColor_C10
//默认的字体
#define defaultRightFont FONT_TextSize_S1
#define defaultCenterFont FONT_TextSize_S2
#define defaultleftFont  FONT_TextSize_S1
//默认的提示
//#define defaultLeftStr @"取消"
#define defaultRightStr @"完成"


@interface ToolBarWidget ()

@end

@implementation ToolBarWidget
@synthesize leftImage,leftTitle,rightImage;
@synthesize rightTitle,centerImage,centerTitle;
@synthesize leftBtnColor,rightBtnColor,centerBtnColor;
@synthesize leftFont,centerFont,rightFont;
@synthesize delegate;
@synthesize leftClickedCallBack;
@synthesize rightClickedCallBack;
@synthesize centerClickedCallBack;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.bgColor = defaultBgColor;
        self.leftBtnColor = defaultLeftColor;
        self.leftFont = defaultleftFont;
        self.rightBtnColor = defaultRightColor;
        self.rightFont = defaultRightFont;
        self.centerBtnColor = defaultCenterColor;
        self.centerFont = defaultCenterFont;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //1.重置子视图
    [self removeAllSubviews];
    
    //2.上面的分割线
    LineViewWidget *topLine = [[LineViewWidget alloc]initWithXoffset:0
                                                             yOffset:0
                                                          lineHeight:0.5
                                                           lineWidth:self.frame.size.width
                                                           lineColor:0xe3e2e2
                                                           lineAlpha:1.0];
    [self addSubview:topLine];
    
    //3.工具栏
    _toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topLine.frame), self.frame.size.width,self.frame.size.height -1)];
    _toolBar.backgroundColor = self.bgColor;
    [self addSubview:_toolBar];
    
    //4.底部分割线
    LineViewWidget *bottomLine = [[LineViewWidget alloc]initWithXoffset:0
                                                             yOffset:CGRectGetMaxY(_toolBar.frame)
                                                          lineHeight:0.5
                                                           lineWidth:self.frame.size.width
                                                           lineColor:0xe3e2e2
                                                           lineAlpha:1.0];
    [self addSubview:bottomLine];
    
    //5.左侧按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat leftBtnX = 0.f;
    CGFloat leftBtnY = 0.f;
    CGFloat leftBtnW = CGRectGetWidth(_toolBar.frame)/3;
    CGFloat leftBtnH = CGRectGetHeight(_toolBar.frame);
    CGRect  leftFrame = (CGRect){leftBtnX,leftBtnY,leftBtnW,leftBtnH};
    _leftBtn.frame = leftFrame;
    //self.leftTitle = [CommonUtils isStrEmpty:self.leftTitle] ? defaultLeftStr : self.leftTitle;
    [_leftBtn setTitle:self.leftTitle forState:UIControlStateNormal];
    [_leftBtn setTitle:self.leftTitle forState:UIControlStateHighlighted];
    [_leftBtn setTitle:self.leftTitle forState:UIControlStateSelected];
    [_leftBtn setImage:[UIImage imageNamed:self.leftImage] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:self.leftImage] forState:UIControlStateHighlighted];
    [_leftBtn setImage:[UIImage imageNamed:self.leftImage] forState:UIControlStateSelected];
    [_leftBtn setTitleColor:self.leftBtnColor forState:UIControlStateNormal];
    [_leftBtn setTitleColor:self.leftBtnColor forState:UIControlStateHighlighted];
    [_leftBtn setTitleColor:self.leftBtnColor forState:UIControlStateSelected];
    [_leftBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.titleLabel.font = self.leftFont;
    [_toolBar addSubview:_leftBtn];
    
    //6.中间按钮
    _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat centerBtnX = CGRectGetMaxX(_leftBtn.frame);
    CGFloat centerBtnY = CGRectGetMinY(_leftBtn.frame);
    CGFloat centerBtnW = CGRectGetWidth(_toolBar.frame)/3;
    CGFloat centerBtnH = CGRectGetHeight(_toolBar.frame);
    CGRect  centerFrame = (CGRect){centerBtnX,centerBtnY,centerBtnW,centerBtnH};
    _centerBtn.frame = centerFrame;
    [_centerBtn setTitle:self.centerTitle forState:UIControlStateNormal];
    [_centerBtn setTitle:self.centerTitle forState:UIControlStateHighlighted];
    [_centerBtn setTitle:self.centerTitle forState:UIControlStateSelected];
    [_centerBtn setImage:[UIImage imageNamed:self.centerImage] forState:UIControlStateNormal];
    [_centerBtn setImage:[UIImage imageNamed:self.centerImage] forState:UIControlStateHighlighted];
    [_centerBtn setImage:[UIImage imageNamed:self.centerImage] forState:UIControlStateSelected];
    [_centerBtn setTitleColor:self.centerBtnColor forState:UIControlStateNormal];
    [_centerBtn setTitleColor:self.centerBtnColor forState:UIControlStateHighlighted];
    [_centerBtn setTitleColor:self.centerBtnColor forState:UIControlStateSelected];
    [_centerBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _centerBtn.titleLabel.font = self.centerFont;
    [_toolBar addSubview:_centerBtn];
    
    //7.右侧按钮
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat rightBtnX = CGRectGetMaxX(_centerBtn.frame);
    CGFloat rightBtnY = CGRectGetMinY(_centerBtn.frame);
    CGFloat rightBtnW = CGRectGetWidth(_toolBar.frame)/3;
    CGFloat rightBtnH = CGRectGetHeight(_toolBar.frame);
    CGRect  rightFrame = (CGRect){rightBtnX,rightBtnY,rightBtnW,rightBtnH};
    _rightBtn.frame = rightFrame;
    self.rightTitle = [CommonUtils isStrEmpty:self.rightTitle] ? defaultRightStr : self.rightTitle;
    [_rightBtn setTitle:self.rightTitle forState:UIControlStateNormal];
    [_rightBtn setTitle:self.rightTitle forState:UIControlStateHighlighted];
    [_rightBtn setTitle:self.rightTitle forState:UIControlStateSelected];
    [_rightBtn setImage:[UIImage imageNamed:self.rightImage] forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:self.rightImage] forState:UIControlStateHighlighted];
    [_rightBtn setImage:[UIImage imageNamed:self.rightImage] forState:UIControlStateSelected];
    [_rightBtn setTitleColor:self.rightBtnColor forState:UIControlStateNormal];
    [_rightBtn setTitleColor:self.rightBtnColor forState:UIControlStateHighlighted];
    [_rightBtn setTitleColor:self.rightBtnColor forState:UIControlStateSelected];
    [_rightBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font = self.rightFont;
    _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_toolBar addSubview:_rightBtn];
}

#pragma mark 按钮被点击
-(void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if(btn == _leftBtn)
    {
        if(delegate && [delegate respondsToSelector:@selector(toolbarLeftBtnClicked:toolBar:)])
        {
            [delegate toolbarLeftBtnClicked:btn toolBar:self];
        }
        if (self.leftClickedCallBack)
        {
            self.leftClickedCallBack();
        }
    }
    else if(btn == _rightBtn)
    {
        if(delegate && [delegate respondsToSelector:@selector(toolbarRightBtnClicked:toolBar:)])
        {
            [delegate toolbarRightBtnClicked:btn toolBar:self];
        }
        if (self.rightClickedCallBack)
        {
            self.rightClickedCallBack();
        }
    }
    else if(btn == _centerBtn)
    {
        if(delegate && [delegate respondsToSelector:@selector(toolbarCenterBtnClicked:toolBar:)])
        {
            [delegate toolbarCenterBtnClicked:btn toolBar:self];
        }
        if (self.centerClickedCallBack)
        {
            self.centerClickedCallBack();
        }
    }
}
@end
