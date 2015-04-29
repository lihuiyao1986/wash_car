//
//  LocationCacheModel.m
//  WashCar
//
//  Created by mac on 15/1/9.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "LocationCacheModel.h"

@implementation LocationCacheModel

+ (id) modelWithDic:(NSDictionary*) dic
{
    return [[self alloc] initWithDic:dic];
}

- (id) initWithDic:(NSDictionary*) dic
{
    if (self = [super init])
    {
        if (dic == nil)
        {
            return self;
        }
        self.modelAddress = [dic objectForKey:@"carlocationaddress"];
        self.modelIcon = [UIImage imageNamed:@"historicalRecord.png"];
        self.modelLine = [UIImage imageNamed:@"line.png"];
    }
    return self;
}

+ (id) modelWithDicFromBaiduApi:(NSDictionary*) dic
{
    return [[self alloc] initWithDicFromBaiduApi:dic];
}

- (id) initWithDicFromBaiduApi:(NSDictionary*) dic
{
    if (self = [super init])
    {
        if (dic == nil)
        {
            return self;
        }
        self.modelAddress = [dic objectForKey:@"name"];
        self.modelIcon = [UIImage imageNamed:@""];
        self.modelLine = [UIImage imageNamed:@"line.png"];
    }
    return self;
}

@end
