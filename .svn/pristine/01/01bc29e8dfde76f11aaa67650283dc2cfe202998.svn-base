//
//  UserDao.m
//  WashCar
//
//  Created by yanshengli on 14-12-30.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import "UserDao.h"
#import "UserModel.h"
#import "NSObject+Utility.h"
#import "NSString+Utility.h"
#import "TablePropertyModel.h"

/***
 *
 *@descroiption:用户dao--实现
 *@author:liys
 *@since:2014-12-15
 *@corp:cheletong
 *
 */
@implementation UserDao

#pragma mark 获取创建表的sql
-(NSString *)createTbSql{
    return [self createTbSql:[self tableClass]];
}

#pragma mark 查询用户信息
-(NSMutableArray*)queryUsers:(NSString*)sql conditions:(NSDictionary*)conditions
{
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([self createTableByClass:[self tableClass]])
    {
        [self executeQuery:sql dictParams:conditions callback:^(FMResultSet *resultSet, NSArray *columnNames) {
            while (resultSet.next) {
                NSMutableDictionary *item = [NSMutableDictionary dictionary];
                for (int index = 0 ; index < columnNames.count; index++) {
                    NSString *columnName = [columnNames objectAtIndex:index];
                    NSString *columnValue = [resultSet stringForColumn: columnName];
                    if (!columnValue) {
                        columnValue = @"";
                    }
                    [item setObject:columnValue forKey:columnName];
                }
                
                [resultArray addObject:item];
            }
        }];
    }
    return resultArray;
}

#pragma mark 保存用户信息
-(void)saveUser:(UserModel*)user
{
    if ([self createTableByClass:[self tableClass]])
    {
        [self executeUpdate:[self baseSaveSql:user] dictParams:[user toDicIncludeSuper:YES]];
    }
}

#pragma mark 获取表结构对应的类对象
-(Class)tableClass{
    return [UserModel class];
}
@end
