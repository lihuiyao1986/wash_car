//
//  NSObject+NacheUtility.m
//  NaChe
//
//  Created by yanshengli on 14-12-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NSObject+Utility.h"
#import <objc/runtime.h>

@implementation NSObject (Utility)

#pragma 获取对象对应的类名
- (NSString *)className{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

#pragma 获取对象的属性列表
- (NSArray*)propertyList{
    return [self propertyListIncludeSuper:NO];
}

#pragma 获取对象的属性列表
- (NSArray*)propertyListIncludeSuper:(BOOL)includeSuper{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    if (includeSuper && ![[[self superclass] description] isEqualToString:NSStringFromClass([NSObject class])])
    {
        [propertyArray addObjectsFromArray:[[[self superclass] new] propertyList]];
    }
    return propertyArray;
}

#pragma 将对象转换成列表
- (NSDictionary*)toDic{
    return [self toDicIncludeSuper:NO];
}

#pragma 将对象转换成列表
- (NSDictionary*)toDicIncludeSuper:(BOOL)includeSuper{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray *propertyList = [self propertyListIncludeSuper:includeSuper];
    for (NSString *key in propertyList) {
        id value = [self valueForKey:key];
        value = (value == nil) ? [NSNull null] : value;
        [dict setObject:value forKey:key];
    }
    return dict;
}

#pragma 将对象转换成列表
- (NSDictionary*)toDicIncludeSuper:(BOOL)includeSuper skipNull:(BOOL)skipNull{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray *propertyList = [self propertyListIncludeSuper:includeSuper];
    for (NSString *key in propertyList) {
        id value = [self valueForKey:key];
        if (skipNull && !value)
        {
            continue;
        }
        else
        {
            value = (value == nil) ? [NSNull null] : value;
        }
        [dict setObject:value forKey:key];
    }
    return dict;
}

#pragma 将一个dict转换成对象
-(void)dicForObject:(NSDictionary*)dict{
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        if (value == [NSNull null]) {
            continue;
        }
        if ([value isKindOfClass:[NSDictionary class]]) {
            id subObj = [self valueForKey:key];
            if (subObj){
                [subObj dicForObject:value];
            }
        }else{
            [self setValue:value forKeyPath:key];
        }
    }
}


@end
