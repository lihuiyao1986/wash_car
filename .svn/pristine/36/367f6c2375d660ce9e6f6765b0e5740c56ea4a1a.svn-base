//
//  OrderDaoModel.h
//  WashCar
//
//  Created by yanshengli on 15-1-14.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseDaoModel.h"

#pragma mark 订单状态枚举
typedef NS_ENUM(NSInteger, WashCarOrderStatus)
{
    WashCarOrderStatus_Order_Success  = 0,//下单成功
    WashCarOrderStatus_Order_Received  = 1,//已接单
    WashCarOrderStatus_Order_Arrival = 2,//已到达停车点
    WashCarOrderStatus_Order_Washing = 3,//正在洗车
    WashCarOrderStatus_Order_Finished = 4//洗车完成
};

#pragma mark 订单支付方式
typedef NS_ENUM(NSInteger, WashCarOrderPayway)
{
    WashCarOrderPayway_Reward  = 0,//红包
    WashCarOrderPayway_Alipay  = 1,//支付宝
    WashCarOrderPayway_Weixin = 2,//微信
    WashCarOrderPayway_Cash = 3,//现金
    WashCarOrderPayway_Other = 4//其他
};

#pragma mark 订单的有效性
typedef NS_ENUM(NSInteger, WashCarOrderValid)
{
    WashCarOrderValid_Valid  = 0,//有效
    WashCarOrderValid_Invalid  = 1,//无效
};

/***
 *
 *@description:订单实体类--接口
 *@since:2015-1-14
 *@author:liys
 *
 */
@interface OrderDaoModel : BaseDaoModel
#pragma mark 订单号
@property(nonatomic,copy)NSString *orderNo;
#pragma mark 下单时间
@property(nonatomic,copy)NSString *orderTime;
#pragma mark 接单时间
@property(nonatomic,copy)NSString *receivedTime;
#pragma mark 到达停车位的时间
@property(nonatomic,copy)NSString *arrivalTime;
#pragma mark 开始洗车的时间
@property(nonatomic,copy)NSString *washingTime;
#pragma mark 洗车完成的时间
@property(nonatomic,copy)NSString *finishedTime;
#pragma mark 确认洗车完成的时间
@property(nonatomic,copy)NSString *confirmTime;
#pragma mark 订单状态
@property(nonatomic,copy)NSString *status;
#pragma mark 手机号
@property(nonatomic,copy)NSString *mobile;
#pragma mark 车牌号
@property(nonatomic,copy)NSString *carNumber;
#pragma mark 停车位置
@property(nonatomic,copy)NSString *carPosition;
#pragma mark 支付方式
@property(nonatomic,copy)NSString *payway;
@end
