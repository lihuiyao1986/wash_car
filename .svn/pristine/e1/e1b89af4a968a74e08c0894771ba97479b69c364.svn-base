//
//  PayIndexModel.h
//  WashCar
//
//  Created by yangyixian on 15/1/12.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//  description:支付首页数据模型

#import "BaseModel.h"

@interface PayIndexModel : BaseModel
@property(nonatomic,assign) int carId;//车辆编号
@property (nonatomic, copy) NSString *address; //洗车地址
@property (nonatomic, copy) NSString *carLongitude;//车辆经度
@property (nonatomic, copy) NSString *carLatitude;//车辆纬度
@property (nonatomic, copy) NSString *carPlateNum; //车牌信息
@property (nonatomic,copy)NSString *userPhone;//手机号

//初始化字典模型
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)orderWithDict:(NSDictionary *)dict;

//carId = 10001;
//carPlateNum = "\U6d59A12345";
//hisAddrContent = "\U5723\U82d1\U5317\U885715\U53f7\U95e8\U53e3";
//hisAddrId = 10002;
//userAccount = 13965899969;
//userEncrypt = encrypt;
//userId = 1;
//userName = "";
//userNickName = "";
//userUuid = uuid;

@end
