//
//  NacheDBHelper.m
//  NaChe
//
//  Created by yanshengli on 14-12-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DBHelper.h"

/***
 *
 *@descroiption:数据库工具类--实现
 *@author:liys
 *@since:2014-12-15
 *@corp:cheletong
 *
 */
@implementation DBHelper

#pragma mark 单类实现
single_implementation(DBHelper);

#pragma mark 数据库实体
@synthesize databaseQueue = _databaseQueue;

#pragma mark 获取数据库文件的路径
- (NSString *)databaseFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    return [documentPath stringByAppendingPathComponent:databaseFile];
}

#pragma mark 创建数据库
-(FMDatabaseQueue*)databaseQueue
{
    if (!_databaseQueue)
    {
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self databaseFilePath]];
    }
    return _databaseQueue;
}
@end
