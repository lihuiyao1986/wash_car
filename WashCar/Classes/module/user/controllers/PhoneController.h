//
//  PhoneController.h
//  WashCar
//
//  Created by yangyixian on 15/1/5.
//  Copyright (c) 2015年 cheletong. All rights reserved.
//

#import "BaseController.h"

typedef void(^block)(NSString * str) ;

@interface PhoneController : BaseController

@property (nonatomic,copy)block blocks;

@end
