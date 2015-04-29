//
//  BeforeCell.m
//  WashCar
//
//  Created by Cheletong on 15-1-14.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BeforeCell.h"
#import "LineViewWidget.h"
#import "CarPicModel.h"
#import "CustBgViewWidget.h"
#import "PicViewController.h"
#import "AppDelegate.h"
#import "PicCollectionViewCell.h"
#import "UIView+WashCarUtility.h"
#import "ImageBrowserWidget.h"

#define singlePicH 57.f
#define singlePicW 65.f
#define singlePicXOffset 42.5f
#define singlePicYOffset 10.f

@interface  BeforeCell()
{
    CarPicModel * _data;
    UICollectionView * _myCollectionView;
    ImageBrowserWidget * imageBrowser;
}

@end

@implementation BeforeCell

@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame data:(CarPicModel*)data
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _data = data;
        self.backgroundColor = [UIColor clearColor];
        //背景视图
        CGFloat bgViewX = 10.f;
        CGFloat bgViewY = 0.f;
        CGFloat bgViewW = self.frame.size.width - 2*bgViewX;
        CGFloat bgViewH = self.frame.size.height;
        CGRect  bgViewFrame = Rect(bgViewX, bgViewY, bgViewW, bgViewH);
        CustBgViewWidget * _bgView = [[CustBgViewWidget alloc]initWithFrame:bgViewFrame];
        _bgView.backgroundColor = RGB_TextColor_C0;
        [self addSubview:_bgView];
        //标题
        CGFloat carlbX = 10.f;
        CGFloat carlbY = 0.f;
        CGFloat carlbW = _bgView.frame.size.width - 2 * carlbX;
        CGFloat carlbH = 44.f;
        CGRect  carlbFrame = Rect(carlbX, carlbY, carlbW, carlbH);
        UILabel * _carLabel=[[UILabel alloc]initWithFrame:carlbFrame];
        _carLabel.text = data.title;
        _carLabel.textColor=hexColor(0x66aad9,1);
        _carLabel.backgroundColor = [UIColor clearColor];
        _carLabel.font=FONT_TextSize_S3;
        [_bgView addSubview:_carLabel];
        
        //分割线
        LineViewWidget *lineView = [[LineViewWidget alloc]initWithXoffset:CGRectGetMinX(_carLabel.frame)
                                                                yOffset:CGRectGetMaxY(_carLabel.frame)
                                                                lineHeight:0.5f
                                                                 lineWidth:CGRectGetWidth(_carLabel.frame)
                                                                 lineColor:0xe3e2e2
                                                                 lineAlpha:1];
        [_bgView addSubview:lineView];
        
        //图片区
        CGFloat picViewX = CGRectGetMinX(lineView.frame);
        CGFloat picViewY = CGRectGetMaxY(lineView.frame);
        CGFloat picViewW = _bgView.frame.size.width - picViewX*2;
        CGRect  picViewFrame = Rect(picViewX, picViewY, picViewW,((data.pics.count/3)+1) * (singlePicH + singlePicYOffset));
        CGRect  picViewFrame1 = Rect(picViewX, picViewY, picViewW,(data.pics.count/3) * (singlePicH + singlePicYOffset));
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        if (data.pics.count%3==0)
        {
            _myCollectionView = [[UICollectionView alloc] initWithFrame:picViewFrame1
                                              collectionViewLayout:flowLayout];
        }
        else if (data.pics.count%3!=0)
        {
         _myCollectionView = [[UICollectionView alloc] initWithFrame:picViewFrame
                                                                    collectionViewLayout:flowLayout];
        } 
        _myCollectionView.backgroundColor = [UIColor clearColor];
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_bgView addSubview:_myCollectionView];
        _bgView.frame = Rect(_bgView.frame.origin.x, _bgView.frame.origin.y, _bgView.frame.size.width, CGRectGetMaxY(_myCollectionView.frame)+10.f);
        
        self.frame = Rect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_bgView.frame) + 14.f);
    }
    return self;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    return _data.pics.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma  mark    每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"myCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                            forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[UICollectionViewCell alloc]initWithFrame:Rect(0.f, 0.f, singlePicW, singlePicH)];
    }
    [cell.contentView removeAllSubviews];
    CGRect picCellItemFrame = Rect(0.f, 0.f, singlePicW, singlePicH);
    
    PicCollectionViewCell *cellItem = [[PicCollectionViewCell alloc]initWithFrame:picCellItemFrame image:[_data.pics objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:cellItem];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(singlePicW, singlePicH);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(picClickedAtIndex:pics:)]) {
        [self.delegate picClickedAtIndex:indexPath.row  pics:_data.pics];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end