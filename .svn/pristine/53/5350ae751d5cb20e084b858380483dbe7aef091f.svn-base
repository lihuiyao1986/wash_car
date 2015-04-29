//
//  Md5Utils.m
//  MiniCar
//
//  Created by apple on 14-8-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Md5Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Md5Utils

+ (NSString *)md5:(NSString *)str
{
    if(str==nil||str.length==0){
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    NSString *md5str=[NSString stringWithFormat:
                      @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    NSString *s = [md5str uppercaseStringWithLocale:[NSLocale currentLocale]];
    
    return s;
}

@end
