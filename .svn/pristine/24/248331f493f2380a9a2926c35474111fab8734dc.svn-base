//
//  CarlocationModel.m
//  WashCar
//
//  Created by mac on 15/1/8.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "CarlocationModel.h"
#import "TablePropertyModel.h"

@implementation CarlocationModel

-(NSMutableDictionary *)tableProperties
{
    //存放表属性的字典
    NSMutableDictionary *dict = [super tableProperties];
    
    //车位置字段
    TablePropertyModel *nameProperty = [[TablePropertyModel alloc]init];
    nameProperty.fieldname = @"carLocationAddress";
    nameProperty.fieldvalue = self.carLocationAddress;
    nameProperty.fieldtype = sqlite_field_type_text;
    [dict setObject:nameProperty forKey:nameProperty.fieldname];
    
    return dict;
}

@end
