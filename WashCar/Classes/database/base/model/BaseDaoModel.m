//
//  BaseDaoModel.m
//  WashCar
//
//  Created by yanshengli on 14-12-31.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import "BaseDaoModel.h"
#import "TablePropertyModel.h"

/***
 *
 *@descroiption:所有操作数据库的实体对象--实现
 *@author:liys
 *@since:2014-12-15
 *@corp:cheletong
 *
 */
@implementation BaseDaoModel

#pragma mark 创建时间
@synthesize createTime;

#pragma mark 修改时间
@synthesize modifyTime;

#pragma mark 表属性--让子类覆盖
-(NSMutableDictionary*)tableProperties
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //创建时间字段
    TablePropertyModel *createTimeProperty = [[TablePropertyModel alloc]init];
    createTimeProperty.fieldname = @"createTime";
    createTimeProperty.fieldtype = sqlite_field_type_text;
    [dict setObject:createTimeProperty forKey:createTimeProperty.fieldname];
    //
    TablePropertyModel *modifyTimeProperty = [[TablePropertyModel alloc]init];
    modifyTimeProperty.fieldname = @"modifyTime";
    modifyTimeProperty.fieldtype = sqlite_field_type_text;
    [dict setObject:modifyTimeProperty forKey:modifyTimeProperty.fieldname];
    return dict;
}

#pragma mark 获取表名
-(NSString*)tableName{
    return NSStringFromClass([self class]);
}

@end
