//
//  TMOObjectVerifier.h
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-10.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TOString(object) [TMOObjectVerifier toString:object]
#define TONumber(object) [TMOObjectVerifier toNumber:object]
#define TOInteger(object) [TMOObjectVerifier toInteger:object]
#define TOFloat(object) [TMOObjectVerifier toFloat:object]
#define TODictionary(object) [TMOObjectVerifier toDictionary:object]
#define TOArray(object) [TMOObjectVerifier toArray:object]
#define ISValidArray(theArray, theIndex) [TMOObjectVerifier isValidIndexInArray:theArray index:theIndex]

//只能在DEBUG模式下使用对象混乱器
#ifdef DEBUG
#define OBJECT_DEBUGER(theDictionary) [TMOObjectVerifier objectDebuger:theDictionary]
#endif

@interface TMOObjectVerifier : NSObject

/**
 *  将对象格式化为NSString
 *
 *  @param argObject 待格式化对象
 *
 *  @return 必定为NSString
 */
+ (NSString *)toString:(id)argObject;

/**
 *  将对象格式化为NSNumber
 *
 *  @param argObject 待格式化对象
 *
 *  @return 必定为NSNumber
 */
+ (NSNumber *)toNumber:(id)argObject;

/**
 *  将对象格式化为NSInteger
 *
 *  @param argObject 待格式化对象
 *
 *  @return 必定为NSInteger
 */
+ (NSInteger)toInteger:(id)argObject;

/**
 *  将对象格式化为CGFloat
 *
 *  @param argObject 待格式化对象
 *
 *  @return 必定为CGFloat
 */
+ (CGFloat)toFloat:(id)argObject;

/**
 *  将对象格式化为NSDictionary
 *
 *  @param argObject 待格式化对象
 *
 *  @return 必定为NSDictionary
 */
+ (NSDictionary *)toDictionary:(id)argObject;

/**
 *  将对象格式化为NSArray
 *
 *  @param argObject 待格式化对象
 *
 *  @return 必定为NSArray
 */
+ (NSArray *)toArray:(id)argObject;

/**
 *  检查当前数组取值是否越界
 *
 *  @param argArray 待检查数组
 *  @param argIndex 取值下标
 *
 *  @return 未越界则返回真，越界则返回假
 */
+ (BOOL)isValidIndexInArray:(NSArray *)argArray index:(NSInteger)argIndex;

/**
 *  使用此方法，会使Dictionary中的对象最大程度混乱化
 *  使用此方法可以校验程序中是否已经在每处正确使用对象格式化工具
 *
 *  @param argDictionary 传入一个Dictionary
 *
 *  @return 返回一个处理好的Dictionary
 */
+ (NSDictionary *)objectDebuger:(NSDictionary *)argDictionary;

@end
