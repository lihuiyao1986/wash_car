//
//  QRcodeScanController.h
//  WashCar
//
//  Created by yanshengli on 14-12-29.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class QRcodeScanController;

#pragma mark QRcodeScanControllerDelegate
@protocol QRcodeScanControllerDelegate <NSObject>
@optional
#pragma mark 从图库中选择图片
-(void)pickQRCodeImageFromAlbum;
#pragma mark 左侧按钮被点击
-(void)leftBtnClicked:(UIButton*) btn qrViewController:(QRcodeScanController*)qrViewController;
@end

/***
 *
 *@description:二维码扫描使用的控制器--接口
 *@since:2014-12-29
 *@author:liys
 *@corp:cheletong
 */
@interface QRcodeScanController : UIViewController

#pragma mark 代理属性
@property (nonatomic,weak)id<QRcodeScanControllerDelegate>delegate;

#pragma mark 弹框显示－－带标题
-(void)showAlert:(NSString*)title message:(NSString*)message type:(AlertViewType)type;
@end
