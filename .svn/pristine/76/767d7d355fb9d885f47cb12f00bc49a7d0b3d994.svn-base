//
//  NSString+Utility.h
//  NaChe
//
//  Created by yanshengli on 14-11-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Utility)

/**
 *根据要显示的text动态计算其高度
 */
- (CGFloat)contentCellHeightWithWidth:(CGFloat)fixedWidth andFont:(UIFont*)font;

/**
 *  @brief  检查邮箱名是否合法
 *
 *  @return 是否合法
 */
- (BOOL) isValidEmail;

/**
 *  @brief  检查是否是url
 *
 *  @return 是否合法
 */
- (BOOL) isUrl;

/**
 *  @brief  检查用户名是否合法
 *
 *  @return 是否合法
 */
- (BOOL) isValidUserName;

/**
 *  @brief  检查管理员账号是否合法
 *
 *  @return 是否合法
 */
- (BOOL) isValidAdminName;

/**
 *  @brief  检查其他名称是否合法
 *
 *  @return 是否合法
 */
- (BOOL) isValidOtherName;

/**
 *  @brief  检查手机号是否合法
 *
 *  @return 是否合法
 */
- (BOOL) isValidMobileNumber;

/**
 *  @brief  检查车牌号是否合法
 *
 *  @return 是否合法
 */

-(BOOL)isValidCarNumber;
/**
 *  @brief  手机号是否合法
 *
 *  @return 是否合法
 */
- (BOOL)isValidPhoneNumber;

/**
 *  @brief  检查用户账号是否合法
 *
 *  @return 是否合法
 */
- (BOOL)isValidAccountName;

/**
 *  @brief  检查密码是否合法
 *
 *  @return 是否合法
 */
- (BOOL)isValidPassword;

/**
 *  @brief  检查外链设置密码是否合法 // add by qjl 2014-01-21
 *
 *  @return 是否合法
 */
- (BOOL)isValidlinkSetPassword;

/**
 *  @brief  检查是否为纯数字
 *
 *  @return 是否合法
 */
- (BOOL)isValidNumber;

/**
 *  @brief  检查文件名是否有效
 *
 *  @return 是否有效
 */
- (BOOL)isValidFileName;

/**
 *  @brief  去除空格
 *
 *  @return  去除空格后的字符串
 */
-(NSString *)trimNull;

/**
 *  @brief  是否是短信验证码
 *
 *  @return
 */
-(BOOL)isSmsAuthcode;

/**
 * @brief 是否是合法的url
 *
 *  @return
 */
-(BOOL)isValidUrl;

#pragma mark 动态计算字符串的宽度
- (float) widthForStrWithFontSize: (UIFont*)fontSize andHeight: (float)height;

#pragma mark 动态计算字符串的高度
- (float) heightForStrWithFontSize: (UIFont*)fontSize andWidth: (float)width;
@end
