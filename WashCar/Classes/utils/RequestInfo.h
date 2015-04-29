//
//  GlobalDefine.h
//  CustomNavigationBarDemo
//
//  Created by liys on 14-1-6.
//  Copyright (c) 2014年 Jimple Chen. All rights reserved.
//


/***************** 请求相关的信息 *******************/
//#define BASE_HOST @"http://192.168.16.119:9988/mobile/" //正式环境，服务器地址
//#define BASE_HOST @"http://192.168.1.184:8080/user/" //正式环境，服务器地址
//#define BASE_HOST @"http://192.168.1.70:8080/user/" // 内网
#define BASE_HOST @"http://122.224.135.226:8089/user/" // 外网
#define HTTP_REQUEST_METHOD_POST @"POST"//请求方法－post请求
#define DEFAULT_REQUEST_ERROR_MESSAGE @"对不起，服务器忙，稍后重试..."//默认请求失败的描述

#define REQUEST_VERSION @"1.0.0"//请求版本号
#define REQUEST_ENCRYPT_KEY @"0123456789"//请求参数加密的密钥


//~~~~~~~~~~~~~~~~~~~请求路径~~~~~~~~~~~~~~~~~~~~~~~~~//
#define verifyMobileUrl @"v1/consumer/user/verify_mobile"//手机号验证（登录、注册）
#define smsCodeGetUrl @"v1/consumer/user/get_sms_code"//获取短信验证码
#define orderStatusGetUrl @"v1/consumer/order/get_order_status"//获取订单状态
#define autoLoginUrl @"v1/consumer/user/auto_login"//自动登录
#define placeOrderUrl @"v1/consumer/order/place_order"//下单
#define confirmWashUrl @"v1/consumer/order/confirm_wash"//确认洗车
#define confirmOrderUrl @"v1/consumer/order/confirm_order"//确认订单
#define orderPhotoGetUrl @"v1/consumer/order/get_order_photo"//获取洗车照片
#define postClientIDUrl @"/v1/consumer/user/add_user_client"//上传clientID
