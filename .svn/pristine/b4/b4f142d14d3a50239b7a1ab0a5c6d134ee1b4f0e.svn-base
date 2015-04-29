//
//  NSString+Utility.m
//  NaChe
//
//  Created by yanshengli on 14-11-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString(Utility)

#pragma mark 根据要显示的text计算label高度
- (CGFloat)contentCellHeightWithWidth:(CGFloat)fixedWidth andFont:(UIFont*)font
{
    //设置字体 注：这个宽：fixedWidth 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    CGSize size = CGSizeMake(fixedWidth, CGFLOAT_MAX);
    if (IOS7){
        //IOS 7.0 以上
        NSDictionary * tdic =  [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        size =[self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }else{
        //ios7以上已经摒弃的这个方法
        size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    }
    return size.height;
}

#pragma mark 去除空格
-(NSString *)trimNull{
    if (self) {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    return self;
}

#pragma mark 判断是否是url
- (BOOL)isUrl{
    NSString *urlPattern = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/?[\\w./?%&=-]*)?";
    NSError *error =nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlPattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    //match 这块内容非常强大
    NSUInteger count =[regex numberOfMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    return count > 0;
}

#pragma mark 是否是有效的邮箱地址
- (BOOL) isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark 是否是有效的用户名
- (BOOL) isValidUserName
{
    NSString *nameRegex = @"^[A-Za-z0-9\\u4e00-\\u9fa5-]{2,20}$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:self];
}

- (BOOL) isValidAdminName
{
    NSString *adminNameRegex = @"^[A-Za-z0-9\\u4e00-\\u9fa5-]{2,20}$";
    NSPredicate *adminNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", adminNameRegex];
    return [adminNameTest evaluateWithObject:self];
}

- (BOOL) isValidOtherName
{
    NSString *otherNameRegex = @"^[A-Za-z0-9\\u4e00-\\u9fa5-]{2,20}$"; //@"^[^ ][\\s\\S]*[^ ]{1,49}$";
    NSPredicate *otherNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", otherNameRegex];
    return [otherNameTest evaluateWithObject:self];
}

- (BOOL) isValidAccountName
{
    NSString *accountNameRegex = @"^[a-zA-Z][a-zA-Z0-9_]{2,20}$";
    NSPredicate *accountNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", accountNameRegex];
    return [accountNameTest evaluateWithObject:self];
}

- (BOOL) isValidPassword
{
    NSString *passwordRegex = @"^[a-zA-Z0-9-`=\\\\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]{6,20}$"; // 支持特殊字符，modified by LJ  25/11/2013
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:self];
}

- (BOOL) isValidlinkSetPassword
{
    NSString *passwordRegex = @"^[a-zA-Z0-9-`=\\\\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]{4,6}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:self];
}

#pragma mark 是否是有效的手机号码
- (BOOL)isValidMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString* MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString* CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString* CU= @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString* CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029 ...
     * 号码：七位或八位
     */
    
    //只判断位数 7到12位
    // NSString * PHS = @"^[0-9]{6,20}$";
    
    NSPredicate*regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate*regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate*regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate*regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    //NSPredicate*regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    
    if(([regextestmobile evaluateWithObject:self] == YES)
       || ([regextestcm evaluateWithObject:self] == YES)
       || ([regextestct evaluateWithObject:self] == YES)
       || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (BOOL)isValidPhoneNumber
{
    //只判断位数 4到12位
    NSString * PHS = @"^[0-9]{4,12}$";
    NSPredicate *regextestphone =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    if([regextestphone evaluateWithObject:self] == YES)
        return YES;
    else
        return NO;
}

- (BOOL)isValidNumber
{
    NSString *numberRegex = @"^[0-9]+$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:self];
}

#pragma mark 是否是车牌
-(BOOL)isValidCarNumber
{
    NSString *carNumberRegex = @"^([0-9]|[A-Z])+$";
    NSPredicate *carNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carNumberRegex];
    return [carNumberTest evaluateWithObject:self];
}


#pragma mark 是否是有效的文件名
- (BOOL)isValidFileName
{
    //判断文件名是否合法
    NSString *fileNameRegex = @"^[a-zA-Z0-9\\u4e00-\\u9fa5-`=\\[\\];',.~!@#$%^&()_+{}\\s*]+$";
    NSPredicate *fileNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", fileNameRegex];
    return [fileNameTest evaluateWithObject:self];
}

#pragma mark 是否是短信验证码--6位数字
-(BOOL)isSmsAuthcode
{
    NSString *authcodeRegStr = @"^[0-9]{6}$";
    NSPredicate *regexTestAuthcode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",authcodeRegStr];
    return [regexTestAuthcode evaluateWithObject:self];
}

#pragma mark是否是合法的url
-(BOOL)isValidUrl
{
    if (![CommonUtils isStrEmpty:self]) {
        return [self hasPrefix:@"http://"] || [self hasPrefix:@"https://"];
    }
    else
    {
        return NO;
    }
}

#pragma mark 动态计算字符串的宽度
- (float) widthForStrWithFontSize: (UIFont*)fontSize andHeight: (float)height
{
    CGSize labelsize;
    if (PRE_IOS7)
    {
        labelsize = [self sizeWithFont:fontSize
                            constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                                lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        NSDictionary *attribute = @{NSFontAttributeName: fontSize};
        
        labelsize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    return labelsize.width;
}

#pragma mark 动态计算字符串的高度
- (float) heightForStrWithFontSize: (UIFont*)fontSize andWidth: (float)width
{
    CGSize labelsize;
    if (PRE_IOS7)
    {
        labelsize = [self sizeWithFont:fontSize
                     constrainedToSize:CGSizeMake(width,CGFLOAT_MAX)
                         lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        NSDictionary *attribute = @{NSFontAttributeName: fontSize};
        
        labelsize = [self boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    return labelsize.height;
}
@end
