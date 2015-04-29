//
//  CarAreaKeybordWidget.m
//  WashCar
//
//  Created by yanshengli on 15-1-7.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "CarAreaKeybordWidget.h"
#import "LineViewWidget.h"
#import "UIView+WashCarUtility.h"
#import "AppDelegate.h"

// toolbar高度
#define toolBarHeight 50.f
// labelX
#define labelX 30.f
// labelW
#define labelW SCREEN_WIDTH - 60.f -labelX
// cellLabelFont
#define cellLabelFont [UIFont boldSystemFontOfSize:18]
// cellLabelColor
#define cellLabelColor [UIColor whiteColor]
// cancelTitleStr
#define cancelTitleStr @"取消"
// confirmTitleStr
//#define confirmTitleStr @"确定"
// titleStr
#define titleStr @"选择车牌"
// 取消按钮的宽度
#define cancelTitleBtnW  60.f
// 确认按钮的宽度
#define confirmTitleBtnW 60.f
//collectViewIdentifer
#define collectViewIdentifer @"carAreaCell"
//cell的宽度
#define cellItemW 40.f
//cell的高度
#define cellItemH 40.f
//可选择区域的高度
#define selectedViewH 407.f


/***
 *
 *@description:选择车牌地区的pickview--实现
 *@author:liys
 *@since:2014-1-6
 *@corp:cheletong
 */
@interface  CarAreaKeybordWidget()
<UICollectionViewDelegate,
 UICollectionViewDataSource,
 UICollectionViewDelegateFlowLayout>
{
    UIView *_selectedView;//可选择的区域
    UIView *_nonSelectedView;//没选中的区域
}
@end


@implementation CarAreaKeybordWidget

#pragma mark 区域数组
@synthesize items;

#pragma mark 标题
@synthesize title;

#pragma mark 取消按钮的标题
@synthesize cancelBtnTitle;

#pragma mark 代理属性
@synthesize delegate;

#pragma mark 取消回调
@synthesize canceledBlock;

#pragma mark 选中回调
@synthesize selectedBlock;

#pragma mark 窗体消失回调
@synthesize dismissedBlock;

#pragma mark 初始化方法1
-(instancetype)init
{
    return [self initWithType:CarAreaKeyBorderType_Area];
}

#pragma mark 初始化方法2
- (instancetype)initWithType:(CarAreaKeyBorderType)type
{
    self = [super init];
    
    if (self)
    {
        //1.初始化数据
        [self initData:type];
        
        //2.初始化子视图
        [self initSubViews];
    }
    return self;
}

#pragma mark 初始化数据
-(void)initData:(CarAreaKeyBorderType)type
{
    if (!self.items || self.items.count <= 0)
    {
        NSString *plistFilePath;
        if (type == CarAreaKeyBorderType_Area)
        {
            plistFilePath = [Bundle pathForResource:@"CarAreas" ofType:@"plist"];
        }
        else if(type == CarAreaKeyBorderType_Alpha)
        {
            plistFilePath = [Bundle pathForResource:@"CarAlphas" ofType:@"plist"];
        }
        self.items =[NSArray arrayWithContentsOfFile:plistFilePath];
    }
    _selectedItem = [self.items firstObject];
}

#pragma mark 绘制
-(void)initSubViews
{
    //1，设置本身视图的属性
    UIViewController *rootViewController = [ApplicationDelegate appRootViewController];
    self.backgroundColor = hexColor(0x999999,0.4);
    self.frame = rootViewController.view.bounds;
    
    //2.重置子视图
    [self removeAllSubviews];
    
    //3.选择的区域
    CGFloat nonSelectedViewX = 0.f;
    CGFloat nonSelectedViewY = 0.f;
    CGFloat nonSelectedViewW = self.frame.size.width;
    CGFloat nonSelectedViewH = ScreenHeight - selectedViewH;
    CGRect  nonSelectedViewFrame = (CGRect){nonSelectedViewX,nonSelectedViewY,nonSelectedViewW,nonSelectedViewH};
    _nonSelectedView = [[UIView alloc]initWithFrame:nonSelectedViewFrame];
    _nonSelectedView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(nonSelectedViewTaped:)];
    [_nonSelectedView addGestureRecognizer:tapGesture];
    [self addSubview:_nonSelectedView];
    
    //4.可选择的视图区域
    CGFloat selectedViewX = 0.f;
    CGFloat selectedViewY = ScreenHeight - selectedViewH;
    CGFloat selectedViewW = self.frame.size.width;
    CGRect  selectedViewFrame = (CGRect){selectedViewX,selectedViewY,selectedViewW,selectedViewH};
    _selectedView = [[UIView alloc]initWithFrame:selectedViewFrame];
    _selectedView.backgroundColor = RGB_TextColor_C0;

    [self addSubview:_selectedView];
    
    //5.toolBar
    CGFloat toolBarX = 0.f;
    CGFloat toolBarY = 0.f;
    CGFloat toolBarW = CGRectGetWidth(_selectedView.frame);
    CGFloat toolBarH = toolBarHeight;
    CGRect  toolBarFrame = (CGRect){toolBarX,toolBarY,toolBarW,toolBarH};
    _toolBar = [[UIView alloc]initWithFrame:toolBarFrame];
    _toolBar.backgroundColor = [UIColor clearColor];
    [_selectedView addSubview:_toolBar];

    //6.标题
    CGFloat titlelbX = cancelTitleBtnW;
    CGFloat titlelbY = 0.f;
    CGFloat titlelbW = self.frame.size.width - titlelbX * 2;
    CGFloat titlelbH = toolBarHeight;
    CGRect  titlelbFrame = (CGRect){titlelbX,titlelbY,titlelbW,titlelbH};
    _titlelb = [[UILabel alloc]initWithFrame:titlelbFrame];
    _titlelb.textAlignment = NSTextAlignmentCenter;
    _titlelb.textColor = RGB_TextColor_C10;
    _titlelb.lineBreakMode = NSLineBreakByTruncatingTail;
    _titlelb.font = FONT_TextSize_S4;
    if ([CommonUtils isStrEmpty:self.title])
    {
        self.title = titleStr;
    }
    _titlelb.text = self.title;
    [_toolBar addSubview:_titlelb];
    
    //7.取消按钮
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat cancelBtnX = CGRectGetMaxX(_titlelb.frame);
    CGFloat cancelBtnY = 0.f;
    CGFloat cancelBtnW = cancelTitleBtnW;
    CGFloat cancelBtnH = toolBarHeight;
    CGRect  cancelBtnFrame = (CGRect){cancelBtnX,cancelBtnY,cancelBtnW,cancelBtnH};
    _cancelBtn.frame = cancelBtnFrame;
    _cancelBtn.titleLabel.font = FONT_TextSize_S2;
    if ([CommonUtils isStrEmpty:self.cancelBtnTitle])
    {
        self.cancelBtnTitle = cancelTitleStr;
    }
    [_cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateNormal];
    [_cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateHighlighted];
    [_cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateSelected];
    [_cancelBtn setTitleColor:RGB_TextColor_C10 forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:RGB_TextColor_C10 forState:UIControlStateHighlighted];
    [_cancelBtn setTitleColor:RGB_TextColor_C10 forState:UIControlStateSelected];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:_cancelBtn];
    
    //8.分割线
    CGFloat lineX = 15.f;
    CGFloat lineY = CGRectGetMaxY(_toolBar.frame);
    CGFloat lineW = self.frame.size.width - 2 * lineX;
    CGFloat lineH = 0.5f;
    LineViewWidget *seperatorLine = [[LineViewWidget alloc]initWithXoffset:lineX yOffset:lineY lineHeight:lineH lineWidth:lineW lineColor:0xe3e2e3 lineAlpha:1.0];
    [_selectedView addSubview:seperatorLine];
    
    
    //9.内容视图
    CGFloat contentViewX = 0.f;
    CGFloat contentViewY = CGRectGetMaxY(seperatorLine.frame) + 10.f;
    CGFloat contentViewW = CGRectGetWidth(_selectedView.frame);
    CGFloat contentViewH = selectedViewH - contentViewY;
    CGRect  contentViewFrame = (CGRect){contentViewX,contentViewY,contentViewW,contentViewH};
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _contentView = [[UICollectionView alloc]initWithFrame:contentViewFrame collectionViewLayout:flowLayout];
    _contentView.delegate = self;
    _contentView.dataSource = self;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.backgroundColor = [UIColor clearColor];
    [_contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectViewIdentifer];
    [_selectedView addSubview:_contentView];

}

#pragma mark 取消按钮被点击触发的事件处理
-(IBAction)cancelBtnClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(carAreaPickViewCancelBtnClicked:)])
    {
        [self.delegate carAreaPickViewCancelBtnClicked:sender];
    }
    if (self.canceledBlock)
    {
        self.canceledBlock();
    }
    [self dismiss];
}

#pragma mark 确认按钮被点击触发的事件处理
-(void)nonSelectedViewTaped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(carAreaPickViewCancelBtnClicked:)])
    {
        [self.delegate carAreaPickViewCancelBtnClicked:_cancelBtn];
    }
    if (self.canceledBlock)
    {
        self.canceledBlock();
    }
    [self dismiss];
}

#pragma mark UICollectionViewDelegate代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *carInfo = [self.items objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(carAreaSelected:)])
    {
        [self.delegate carAreaSelected:carInfo];
    }
    if (self.selectedBlock)
    {
        self.selectedBlock(carInfo);
    }
    [self dismiss];
}

#pragma mark UICollectionViewDataSource代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cellItem = [collectionView dequeueReusableCellWithReuseIdentifier : collectViewIdentifer
                                                                            forIndexPath : indexPath];
    if (!cellItem)
    {
         cellItem = [[UICollectionViewCell alloc]init];
         cellItem.backgroundColor = [UIColor clearColor];
    }
    [cellItem.contentView removeAllSubviews];
    UILabel *carArealb = [[UILabel alloc]initWithFrame:Rect(0.f, 0.f, cellItemW, cellItemH)];
    carArealb.textAlignment = NSTextAlignmentCenter;
    carArealb.textColor = RGB_TextColor_C13;
    carArealb.font = FONT_TextSize_S4;
    carArealb.text = [self.items objectAtIndex:indexPath.row];
    [cellItem.contentView addSubview:carArealb];
    return cellItem;
}

#pragma mark UICollectionViewDelegateFlowLayout代理方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellItemW,cellItemH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   return UIEdgeInsetsMake(5.f, 5.f, 0.f, 0.f);
}

#pragma mark 显示视图
- (void)show
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.translation.y";
    animation.fromValue = @(_selectedView.frame.size.height);
    animation.toValue = @(0);
    animation.duration = 0.3f;
    animation.removedOnCompletion = YES;
    [_selectedView.layer addAnimation:animation forKey:@"trans_y_animation_show"];
    [[ApplicationDelegate appRootViewController].view addSubview:self];
}

#pragma mark 窗口消失
- (void)dismiss
{
    if (self.dismissedBlock)
    {
        self.dismissedBlock();
    }
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _selectedView.transform = CGAffineTransformMakeTranslation(0.f,_selectedView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
