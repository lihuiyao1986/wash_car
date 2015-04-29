//
//  LoginController.h
//  WashCar
//
//  Created by yanshengli on 14-12-19.
//  Copyright (c) 2014年 cheletong. All rights reserved.
//

#import "BaseController.h"

#pragma mark 登录成功后回调
typedef void (^LoginSucessBlock)(NSString *mobileno,NSMutableDictionary *userinfo);

/***
 *
 *@description:登录和注册页面--接口
 *@author:liys
 *@since:2014-1-8
 *@corp:cheletong
 */
@interface LoginController : BaseController

#pragma mark 手机号--通过别的页面传过来
@property (nonatomic,copy)NSString *mobileNo;

#pragma mark 登录成功后的回调
@property (nonatomic,strong)LoginSucessBlock sucessCallBack;

#pragma mark 导航栏中间标题
@property (nonatomic,copy)NSString *navCenterTitle;

@end
