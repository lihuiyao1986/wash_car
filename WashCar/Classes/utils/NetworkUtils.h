//
//  NetworkUtils.h
//  yntv
//
//  Created by Black.Lee on 4/17/13.
//
//

#import <Foundation/Foundation.h>

@interface NetworkUtils : NSObject
+ (BOOL) isReachable;
+ (NSString *) strNetworkType;

+ (BOOL) isNotUsingWifi;
+ (BOOL) isUsingWifi;
@end

#ifndef networkTypes
#define networkTypes

#define networkType3G @"3G";
#define networkTypeNone @"NONE";
#define networkTypeWifi @"WIFI";

#endif