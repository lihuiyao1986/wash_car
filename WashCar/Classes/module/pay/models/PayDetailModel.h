//
//  PayDetailModel.h
//  WashCar
//
//  Created by yanshengli on 15-1-12.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

#pragma mark 支付订单状态枚举
typedef NS_ENUM(NSInteger, PayDetailStatusType) {
    PayDetailStatus_Finished  = 0,//已完成
    PayDetailStatus_Unfinished  = 1,//未完成
};

#pragma mark 第一个按钮被点击
typedef void(^FirstBtnClickedBlock)();
#pragma mark 第二个按钮被点击
typedef void(^SecondBtnClickedBlock)();
#pragma mark 第三个按钮被点击
typedef void(^ThirdBtnClickedBlock)();

/***
 *
 *@description:支付订单状态详情--接口
 *@author:liys
 *@since:2014-1-12
 *@corp:cheletong
 */
@interface PayDetailModel :BaseModel
#pragma mark 标题
@property(nonatomic,copy)NSString *title;
#pragma mark 时间
@property(nonatomic,copy)NSString *time;
#pragma mark 描述
@property(nonatomic,copy)NSString *desc;
#pragma mark 按钮标题
@property(nonatomic,copy)NSString *btnTitle;
#pragma mark 订单状态
@property(nonatomic,assign)PayDetailStatusType status;
#pragma mark 是否是第一个
@property(nonatomic,assign)BOOL isFirst;
#pragma mark 是否是最后一个
@property(nonatomic,assign)BOOL isLast;
#pragma mark 状态图片
@property(nonatomic,copy)NSString *statusPic;
#pragma mark 是否为空视图
@property(nonatomic,assign)BOOL isBlankView;
#pragma mark 第一个按钮被点击的回调
@property(nonatomic,copy)FirstBtnClickedBlock firstBtnClickedBlock;
#pragma mark 第二个按钮被点击的回调
@property(nonatomic,copy)SecondBtnClickedBlock secondBtnClickedBlock;
#pragma mark 第三个按钮被点击的回调
@property(nonatomic,copy)ThirdBtnClickedBlock thirdBtnClickedBlock;
@end
