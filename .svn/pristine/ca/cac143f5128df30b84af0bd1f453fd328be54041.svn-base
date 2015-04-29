//
//  BeforeCell.h
//  WashCar
//
//  Created by Cheletong on 15-1-14.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarPicModel;

@protocol BeforeCellDelegate <NSObject>

@optional
-(void)picClickedAtIndex:(int)selectedIndex pics:(NSArray*)pics;

@end

@interface BeforeCell : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,weak)id<BeforeCellDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame data:(CarPicModel*)data;
@end
