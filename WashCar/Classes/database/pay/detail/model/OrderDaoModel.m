//
//  OrderDaoModel.m
//  WashCar
//
//  Created by yanshengli on 15-1-14.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "OrderDaoModel.h"
#import "TablePropertyModel.h"

/***
 *
 *@description:订单实体类--接口
 *@since:2015-1-14
 *@author:liys
 *
 */
@implementation OrderDaoModel

#pragma mark 订单号
@synthesize orderNo;
#pragma mark 下单时间
@synthesize orderTime;
#pragma mark 接单时间
@synthesize receivedTime;
#pragma mark 到达停车位的时间
@synthesize arrivalTime;
#pragma mark 开始洗车的时间
@synthesize washingTime;
#pragma mark 洗车完成的时间
@synthesize finishedTime;
#pragma mark 确认洗车完成的时间
@synthesize confirmTime;
#pragma mark 订单状态
@synthesize status;
#pragma mark 手机号
@synthesize mobile;
#pragma mark 车牌号
@synthesize carNumber;
#pragma mark 停车位置
@synthesize carPosition;
#pragma mark 支付方式
@synthesize payway;

#pragma mark 表属性
-(NSMutableDictionary*)tableProperties
{
    //存放表属性的字典
    NSMutableDictionary *dict = [super tableProperties];
    
    //1.订单号
    TablePropertyModel *orderNOProperty = [[TablePropertyModel alloc]init];
    orderNOProperty.fieldname = @"orderNo";
    orderNOProperty.fieldvalue = self.orderNo;
    orderNOProperty.fieldtype = sqlite_field_type_text;
    [dict setObject:orderNOProperty forKey:orderNOProperty.fieldname];
    
    //2.下单时间
    TablePropertyModel *orderTimeProperty = [[TablePropertyModel alloc]init];
    orderTimeProperty.fieldname = @"orderTime";
    orderTimeProperty.fieldvalue = self.orderTime;
    orderTimeProperty.fieldtype = sqlite_field_type_integer;
    [dict setObject:orderTimeProperty forKey:orderTimeProperty.fieldname];
    
    //3.接单时间
    TablePropertyModel *receivedTimeProperty = [[TablePropertyModel alloc]init];
    receivedTimeProperty.fieldname = @"receivedTime";
    receivedTimeProperty.fieldtype = sqlite_field_type_text;
    receivedTimeProperty.fieldvalue = self.receivedTime;
    [dict setObject:receivedTimeProperty forKey:receivedTimeProperty.fieldname];
    
    //4.到达停车位的时间
    TablePropertyModel *arrivalTimeProperty = [[TablePropertyModel alloc]init];
    arrivalTimeProperty.fieldname = @"arrivalTime";
    arrivalTimeProperty.fieldtype = sqlite_field_type_text;
    arrivalTimeProperty.fieldvalue = self.arrivalTime;
    [dict setObject:arrivalTimeProperty forKey:arrivalTimeProperty.fieldname];
    
    //5.开始洗车的时间
    TablePropertyModel *washingTimeProperty = [[TablePropertyModel alloc]init];
    washingTimeProperty.fieldname = @"washingTime";
    washingTimeProperty.fieldtype = sqlite_field_type_text;
    washingTimeProperty.fieldvalue = self.washingTime;
    [dict setObject:washingTimeProperty forKey:washingTimeProperty.fieldname];
    
    //6.洗车完成的时间
    TablePropertyModel *finishedTimeProperty = [[TablePropertyModel alloc]init];
    finishedTimeProperty.fieldname = @"finishedTime";
    finishedTimeProperty.fieldtype = sqlite_field_type_text;
    finishedTimeProperty.fieldvalue = self.finishedTime;
    [dict setObject:finishedTimeProperty forKey:finishedTimeProperty.fieldname];
    
    //7.确认洗车完成的时间
    TablePropertyModel *confirmTimeProperty = [[TablePropertyModel alloc]init];
    confirmTimeProperty.fieldname = @"confirmTime";
    confirmTimeProperty.fieldtype = sqlite_field_type_text;
    confirmTimeProperty.fieldvalue = self.confirmTime;
    [dict setObject:confirmTimeProperty forKey:confirmTimeProperty.fieldname];
    
    //8.订单状态
    TablePropertyModel *statusProperty = [[TablePropertyModel alloc]init];
    statusProperty.fieldname = @"status";
    statusProperty.fieldtype = sqlite_field_type_text;
    statusProperty.fieldvalue = self.status;
    [dict setObject:statusProperty forKey:statusProperty.fieldname];
    
    //9.手机号码
    TablePropertyModel *mobileProperty = [[TablePropertyModel alloc]init];
    mobileProperty.fieldname = @"mobile";
    mobileProperty.fieldtype = sqlite_field_type_text;
    mobileProperty.fieldvalue = self.mobile;
    [dict setObject:mobileProperty forKey:mobileProperty.fieldname];
    
    //10.车牌号
    TablePropertyModel *carNumberProperty = [[TablePropertyModel alloc]init];
    carNumberProperty.fieldname = @"carNumber";
    carNumberProperty.fieldtype = sqlite_field_type_text;
    carNumberProperty.fieldvalue = self.carNumber;
    [dict setObject:carNumberProperty forKey:carNumberProperty.fieldname];
    
    //11.停车位置
    TablePropertyModel *carPositionProperty = [[TablePropertyModel alloc]init];
    carPositionProperty.fieldname = @"carPosition";
    carPositionProperty.fieldtype = sqlite_field_type_text;
    carPositionProperty.fieldvalue = self.carPosition;
    [dict setObject:carPositionProperty forKey:carPositionProperty.fieldname];
    
    //12.支付方式
    TablePropertyModel *paywayProperty = [[TablePropertyModel alloc]init];
    paywayProperty.fieldname = @"payway";
    paywayProperty.fieldtype = sqlite_field_type_text;
    paywayProperty.fieldvalue = self.payway;
    [dict setObject:paywayProperty forKey:paywayProperty.fieldname];
    
    return dict;
}

@end
