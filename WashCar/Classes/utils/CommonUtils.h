//
//  CommonUtils.h
//  NaChe
//
//  Created by nachebang on 14-10-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义URL的枚举类型
typedef NS_ENUM(NSInteger, URLTYPE) {
    MAPURL = 1, //1 1 1
    EMAILURL = 1 << 1, //2 2 10 转换成 10进制 2
    TELURL = 1 << 2, //4 3 100 转换成 10进制 4
    SMSURL = 1 << 3, //8 4 1000 转换成 10进制 8
    WEBURL = 1 << 4 //16 5 10000 转换成 10进制 16
};

@interface CommonUtils : NSObject

#pragma mark 获取发送给服务端请求的随机数(随机数范围在1～1000)
+(NSNumber*)obtainReqRandom;

#pragma mark 保存手机唯一标识（保存在keychain）
+(void)insertMobileUUID;

#pragma mark 获取手机的唯一标识
+(NSString*)mobileUUID;

#pragma mark 获取用户的token信息
+(NSString*)userToken;

#pragma mark 获取登录后的用户信息
+(NSDictionary*)loginUser;

#pragma mark 删除用户的token信息
+(void)deleteUserLoginToken;

#pragma mark 删除登录后的用户信息
+(void)deleteLoginUser;

#pragma mark 保存新的用户token信息
+(void)saveOrUpdateUserToken:(NSString *)newToken;

#pragma mark 保存登录后的用户信息
+(void)saveOrUpdateLoginUser:(NSDictionary*)loginUser;

#pragma mark 隐藏或显示uiview
+ (void)viewAnimation:(UIView*)view willHidden:(BOOL)hidden;

#pragma mark 从资源文件中获取数据
+ (NSArray *)retrieveDataSourceFromPath:(NSString *)resourceName ofType:(NSString *)resourceType atRootKeyPath:(NSString *)keyPath;

#pragma mark 视图截图
+ (UIImage*)saveSnapshotInView:(UIView *)view withSize:(CGSize)size;

#pragma mark 视图截图
+ (UIImage*)saveSnapshotInView:(UIView *)view;

#pragma mark 打开对应的url
+(void)openUrl:(NSString*)url urltype:(URLTYPE)urlType;

#pragma mark 图片缩放
+ (UIImage *)resizeImage:(UIImage *)image toTargetSize:(CGSize)size;

#pragma mark 重置uitableviewcell的contentview
+ (void)resetTableCellContentSubviews:(UITableViewCell*)tableviewCell;

#pragma mark 去除父视图中所有的子视图
+ (void)removeSubviews:(UIView*)view;

#pragma mark 对视图使用动画
+ (void)animationView:(UIView *)changeView withFrame:(CGRect)frame animation:(CGFloat )animation;

#pragma mark 计算字符串长度
+ (int)textLength:(NSString *)text;

#pragma mark 显示本地通知
+ (void)showNotificationWithAction:(NSString *)action andContent:(NSString *)content;

#pragma mark 获取xmpp对应的用户id
+ (NSString *)getXmppUserid;

#pragma mark 获取xmpp对应的密码
+ (NSString *)getXmppPassword;

#pragma mark 获取xmpp的服务器地址
+ (NSString *)getXmppHostName;

#pragma mark 获取nativePageConfig数据
+ (NSMutableDictionary*)nativePageConfig;

#pragma mark 判断字符串是否为空
+ (BOOL)isStrEmpty:(NSString*)str;

#pragma mark 获取washCarBtn
+(UIButton*)washCarBtn:(CGRect)frame;

#pragma mark 是否有订单的状态
+(BOOL)hasOrderStatus;

#pragma mark 保存或更新是否有订单的状态
+(void)saveOrUpdateOrderStatus:(BOOL)status;

#pragma mark 保存个信的clientid
+(void)saveGexinClientId:(NSString*)clientId;

#pragma mark 获取个信的clientId
+(NSString*)gexinClientId;

@end

