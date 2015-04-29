//
//  NSObject+JSONCategories.m
//  NaChe
//
//  Created by yanshengli on 14-12-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NSObject+JSONCategories.h"

@implementation NSObject (JSONCategories)

#pragma 将对象转换成NSData对象
-(NSData*)JSONToData{
    NSError* error = nil;
    id result = nil;
    @try {
       result  = [NSJSONSerialization dataWithJSONObject:self
                                                    options:kNilOptions error:&error];
    }@catch (NSException *exception) {
        result = nil;
    }
    if (error!= nil){
        return result;
    }
    return result;
}

#pragma 将json对象转换成字符串
-(NSString*)JSONToStr{
    return [[NSString alloc]initWithData:[self JSONToData] encoding:NSUTF8StringEncoding];
}
@end
