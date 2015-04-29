//
//  DateUtils.m
//  NaChe
//
//  Created by nachebang on 14-10-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

#pragma mark 获取今天对应的日期字符串，格式未yyyyMMddHHmmss
+(NSString*)nowForString
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [format stringFromDate:[NSDate date]];
}

#pragma mark 格式化日期
+(NSString*)formatDate:(NSDate*)date format:(NSString*)format
{
    if ([CommonUtils isStrEmpty:format])
    {
        format = @"yyyyMMddHHmmss";
    }
     NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

#pragma mark 将一种格式的日期转换成另一种日期格式
+(NSString*)formatDateStr:(NSString*)dateStr srcDateFormat:(NSString*)srcDateFormat targetDateFormat:(NSString*)targetDateFormat
{
    return [DateUtils formatDate:[DateUtils convertStrToDate:dateStr format:srcDateFormat] format:targetDateFormat];
}

#pragma mark 将日期字符串转换成date
+(NSDate*)convertStrToDate:(NSString*)dateStr format:(NSString*)format
{
    if ([CommonUtils isStrEmpty:format])
    {
        format = @"yyyyMMddHHmmss";
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    return [dateFormat dateFromString:dateStr];
}

#pragma mark 将日期转化为:刚刚、几分钟前、几天前
+(NSString*)dateFormatString : (NSString*) stringDate
{
    NSString * timeString = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *d = [dateFormatter dateFromString:stringDate];
    NSTimeInterval late = [d timeIntervalSince1970]*1;
   
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = now - late;
    
    if (cha/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num= [timeString intValue];
        if (num <= 1) {
            timeString = [NSString stringWithFormat:@"刚刚..."];
        }else{
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    
    if (cha/86400 > 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num = [timeString intValue];
        //把天折算成秒
        NSTimeInterval secondPerDay = 24*60*60;
        NSCalendar * calendar = [NSCalendar currentCalendar];
        unsigned uintFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        if (num < 2) {
            NSDate * yesterDay = [NSDate dateWithTimeIntervalSinceNow:-secondPerDay];
            NSDateComponents * souretime = [calendar components:uintFlags fromDate:d];
            NSDateComponents * yesterday = [calendar components:uintFlags fromDate:yesterDay];
            if (souretime.year == yesterday.year && souretime.month == yesterday.month && souretime.day == yesterday.day){
                [dateFormatter setDateFormat:@"HH:mm"];
                timeString = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:d]];
            }
        }else if(num == 2){
            NSDate * beforeYesterDay = [NSDate dateWithTimeIntervalSinceNow:-2*secondPerDay];
            NSDateComponents * beforeSouretime = [calendar components:uintFlags fromDate:d];
            NSDateComponents * beforeYesterday = [calendar components:uintFlags fromDate:beforeYesterDay];
            if (beforeSouretime.year == beforeYesterday.year && beforeSouretime.month == beforeYesterday.month && beforeSouretime.day == beforeYesterday.day){
                [dateFormatter setDateFormat:@"HH:mm"];
                timeString = [NSString stringWithFormat:@"前天 %@",[dateFormatter stringFromDate:d]];
            }
            //timeString = [NSString stringWithFormat:@"" ];
        }else if (num > 2 && num <7){
            timeString = [NSString stringWithFormat:@"%@天前", timeString];
        }else if (num >= 7 && num <= 10) {
            timeString = [NSString stringWithFormat:@"1周前"];
        }else if(num > 10 && num <= 365){
            [dateFormatter setDateFormat:@"M月d日"];
            NSString *dateMd = [dateFormatter stringFromDate:d];
            timeString = [NSString stringWithFormat:@"%@", dateMd];
        }else if(num > 365){
            [dateFormatter setDateFormat:@"yy年M月d日"];
            NSString *dateYMD = [dateFormatter stringFromDate:d];
            timeString = [NSString stringWithFormat:@"%@", dateYMD];
        }
     }
   return timeString;
}

@end
