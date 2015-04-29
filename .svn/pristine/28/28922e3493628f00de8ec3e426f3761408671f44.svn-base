//
//  RequestHeader.m
//  NaChe
//
//  Created by nachebang on 14-10-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "RequestParams.h"
#import "DateUtils.h"
#import "OpenUDID.h"
#import "Md5Utils.h"
#import "CommonUtils.h"

@interface RequestParams()
@end
@implementation RequestParams
- (id)initWithUrl:(NSString *)reqUrl
{
    self = [super init];
    if (self)
    {
        self.random = [[CommonUtils obtainReqRandom] description];//随机数
        self.version = REQUEST_VERSION;//版本号
        self.timestamp = [DateUtils nowForString];//时间戳
        self.token = [CommonUtils userToken];//用户的token
        self.uuid = [OpenUDID value];//请求对应的唯一串
        self.url = reqUrl;//请求url
        self.userAgent = [UserAgentUtils getUserAgent];
        NSString *checkValue = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@",self.version,self.timestamp,self.token,self.random,self.uuid,self.url,self.userAgent];
        self.sign = [Md5Utils md5:[NSString stringWithFormat:@"%@%@",[Md5Utils md5:checkValue],[Md5Utils md5:REQUEST_ENCRYPT_KEY]]];
    }
    return self;
}
@synthesize uuid;
@synthesize random;
@synthesize sign;
@synthesize version;
@synthesize timestamp;
@synthesize token;
@synthesize url;
@synthesize userAgent;
-(NSMutableDictionary *) getRequestHeaderParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.random forKey:@"randomOnce"];
    [params setObject:self.version forKey:@"version"];
    [params setObject:self.token forKey:@"userUuid"];
    [params setObject:self.sign forKey:@"signature"];
    [params setObject:self.timestamp forKey:@"timestamp"];
    [params setObject:self.uuid forKey:@"uuid"];
    [params setObject:self.url forKey:@"methodUrl"];
    [params setObject:self.userAgent forKey:@"userAgent"];
    return params;
}
@end
