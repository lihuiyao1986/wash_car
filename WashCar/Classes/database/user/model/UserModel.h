//
//  User.h
//  WashCar
//
//  Created by yanshengli on 14-12-30.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDaoModel.h"

/***
 *
 *@descroiption:用户类--接口
 *@author:liys
 *@since:2014-12-15
 *@corp:cheletong
 *
 */
@interface UserModel : BaseDaoModel

#pragma mark 姓名属性
@property (nonatomic,copy)NSString *name;

#pragma mark 年龄属性
@property (nonatomic,copy)NSString *age;

#pragma mark 头像属性
@property (nonatomic,copy)NSString *icon;

#pragma mark 等级
@property (nonatomic,copy)NSString *level;

#pragma mark 积分
@property (nonatomic,copy)NSString *point;

@end
