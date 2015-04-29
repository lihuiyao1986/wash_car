//
//  OrderDao.h
//  WashCar
//
//  Created by yanshengli on 15-1-14.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseDao.h"
#import "OrderDaoModel.h"

/***
 *
 *@description:订单操作对应的DAO--接口
 *@since:2015-1-14
 *@author:liys
 *
 */
@interface OrderDao : BaseDao

#pragma mark 保存或更新订单
-(void)saveOrder:(OrderDaoModel*)order;

#pragma mark 根据订单号查询订单
-(NSMutableDictionary*)queryOrderByOrderNo:(NSString*)orderNo;

#pragma mark 查询所有的订单信息
-(NSMutableArray*)queryAllOrders;

#pragma mark 根据订单号更新订单信息
-(void)updateOrderByOrderNo:(OrderDaoModel*)order orderNo:(NSString*)orderNo;

#pragma mark 查询有效的订单信息--根据手机号
-(NSMutableArray*)queryValidOrderByMobileno:(NSString *)mobileno;

#pragma mark 删除所有的订单
-(void)deleteAllOrder;

@end
