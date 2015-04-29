//
//  RequestHeader.h
//  NaChe
//
//  Created by nachebang on 14-10-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestParams : NSObject{
    NSString *token;//令牌
    NSString *uuid;//唯一标识
    NSString *random;//随机数
    NSString *timestamp;//时间戳
    NSString *version;//版本号
    NSString *url;//请求url
    NSString *sign;//密文
    NSString *userAgent;//用户代理
}
@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *uuid;
@property(nonatomic,copy) NSString *random;
@property(nonatomic,copy) NSString *timestamp;
@property(nonatomic,copy) NSString *version;
@property(nonatomic,copy) NSString *sign;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *userAgent;

//获取请求头信息
-(NSMutableDictionary *) getRequestHeaderParams;
- (id)initWithUrl:(NSString *)reqUrl;
@end
