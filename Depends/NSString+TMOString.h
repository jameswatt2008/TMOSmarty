//
//  NSString+TMOString.h
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-10.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TMOString)

/**
 *  返回字符串的MD5散列值
 *
 *  @return NSString
 */
- (NSString *)stringByMD5Hash;

/**
 *  返回字符串的Sha1散列值
 *
 *  @return NSString
 */
- (NSString *)stringBySha1Hash;

/**
 *  此函数返回字符串本身支除首尾空白字符后的结果
 *
 *  @return NSString
 */
- (NSString *)stringByTrim;

/**
 *  返回字符串URL加码结果，用于保护GET请求的某一参数不受HTTP传输影响，POST请求不需要使用
 *
 *  @return NSString
 */
- (NSString *)stringByURLEncode;

/**
 *  检测字符串是否为空
 *  会将原字符串清除前后空白再检测
 *
 *  @return 为空，则返回YES
 */
-(BOOL)isBlank;

/**
 *  检测是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return 包含，则返回YES
 */
-(BOOL)contains:(NSString *)string;


@end
