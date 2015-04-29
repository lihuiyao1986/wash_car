//
//  GXDao.m
//  WashCar
//
//  Created by loki on 15/1/19.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "GXDao.h"
#import "NSObject+Utility.h"
#import "NSString+Utility.h"
#import "TablePropertyModel.h"

@implementation GXDao

#pragma mark 获取创建表的sql
-(NSString *)createTbSql{
    return [self createTbSql:[self tableClass]];
}

#pragma mark 查询个推消息
-(NSMutableArray*)queryGXNotice:(NSString*)sql conditions:(NSDictionary*)conditions
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

#pragma mark 保存个推消息
-(void)saveGXNotice:(GXModel*)user
{
    if ([self createTableByClass:[self tableClass]])
    {
        [self executeUpdate:[self baseSaveSql:user] dictParams:[user toDicIncludeSuper:YES]];
    }
}

#pragma mark 获取表结构对应的类对象
-(Class)tableClass{
    return [GXModel class];
}

@end
