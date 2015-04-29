//
//  TapImageViewWidget.h
//  NaChe
//
//  Created by yanshengli on 14-12-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TapImageViewWidgetDelegate <NSObject>
@optional
-(void)imageTap:(id)sender imageView:(UIImageView*)imageView;
@end
#pragma 能点击的uiimageview
@interface TapImageViewWidget : UIImageView
@property(nonatomic,weak)id<TapImageViewWidgetDelegate>delegate;
@end

