//
//  TarBarWidget.m
//  NaChe
//
//  Created by yanshengli on 14-11-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TarBarWidget.h"
#define SEGMENT_BAR_HEIGHT 44
#define INDICATOR_HEIGHT 2

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
static NSString *segmentBarItemID = @"itemIdentifer";


#pragma SegmentBarItemDelegate protocal
@protocol SegmentBarItemDelegate <NSObject>
@optional
-(void)tarBarClicked:(UIButton *)tarBarBtn atIndex:(NSInteger)index;
@end


#pragma SegmentBarItem class definition
@interface SegmentBarItem : UICollectionViewCell{
    UIButton *_titleBtn;
}
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic,weak) id<SegmentBarItemDelegate> delegate;
@end


#pragma SegmentBarItem class implementation
@implementation SegmentBarItem
@synthesize delegate,titleBtn;
#pragma initWithFrame
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleBtn];
    }
    return self;
}

#pragma titleBtn
- (UIButton *)titleBtn
{
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _titleBtn.frame = self.contentView.bounds;
        _titleBtn.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _titleBtn.backgroundColor = [UIColor clearColor];
    }
    return _titleBtn;
}

#pragma 按钮点击
-(void)btnClicked:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(tarBarClicked:atIndex:)]) {
        [self.delegate tarBarClicked:sender atIndex:sender.tag];
    }
}
@end


#pragma TarBarWidget class implementation
@interface  TarBarWidget ()<UICollectionViewDataSource,SegmentBarItemDelegate,UICollectionViewDelegate, UIScrollViewDelegate>{
    UIView *_indicatorBgView;
    UIView *_indicator;
    UICollectionView *_segmentBar;
    UIView *_selectedView;
    UIScrollView *_slideView;
    UICollectionViewFlowLayout *_segmentBarLayout;
}
@end

@implementation TarBarWidget
@synthesize tarBarTitles = _tarBarTitles;
@synthesize contentViews = _contentViews;
@synthesize selectedIndex = _selectedIndex;
@synthesize tarBarBgColor = _tarBarBgColor;
@synthesize seperatorColor = _seperatorColor;
@synthesize indicatorBgColor = _indicatorBgColor;
@synthesize indicatorLineHeight = _indicatorLineHeight;
@synthesize indicatorInsets = _indicatorInsets;
@synthesize tarBarItemTextColor = _tarBarItemTextColor;

#pragma 指示器背景视图
-(UIView *)indicatorBgView
{
    if (!_indicatorBgView) {
        CGRect frame = CGRectMake(0,CGRectGetHeight(self.segmentBar.frame) - INDICATOR_HEIGHT - 1,
                                  CGRectGetWidth(self.frame) / self.contentViews.count, INDICATOR_HEIGHT);
        _indicatorBgView = [[UIView alloc] initWithFrame:frame];
        _indicatorBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _indicatorBgView.backgroundColor = [UIColor clearColor];
        [_indicatorBgView addSubview:self.indicator];
    }
    return _indicatorBgView;
}

#pragma 获取指示器视图
- (UIView *)indicator
{
    if (!_indicator) {
        CGFloat width = CGRectGetWidth(self.frame)/self.contentViews.count - self.indicatorInsets.left - self.indicatorInsets.right;
        CGFloat indicatorHeight = self.indicatorLineHeight != 0.f ? self.indicatorLineHeight : INDICATOR_HEIGHT;
        CGRect frame = CGRectMake(self.indicatorInsets.left, 0, width, indicatorHeight);
        _indicator = [[UIView alloc] initWithFrame:frame];
        _indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _indicator.backgroundColor = self.indicatorBgColor!=nil ? self.indicatorBgColor : [UIColor lightGrayColor];
    }
    return _indicator;
}


#pragma 获取tarbar
- (UICollectionView *)segmentBar
{
    if (!_segmentBar) {
        CGRect segmentBarFrame = Rect(0, 0, CGRectGetWidth(self.frame), SEGMENT_BAR_HEIGHT);
        _segmentBar = [[UICollectionView alloc] initWithFrame:segmentBarFrame collectionViewLayout:self.segmentBarLayout];
        _segmentBar.backgroundColor = self.tarBarBgColor!= nil ?self.tarBarBgColor : [UIColor whiteColor];
        _segmentBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _segmentBar.delegate = self;
        _segmentBar.dataSource = self;
        CGFloat seperatorLineWidth = 0.5f;
        CGRect seperatorFrame = Rect(0, _segmentBar.frame.size.height - seperatorLineWidth, _segmentBar.frame.size.width, seperatorLineWidth);
        UIView *separator = [[UIView alloc] initWithFrame:seperatorFrame];
        [separator setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
        separator.backgroundColor = self.seperatorColor !=nil ? self.seperatorColor : [UIColor lightGrayColor];
        [_segmentBar addSubview:separator];
        _segmentBar.userInteractionEnabled = YES;
    }
    return _segmentBar;
}

#pragma 获取UICollectionViewFlowLayout对象
- (UICollectionViewFlowLayout *)segmentBarLayout
{
    if (!_segmentBarLayout) {
        _segmentBarLayout = [[UICollectionViewFlowLayout alloc] init];
        _segmentBarLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame)/ self.tarBarTitles.count, SEGMENT_BAR_HEIGHT);
        _segmentBarLayout.sectionInset = UIEdgeInsetsZero;
        _segmentBarLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _segmentBarLayout.minimumLineSpacing = 0;
        _segmentBarLayout.minimumInteritemSpacing = 0;
    }
    return _segmentBarLayout;
}


#pragma mark - Property
- (UIScrollView *)slideView
{
    if (!_slideView) {
        CGRect sliderFrame = Rect(0, CGRectGetMaxY(_segmentBar.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(_segmentBar.frame));
        _slideView = [[UIScrollView alloc] initWithFrame:sliderFrame];
        [_slideView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth
                                         | UIViewAutoresizingFlexibleHeight)];
        [_slideView setShowsHorizontalScrollIndicator:NO];
        [_slideView setShowsVerticalScrollIndicator:NO];
        [_slideView setPagingEnabled:YES];
        [_slideView setBounces:NO];
        [_slideView setDelegate:self];
        [_slideView setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * self.contentViews.count, 0)];
    }
    return _slideView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tarBarTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SegmentBarItem *segmentBarItem = [collectionView dequeueReusableCellWithReuseIdentifier:segmentBarItemID
                                                                                 forIndexPath:indexPath];
    if(!segmentBarItem){
        segmentBarItem = [[SegmentBarItem alloc]initWithFrame:CGRectZero];
    }
    [segmentBarItem.titleBtn setTitle: self.tarBarTitles[indexPath.row] forState:UIControlStateNormal];
    [segmentBarItem.titleBtn setTitle: self.tarBarTitles[indexPath.row] forState:UIControlStateHighlighted];
    UIColor *itemColor = self.tarBarItemTextColor !=nil ? self.tarBarItemTextColor : [UIColor grayColor];
    [segmentBarItem.titleBtn setTitleColor:itemColor forState:UIControlStateNormal];
    [segmentBarItem.titleBtn setTitleColor:itemColor forState:UIControlStateHighlighted];
    segmentBarItem.titleBtn.tag = indexPath.row;
    segmentBarItem.delegate = self;
    segmentBarItem.backgroundColor = [UIColor clearColor];
    return segmentBarItem;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath was invoked");
    if (indexPath.row < 0 || indexPath.row >= self.contentViews.count) {
        return;
    }
    [self setSelectedIndex:indexPath.row];
    [self scrollToViewWithIndex:self.selectedIndex animated:NO];
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"shouldSelectItemAtIndexPath was invoked");
    if (indexPath.row < 0 || indexPath.row >= self.contentViews.count) {
        return NO;
    }
    return YES;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.slideView) {
        CGRect frame = self.indicatorBgView.frame;
        CGFloat percent = scrollView.contentOffset.x / scrollView.contentSize.width;
        frame.origin.x = scrollView.frame.size.width * percent;
        self.indicatorBgView.frame = frame;
        NSInteger index = ceilf(percent * self.contentViews.count);
        if (index >= 0 && index < self.contentViews.count) {
            [self setSelectedIndex:index];
        }
    }
}


#pragma mark - Action
- (void)scrollToViewWithIndex:(NSInteger)index animated:(BOOL)animated
{
    CGRect rect = self.slideView.bounds;
    rect.origin.x = rect.size.width * index;
    [self.slideView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y) animated:animated];
}

#pragma reset 
- (void)reset
{
    _selectedIndex = NSNotFound;
    [self setSelectedIndex:0];
    [self scrollToViewWithIndex:0 animated:NO];
    [self.segmentBar reloadData];
}

#pragma override drawRect method
- (void)drawRect:(CGRect)rect
{
    //设置segmentview
    [self addSubview:[self segmentBar]];
    [_segmentBar registerClass:[SegmentBarItem class] forCellWithReuseIdentifier:segmentBarItemID];
    [_segmentBar addSubview:[self indicatorBgView]];
    
    //设置slideview
    [self addSubview:[self slideView]];
    [self loadContentViews];
}

#pragma  加载内容视图
-(void)loadContentViews
{
    // Need remove previous viewControllers
    for (NSInteger index = 0 ; index < self.contentViews.count; index ++) {
        UIView *view = [self.contentViews objectAtIndex:index];
        [view removeFromSuperview];
        view.frame = Rect(index*CGRectGetWidth(_slideView.frame), 0, CGRectGetWidth(_slideView.frame), CGRectGetHeight(_slideView.frame));
        [_slideView addSubview:view];
    }
    [self reset];
}

#pragma
-(void)tarBarClicked:(UIButton *)tarBarBtn atIndex:(NSInteger)index
{
    [self setSelectedIndex:index];
    [self scrollToViewWithIndex:index animated:YES];
    
}


@end
