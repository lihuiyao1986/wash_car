//
//  PaywayActionSheet.m
//  WashCar
//
//  Created by yangyixian on 15/1/24.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "PaywayActionSheet.h"
#import "LineViewWidget.h"

#define intervalWithButtonsX 30
#define intervalWithButtonsY 5
#define buttonCountPerRow 3
#define headerHeight 20
#define bottomHeight 20
#define cancelButtonHeight 46

@implementation PaywayActionSheet
- (id)initWithButtons:(NSArray *)buttonArray
{
    self.buttons = buttonArray;
    if ([super init]) {
        coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        coverView.backgroundColor = [UIColor colorWithRed:0.f/255 green:0.f/255 blue:0.f/255 alpha:0.4f];
        coverView.hidden = YES;
        for (int i = 0; i < [self.buttons count]; i++) {
            PaywayActionSheetButton * button = [self.buttons objectAtIndex:i];
//            button.imgButton.tag = i;
//            [button.imgButton  addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            //点击事件按钮
            UIButton *actionBtn = [[UIButton alloc]initWithFrame: button.frame];
            actionBtn.tag = i;
            [actionBtn  addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button addSubview:actionBtn];
            [self addSubview: button];
        }
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:RGB_TextColor_C12 forState:(UIControlStateNormal)];
        cancelButton.titleLabel.font = FONT_TextSize_S4;
        [cancelButton addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
    }
    return self;
}

-(void)setPositionInView:(UIView *)view
{
    if([self.buttons count] == 0)
    {
        return;
    }
    self.frame = CGRectMake(0.0f, view.frame.size.height, view.frame.size.width,([self.buttons count]+1)*50);
    self.backgroundColor = [UIColor whiteColor];
    cancelButton.frame = CGRectMake(0.f ,self.frame.size.height - 50,self.frame.size.width, 50);
    for (int i = 0; i < [self.buttons count]; i++) {
        PaywayActionSheetButton * button = [self.buttons objectAtIndex:i];
        button.frame = CGRectMake(20.f,i * 50, self.frame.size.width - 40,50);
    }
}

-(void)showInView:(UIView *)view
{
    [self setPositionInView:view];
    [view addSubview:coverView];
    [view addSubview:self];
    [UIView beginAnimations:@"ShowPaywayActionSheet" context:nil];

    
    self.frame = CGRectMake(0.0f, self.frame.origin.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    coverView.hidden = NO;
    [UIView commitAnimations];
}

//- (void)show
//{
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.translation.y";
//    animation.fromValue = @(_selectedView.frame.size.height);
//    animation.toValue = @(0);
//    animation.duration = 0.3f;
//    animation.removedOnCompletion = YES;
//    [_selectedView.layer addAnimation:animation forKey:@"trans_y_animation_show"];
//    [[ApplicationDelegate appRootViewController].view addSubview:self];
//}

-(void)dissmiss
{
//    [UIView beginAnimations:@"DismissPaywayActionSheet" context:nil];
//    self.frame = CGRectMake(0.0f, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(sheetDidDismissed)];
//    coverView.hidden = YES;
//    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0.0f, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
        [self removeFromSuperview];
        coverView.hidden = YES;
    }];
}

-(void)buttonAction:(UIButton *)button
{
    if([_delegate respondsToSelector:@selector(choseAtIndex:)])
    {
        [_delegate choseAtIndex:button.tag];
        NSLog(@"支付方式ActionSheet的代理方法被响应");
    }
    
//    NSString *paywayStr  = [[[self.buttons objectAtIndex:button.tag] titleLabel] text];
//    if (self.selectedCallBack)
//    {
//        _selectedCallBack(paywayStr,YES);
//    }
//    NSLog(@"-------->>>>>>>>>index:%d  paywayStr-->>%@",button.tag,paywayStr);
    [self dissmiss];
}

@end




@implementation PaywayActionSheetButton
-(id)init
{
    if(self)
    {
        self = nil;
    }
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self = [[PaywayActionSheetButton alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 40,50)];
    self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 18,16,18,18)];
    //加分割线
    LineViewWidget *lineView = [[LineViewWidget alloc]initWithXoffset:0.f
                                                               yOffset:50.f
                                                            lineHeight:1.f
                                                             lineWidth:280.f
                                                             lineColor:0xe3e2e2
                                                             lineAlpha:0.5];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 60, 50)];
    self.titleLabel.textColor = RGB_TextColor_C11;
    self.titleLabel.font = FONT_TextSize_S6;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_imgButton];
    [self addSubview:lineView];
    [self addSubview:_titleLabel];
    return self;
}


+(PaywayActionSheetButton *)buttonWithImage:(NSString *)imageStr title:(NSString *)title
{
    PaywayActionSheetButton * button = [[PaywayActionSheetButton alloc]init];
    
    [button.imgButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    button.titleLabel.text = title;
    return button;
}

+(PaywayActionSheetButton *)buttonWithImage:(NSString *)imageStr selectedImage:(NSString *)selectedimageStr title:(NSString *)title
{
    PaywayActionSheetButton * button = [[PaywayActionSheetButton alloc] init];
    
    [button.imgButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [button.imgButton setImage:[UIImage imageNamed:selectedimageStr] forState:UIControlStateHighlighted];
    button.titleLabel.text = title;
    return button;
}

@end