//
//  User.m
//  WashCar
//
//  Created by yanshengli on 14-12-30.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import "UserModel.h"
#import "TablePropertyModel.h"

/***
 *
 *@descroiption:用户类--实现
 *@author:liys
 *@since:2014-12-15
 *@corp:cheletong
 *
 */
@implementation UserModel
@synthesize name;
@synthesize age;
@synthesize icon;
@synthesize level;
@synthesize point;

#pragma mark 表属性
-(NSMutableDictionary*)tableProperties
{
    //存放表属性的字典
    NSMutableDictionary *dict = [super tableProperties];
    
    //姓名字段
    TablePropertyModel *nameProperty = [[TablePropertyModel alloc]init];
    nameProperty.fieldname = @"name";
    nameProperty.fieldvalue = self.name;
    nameProperty.fieldtype = sqlite_field_type_text;
    [dict setObject:nameProperty forKey:nameProperty.fieldname];
    
    //年龄字段
    TablePropertyModel *ageProperty = [[TablePropertyModel alloc]init];
    ageProperty.fieldname = @"age";
    ageProperty.fieldvalue = self.age;
    ageProperty.fieldtype = sqlite_field_type_integer;
    [dict setObject:ageProperty forKey:ageProperty.fieldname];
    
    //头像字段
    TablePropertyModel *iconProperty = [[TablePropertyModel alloc]init];
    iconProperty.fieldname = @"icon";
    iconProperty.fieldtype = sqlite_field_type_text;
    iconProperty.fieldvalue = self.icon;
    [dict setObject:iconProperty forKey:iconProperty.fieldname];
    
    TablePropertyModel *levelProperty = [[TablePropertyModel alloc]init];
    levelProperty.fieldname = @"level";
    levelProperty.fieldtype = sqlite_field_type_text;
    levelProperty.fieldvalue = self.level;
    [dict setObject:levelProperty forKey:levelProperty.fieldname];
    
    
    TablePropertyModel *pointProperty = [[TablePropertyModel alloc]init];
    pointProperty.fieldname = @"point";
    pointProperty.fieldtype = sqlite_field_type_text;
    pointProperty.fieldvalue = self.point;
    [dict setObject:pointProperty forKey:pointProperty.fieldname];
    return dict;
}
@end
