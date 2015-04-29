//
//  UserDao.h
//  WashCar
//
//  Created by yanshengli on 14-12-30.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "UserModel.h"

/***
 *
 *@descroiption:用户dao--接口
 *@author:liys
 *@since:2014-12-15
 *@corp:cheletong
 *
 */
@interface UserDao : BaseDao

#pragma mark 查询用户信息
-(NSMutableArray*)queryUsers:(NSString*)sql conditions:(NSDictionary*)conditions;

#pragma mark 保存用户信息
-(void)saveUser:(UserModel*)user;

@end
