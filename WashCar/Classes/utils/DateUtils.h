//
//  DateUtils.h
//  NaChe
//  日期工具类
//  Created by nachebang on 14-10-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

#pragma mark 获取今天对应的日期字符串，格式未yyyyMMddHHmmss
+(NSString*)nowForString;

#pragma mark 格式化日期
+(NSString*)formatDate:(NSDate*)date format:(NSString*)format;

#pragma mark 将日期字符串转换成date
+(NSDate*)convertStrToDate:(NSString*)dateStr format:(NSString*)format;

#pragma mark 将日期转化为:刚刚、几分钟前、几天前
+(NSString*)dateFormatString : (NSString*) stringDate;

#pragma mark 将一种格式的日期转换成另一种日期格式
+(NSString*)formatDateStr:(NSString*)dateStr srcDateFormat:(NSString*)srcDateFormat targetDateFormat:(NSString*)targetDateFormat;

@end
