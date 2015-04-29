//
//  TablePropertyModel.h
//  WashCar
//
//  Created by yanshengli on 14-12-31.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import <Foundation/Foundation.h>

/***
 *
 *@descroiption:该实体类标识数据表的特性--接口
 *@author:liys
 *@since:2014-12-15
 *@corp:cheletong
 *
 */
@interface TablePropertyModel : NSObject

#pragma mark 字段名
@property (nonatomic,copy) NSString *fieldname;

#pragma mark 字段的类型
@property (nonatomic,copy) NSString *fieldtype;

#pragma mark 字段值
@property (nonatomic,strong) NSObject *fieldvalue;

@end
