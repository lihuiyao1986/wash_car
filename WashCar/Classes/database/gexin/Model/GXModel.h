//
//  GXModel.h
//  WashCar
//
//  Created by loki on 15/1/19.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseDaoModel.h"

@interface GXModel : BaseDaoModel

@property (assign , nonatomic) BOOL noticeIsRead; // 用户是否读取消息

@property (copy , nonatomic) NSString* noticeContent; // 消息内容

@property (copy , nonatomic) NSString* noticeType; // 消息类型

@property (copy , nonatomic) NSString* noticeTitle; // 消息标题

@property (copy , nonatomic) NSString* noticeTime; // 消息时间

@end
