//
//  CarlocationDao.h
//  WashCar
//
//  Created by mac on 15/1/8.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseDao.h"
#import "CarlocationModel.h"

@interface CarlocationDao : BaseDao

#pragma mark 查询车辆位置信息
-(NSMutableArray*)queryCarlocation:(NSString*)sql conditions:(NSDictionary*)conditions;

#pragma mark 保存车辆位置信息
-(void)saveCarlocation:(CarlocationModel*)location;

// 判断是否重复
-(BOOL)addressExists:(NSString*)address;

// 更新time
- (BOOL) updateAddress:(NSString*)address;

// 按时间倒叙排序
-(NSMutableArray*)queryCarlocationByTime;

@end
