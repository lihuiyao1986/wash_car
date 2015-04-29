//
//  NSObject+NacheUtility.h
//  NaChe
//
//  Created by yanshengli on 14-12-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utility)

#pragma 获取对象的类名
- (NSString *)className;

#pragma 获取对象的属性列表--不包含父类的属性
- (NSArray*)propertyList;

#pragma 获取对象的属性列表
- (NSArray*)propertyListIncludeSuper:(BOOL)includeSuper;

#pragma 将对象转换成列表
- (NSDictionary*)toDic;

#pragma 将对象转换成列表
- (NSDictionary*)toDicIncludeSuper:(BOOL)includeSuper;

#pragma 将对象转换成列表
- (NSDictionary*)toDicIncludeSuper:(BOOL)includeSuper skipNull:(BOOL)skipNull;

#pragma 将一个dict转换成对象
-(void)dicForObject:(NSDictionary*)dict;

@end
