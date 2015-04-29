//
//  PayIndexModel.m
//  WashCar
//
//  Created by yangyixian on 15/1/12.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//   支付下单首页模型

#import "PayIndexModel.h"

@implementation PayIndexModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.carId =(int)dict[@"carId"];
        self.address = dict[@"hisAddrContent"];
        self.carPlateNum = dict[@"carPlateNum"];
        self.userPhone = dict[@"userAccount"];
    }
    return self;
}
//构造方法
+ (instancetype)orderWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end