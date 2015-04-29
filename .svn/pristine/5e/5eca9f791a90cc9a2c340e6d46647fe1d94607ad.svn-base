//
//  NSString+JSONCategories.m
//  NaChe
//
//  Created by yanshengli on 14-12-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NSString+JSONCategories.h"

@implementation NSString (JSONCategories)
#pragma 将json字符串转换成NSArray或者是NSDictionary
-(id)JSONValue{
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (error == nil && result != nil){
        return result;
    }
    return nil;
}
@end
