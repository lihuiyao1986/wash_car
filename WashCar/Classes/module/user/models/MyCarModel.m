//
//  MyCarModel.m
//  WashCar
//
//  Created by mac on 15/1/5.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "MyCarModel.h"

@implementation MyCarModel

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
        self.modelCarColor = dic[@"carColor"];
        self.modelCarImgURL = dic[@"carURL"];
        self.modelCarLicensePlate = dic[@"carLicensePlate"];
        self.modelCarType = dic[@"carType"];
    }
    return self;
}

@end
