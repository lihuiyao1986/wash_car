//
//  NetworkUtils.m
//  yntv
//
//  Created by Black.Lee on 4/17/13.
//
//

#import "NetworkUtils.h"
#import "MyReachability.h"

@implementation NetworkUtils
double lastDetectTime = 0;
NetworkStatus lastStatus;
// ReachableViaWWAN => 3G/Edge
+ (NetworkStatus) networkType {
    double now = [[NSDate date] timeIntervalSince1970];
    if (now - lastDetectTime < 60) {
        return lastStatus;
    }
    MyReachability *r = [MyReachability reachabilityWithHostName:@"www.baidu.com"];
    lastDetectTime = now;
    lastStatus = [r currentReachabilityStatus];
    return lastStatus;
}

+ (NSString *) strNetworkType {
    NetworkStatus status = [self networkType];
    NSString *str = networkType3G;
    switch (status) {
        case NotReachable: str = networkTypeNone; break;
        case ReachableViaWiFi: str = networkTypeWifi; break;
        case ReachableViaWWAN: str = networkType3G; break;
    }
    return str;
}

+ (BOOL) isReachable {
//    if (DEBUG) return YES;
    NetworkStatus status = [self networkType];
    BOOL reachable = NO;
    switch (status) {
        case NotReachable: break;
        case ReachableViaWiFi: reachable = YES; break;
        case ReachableViaWWAN: reachable = YES; break;
    }
    return reachable;
}

+ (BOOL) isUsingWifi {
//    if (DEBUG) return NO;
    return [self networkType] == ReachableViaWiFi;
}

+ (BOOL) isNotUsingWifi {
//    if (DEBUG) return YES;
//    BOOL usingWifi = YES;
//    if (![self isReachable]) {
//        usingWifi = NO;
//    }
//    if (!usingWifi) {
//        usingWifi = (lastStatus == ReachableViaWiFi);
//    }
//    return !usingWifi;
    NetworkStatus status = [self networkType];
    return status == NotReachable || status == ReachableViaWWAN;
}
@end
