//
//  CarlocationDao.m
//  WashCar
//
//  Created by mac on 15/1/8.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "CarlocationDao.h"
#import "NSObject+Utility.h"
#import "NSString+Utility.h"
#import "TablePropertyModel.h"

@implementation CarlocationDao

#pragma mark 获取创建表的sql
-(NSString *)createTbSql{
    return [self createTbSql:[self tableClass]];
}

#pragma mark 查询车辆位置信息
-(NSMutableArray*)queryCarlocation:(NSString *)sql conditions:(NSDictionary *)conditions
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

#pragma mark - 时间倒叙排序
-(NSMutableArray*)queryCarlocationByTime
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ order by modifyTime desc",NSStringFromClass([self tableClass])];
    return [self queryCarlocation:sql conditions:nil];
}


#pragma mark - 更新modifyTime
- (BOOL) updateAddress:(NSString*)address
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set modifyTime = :modifyTime where carLocationAddress =:carLocationAddress",NSStringFromClass([self tableClass])];
    BOOL flag = [self executeUpdate:sql dictParams:[NSDictionary dictionaryWithObjectsAndKeys:[DateUtils nowForString],@"modifyTime",address,@"carLocationAddress", nil]];
    return flag;
}

#pragma mark - 查重
-(BOOL)addressExists:(NSString*)address
{
    __block int count = 0;
    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where carLocationAddress = :address",NSStringFromClass([self tableClass])];
    [self executeQuery:sql dictParams:[NSDictionary dictionaryWithObjectsAndKeys:address,@"address", nil] callback:^(FMResultSet *resultSet, NSArray *columnNames) {
        if (resultSet.next) {
            count = [resultSet intForColumnIndex:0];
        }
    }];
    return count > 0;
}

#pragma mark 保存车辆位置信息
-(void)saveCarlocation:(CarlocationModel *)location
{
    if ([self createTableByClass:[self tableClass]])
    {
        [self executeUpdate:[self baseSaveSql:location] dictParams:[location toDicIncludeSuper:YES]];
    }
}

#pragma mark 获取表结构对应的类对象
-(Class)tableClass{
    return [CarlocationModel class];
}

@end