//
//  PayDetailCell.m
//  WashCar
//
//  Created by yanshengli on 15-1-12.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "PayDetailCell.h"
#import "CustBgViewWidget.h"
#import "LineViewWidget.h"
#import "PayDetailModel.h"
#import "NSString+Utility.h"

#define buttonW 60.f
#define buttonH 30.f
//tableviewCell的高度
#define tableCellItemH 110.f

@interface PayDetailCell()
{
    //第一个item底部的线
    LineViewWidget *_topLine;
    // 图标
    UIButton *_payIcon;
    // 标题
    UILabel  *_payTitleLb;
    // 时间
    UILabel  *_payTimeLb;
    // 背景视图
    CustBgViewWidget *_payBgView;
    // 时间线
    LineViewWidget *_timeLine;
    // 描述
    UILabel *_payDescLb;
    // 按钮
    UIButton *_payBtn;
    // 确认按钮
    UIButton *_confirmBtn;
    // 数据
    PayDetailModel *_model;
}

@end

@implementation PayDetailCell

#pragma 初始化方法
- (instancetype)initWithFrame:(CGRect)frame data:(PayDetailModel*)data
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _model = data;
        [self initSubViews];
    }
    return self;
}

#pragma mark 初始化子视图
-(void)initSubViews
{
    
    //1.设置背景色
    self.backgroundColor = [UIColor clearColor];
    if (_model.isBlankView)
    {
        self.frame = Rect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, tableCellItemH);
        return;
    }
    
    //2.获取状态
    BOOL isItemFinished = [self isFinished:_model];
    
    if (_model.isFirst)
    {
       _topLine = [[LineViewWidget alloc]initWithXoffset: 11.f + 5.f
                                                                yOffset:0.f
                                                             lineHeight:10.f
                                                              lineWidth:0.5f
                                                              lineColor:0x4193cd
                                                              lineAlpha:1.0];
        [self addSubview:_topLine];
    }
    
    //3.图片
    _payIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_payIcon setBackgroundImage:[UIImage imageNamed:@"working_Icon"] forState:UIControlStateNormal];
    [_payIcon setBackgroundImage:[UIImage imageNamed:@"no_working_Icon.png"] forState:UIControlStateDisabled];
    _payIcon.enabled = isItemFinished;
    CGFloat iconX = 5.f;
    CGFloat iconY = _model.isFirst ? CGRectGetMaxY(_topLine.frame) + 12.f : 12.f;
    CGFloat iconW = 22.f;
    CGFloat iconH = 22.f;
    CGRect  iconFrame = Rect(iconX, iconY, iconW, iconH);
    _payIcon.frame = iconFrame;
    [self addSubview:_payIcon];
    
    //4.标题
    CGFloat titleX = CGRectGetMaxX(_payIcon.frame)+ 14.f;
    CGFloat titleY = CGRectGetMinY(_payIcon.frame);
    CGFloat titleH = CGRectGetHeight(_payIcon.frame);
    CGFloat titleW = [_model.title widthForStrWithFontSize:FONT_TextSize_S2_Bold andHeight:titleH];
    CGRect  titleFrame = Rect(titleX, titleY, titleW, titleH);
    _payTitleLb = [[UILabel alloc]initWithFrame:titleFrame];
    _payTitleLb.backgroundColor = [UIColor clearColor];
    _payTitleLb.text = _model.title;
    _payTitleLb.textAlignment = NSTextAlignmentLeft;
    _payTitleLb.lineBreakMode = NSLineBreakByTruncatingTail;
    _payTitleLb.numberOfLines = 1;
    _payTitleLb.textColor = isItemFinished ? RGB_TextColor_C11 : RGB_TextColor_C8;
    _payTitleLb.font = FONT_TextSize_S2_Bold;
    [self addSubview:_payTitleLb];
    
    //5.时间
    if (isItemFinished)
    {
        CGFloat timeX = CGRectGetMaxX(_payTitleLb.frame) + 14.f;
        CGFloat timeY = CGRectGetMinY(_payIcon.frame);
        CGFloat timeH = CGRectGetHeight(_payIcon.frame);
        CGFloat timeW = [[_model.time trimNull] widthForStrWithFontSize:FONT_TextSize_S0 andHeight:timeH];
        CGRect  timeFrame = Rect(timeX, timeY, timeW, timeH);
        _payTimeLb = [[UILabel alloc]initWithFrame:timeFrame];
        _payTimeLb.backgroundColor = [UIColor clearColor];
        _payTimeLb.text = [_model.time trimNull];
        _payTimeLb.textAlignment = NSTextAlignmentLeft;
        _payTimeLb.lineBreakMode = NSLineBreakByTruncatingTail;
        _payTimeLb.numberOfLines = 1;
        _payTimeLb.textColor = RGB_TextColor_C8;
        _payTimeLb.font = FONT_TextSize_S0;
        [self addSubview:_payTimeLb];
    }
   
    //6.时间线
    if (!_model.isLast)
    {
        _timeLine = [[LineViewWidget alloc]initWithXoffset:CGRectGetMinX(_payIcon.frame) + CGRectGetWidth(_payIcon.frame)/2
                                                   yOffset:CGRectGetMaxY(_payIcon.frame) + 12.f
                                                lineHeight:65.f
                                                 lineWidth:0.5f
                                                 lineColor:(isItemFinished ? 0x4193cd:0x999999)
                                                 lineAlpha:1.0];
        [self addSubview:_timeLine];
    }
    
    //7.背景视图
    CGFloat bgViewX = CGRectGetMinX(_payTitleLb.frame);
    CGFloat bgViewY = CGRectGetMaxY(_payIcon.frame) + 12.f;
    CGFloat bgViewW = self.frame.size.width - bgViewX - 10.f;
    CGFloat bgViewH = 60.f;
    CGRect  bgViewFrame = Rect(bgViewX, bgViewY, bgViewW, bgViewH);
    _payBgView = [[CustBgViewWidget alloc]initWithFrame:bgViewFrame];
    [self addSubview:_payBgView];
    
    //8.描述视图
    CGFloat desclbX = 15.f;
    CGFloat desclbY = 0.f;
    CGFloat desclbW = CGRectGetWidth(_payBgView.frame) - 2*desclbX;
    if (![CommonUtils isStrEmpty:_model.btnTitle])
    {
        desclbW = CGRectGetWidth(_payBgView.frame) - buttonW -10.f - 2*desclbX;
    }
    CGFloat desclbH = CGRectGetHeight(_payBgView.frame);
    CGRect  desclbFrame = Rect(desclbX, desclbY, desclbW, desclbH);
    _payDescLb = [[UILabel alloc]initWithFrame:desclbFrame];
    _payDescLb.backgroundColor = [UIColor clearColor];
    _payDescLb.text = _model.desc;
    _payDescLb.textAlignment = NSTextAlignmentLeft;
    _payDescLb.lineBreakMode = NSLineBreakByWordWrapping;
    _payDescLb.numberOfLines = 0;
    _payDescLb.textColor = isItemFinished ? RGB_TextColor_C11 : RGB_TextColor_C8;
    _payDescLb.font = FONT_TextSize_S8;
    [_payBgView addSubview:_payDescLb];
    
    //9.按钮
    if (![CommonUtils isStrEmpty:_model.btnTitle])
    {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.titleLabel.font = FONT_TextSize_S8;
        _payBtn.enabled = isItemFinished;
        _payBtn.layer.borderWidth = 1;
        _payBtn.layer.borderColor = RGB_TextColor_C8.CGColor;
        _payBtn.layer.cornerRadius = 4.f;
        _payBtn.layer.masksToBounds = YES;
        [_payBtn setTitle:_model.btnTitle forState:UIControlStateNormal];
        [_payBtn setTitle:_model.btnTitle forState:UIControlStateHighlighted];
        [_payBtn setTitle:_model.btnTitle forState:UIControlStateSelected];
        [_payBtn setTitleColor:RGB_TextColor_C11 forState:UIControlStateNormal];
        [_payBtn setTitleColor:RGB_TextColor_C8 forState:UIControlStateDisabled];
        [_payBtn addTarget:self action:@selector(firstBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat payBtnX = CGRectGetMaxX(_payDescLb.frame) + 10.f;
        CGFloat payBtnY = (CGRectGetHeight(_payBgView.frame) - buttonH)/2;
        CGRect  payBtnFrame = Rect(payBtnX, payBtnY, buttonW, buttonH);
        _payBtn.frame = payBtnFrame;
        [_payBgView addSubview:_payBtn];
    }
    //10.确认洗车按钮
    if (_model.isLast)
    {
        CGFloat confirmBtnX = CGRectGetMinX(_payBgView.frame);
        CGFloat confirmBtnW = self.frame.size.width - 2*confirmBtnX;
        CGFloat confirmBtnY = MAX(CGRectGetMaxY(_timeLine.frame), CGRectGetMaxY(_payBgView.frame)) + 30.f;
        CGFloat confirmBtnH = 44.f;
        CGRect  bgViewFrame = Rect(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH);
        _confirmBtn = [CommonUtils washCarBtn:bgViewFrame];
        _confirmBtn.titleLabel.font = FONT_TextSize_S3_Bold;
        _confirmBtn.enabled = isItemFinished;
        [_confirmBtn setTitle:@"确认完成洗车" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self
                        action:@selector(secondBtnClicked:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmBtn];
    }
    CGFloat selfX = self.frame.origin.x;
    CGFloat selfY = self.frame.origin.y;
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = MAX(CGRectGetMaxY(_timeLine.frame), CGRectGetMaxY(_payBgView.frame));
    if (_model.isLast)
    {
        selfH = CGRectGetMaxY(_confirmBtn.frame) + 20.f;
    }
    self.frame = Rect(selfX,selfY,selfW,selfH);
}

#pragma mark 第一个按钮被点击
-(void)firstBtnClicked:(UIButton*)btn
{
    if (_model.firstBtnClickedBlock)
    {
        _model.firstBtnClickedBlock();
    }
}

#pragma mark 第二个按钮被点击
-(void)secondBtnClicked:(UIButton*)btn
{
    if (_model.secondBtnClickedBlock)
    {
        _model.secondBtnClickedBlock();
    }
}

#pragma mark 是否已完成
-(BOOL)isFinished:(PayDetailModel*)data
{
    return data.status == PayDetailStatus_Finished;
}

#pragma mark 
-(void)dealloc
{
    //第一个item底部的线
    _topLine = nil;
    // 图标
    _payIcon = nil;
    // 标题
    _payTitleLb = nil;
    // 时间
    _payTimeLb = nil;
    // 背景视图
    _payBgView = nil;
    // 时间线
    _timeLine = nil;
    // 描述
    _payDescLb = nil;
    // 按钮
    _payBtn = nil;
    // 确认按钮
    _confirmBtn = nil;
}

@end
