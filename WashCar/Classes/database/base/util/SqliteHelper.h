//
//  SqliteHelper.h
//  email:shiming209@qq.com
//
//  Created by apple on 13-6-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

//页面数据缓存编码
#define PAGE_INDEX 1001

@interface SqliteHelper : NSObject
{
    sqlite3 *_database;
}

@property (nonatomic) sqlite3 *_database;


-(void) createTables;



////////////////////////////////
-(BOOL) cleanPageJson;
-(BOOL) removePageJson:(int)page;
-(BOOL) pageJsonExpired:(int)page;
-(NSDictionary *) getJsonData:(int)page;
-(NSArray *) getJsonListData:(int)page;
-(BOOL) insertPageJson:(NSDictionary *)data page:(int)page;
-(BOOL) insertPageListJson:(NSArray *)jsondict page:(int)page;


@end
