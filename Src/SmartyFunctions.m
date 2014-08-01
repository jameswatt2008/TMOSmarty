//
//  SmartyFunctions.m
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "SmartyFunctions.h"
#import "Smarty.h"
#import "TMOObjectVerifier.h"

@implementation SmartyFunctions

+ (void)initialize {
    [self replace];
    [self length];
    [self dateFormat];
    [self dateOffset];
    [self truncate];
    [self floatFormat];
    [self theDefault];
}

/**
 *  替换字符
 *  Smarty用法：$result|replace:待替换字符:替换字符
 *
 *  @param object 信息
 *
 *  @return 替换完毕的字符信息
 */
+ (void)replace {
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        if (ISValidArray(theParams, 2)) {
            return [TOString(theString) stringByReplacingOccurrencesOfString:TOString(theParams[1])
                                                                  withString:TOString(theParams[2])];
        }
        else{
            return TOString(theString);
        }
    } withTagName:@"replace"];
}

/**
 *  计算字符串长度
 *  Smarty用法：$result|length
 *
 *  @param object 信息
 *
 *  @return 字符串长度(NSString)
 */
+ (void)length {
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        return [NSString stringWithFormat:@"%lu", (unsigned long)[TOString(theString) length]];
    } withTagName:@"length"];
    
}

/**
 *  将时间戳转换为指定格式
 *  Value必须为Unix标准时间戳，即由1970年1月1日0时0分0秒起计算的秒数差
 *  示例： <{$result|dateFormat:%Y-%m-%d %H:%i:%s}>
 *
 *  @param object 信息
 *
 *  @return 指定格式字符串
 */
+ (void)dateFormat {
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        NSMutableArray *dateFormatArray = [theParams mutableCopy];
        [dateFormatArray removeObjectAtIndex:0];
        NSString *dateFormatString = [dateFormatArray componentsJoinedByString:@":"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:TOInteger(theString)];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSMonthCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
        NSDateComponents *components = [calendar components:unitFlags fromDate:date];
        
        
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%Y"
                                                                       withString:[NSString stringWithFormat:@"%ld", (long)components.year]];
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%y"
                                                                       withString:[[NSString stringWithFormat:@"%ld", (long)components.year] substringFromIndex:2]];
        
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%m"
                                                                       withString:[NSString stringWithFormat:@"%02ld", (long)components.month]];
        
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%d"
                                                                       withString:[NSString stringWithFormat:@"%02ld", (long)components.day]];
        
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%H"
                                                                       withString:[NSString stringWithFormat:@"%02ld", (long)components.hour]];
        
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%i"
                                                                       withString:[NSString stringWithFormat:@"%02ld", (long)components.minute]];
        
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%s"
                                                                       withString:[NSString stringWithFormat:@"%02ld", (long)components.second]];
        
        dateFormatString = [dateFormatString stringByReplacingOccurrencesOfString:@"%w"
                                                                       withString:[NSString stringWithFormat:@"%ld", (long)components.weekday-1]];
        
        return dateFormatString;
    } withTagName:@"dateFormat"];
}

/**
 *  返回时间差形式的字符串
 *  Value必须为Unix时间戳
 *  必须提供后备参数
 *  示例  <{$value|dateOffset:%Y年%m月%d日}>
 *
 *  @param object object
 *
 *  @return NSString
 */
+ (void)dateOffset {
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        NSDate *date = [NSDate date];
        if (date.timeIntervalSince1970 - TOInteger(theString) < 60) {
            return @"刚刚";
        }
        else if (date.timeIntervalSince1970 - TOInteger(theString) < 3600){
            return [NSString stringWithFormat:@"%d分钟前", (int)(TOInteger(theString) - date.timeIntervalSince1970)/60];
        }
        else if (date.timeIntervalSince1970 - TOInteger(theString) < 43200) {
            return [NSString stringWithFormat:@"%d小时前", (int)(TOInteger(theString) - date.timeIntervalSince1970)/3600];
        }
        else{
            SmartyCallbackBlock dateFormatBlock = [Smarty smartyDictionary][@"dateFormat"];
            if (dateFormatBlock != nil) {
                return dateFormatBlock(theString, theParams);
            }
            else {
                return @"";
            }
        }
    } withTagName:@"dateOffset"];
}

/**
 *  将字符串转换为浮点数，并以指定的浮点数显示形式返回
 *  示例  <{$value|floatFormat:%d}> 这将返回一个整型
 *
 *  @param object object
 *
 *  @return NSString
 */
+ (void)floatFormat {
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        if (ISValidArray(theParams, 1)) {
            return [NSString stringWithFormat:theParams[1], TOFloat(theString)];
        }
        return TOString(theString);
    } withTagName:@"floatFormat"];
}

/**
 *  当Value为空时，显示一个默认的字符串
 *  调用示例   <{$result|default:加载失败}>
 *
 *  @param object obejct
 *
 *  @return NSString
 */
+ (void)theDefault {
    
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        if ([TOString(theString) length] > 0) {
            return theString;
        }
        if (ISValidArray(theParams, 1)) {
            return TOString(theParams[1]);
        }
        else {
            return @"";
        }
    } withTagName:@"default"];
}

/**
 *  截取字符串到指定长度
 *  所有参数都是可选的
 *  第一个参数：截取的长度  默认80
 *  第二个参数：截取后替代显示的字符，该字符长度会被计算到截取长度内，默认为 ...
 *  第三个参数：中段截取，1为是0为否，若是，则将截取后的字符串会是  “呵呵呵呵呵呵...呵呵呵呵呵呵” 这个样子
 *
 *  @param object object
 *
 *  @return NSString
 */
+ (void)truncate {
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        NSInteger length = ISValidArray(theParams, 1) ? TOInteger(theParams[1]) : 80;
        NSString *etc = ISValidArray(theParams, 2) ? TOString(theParams[2]) : @"...";
        BOOL middle = ISValidArray(theParams, 3) ? [TONumber(theParams[3]) boolValue] : NO;
        if (length == 0) {
            return @"";
        }
        if ([TOString(theString) length] > 0) {
            length -= MIN(length, [etc length]);
            if (!middle) {
                return [[TOString(theString) substringWithRange:NSMakeRange(0, length)] stringByAppendingString:etc];
            }
            return [NSString stringWithFormat:@"%@%@%@",
                    [TOString(theString) substringWithRange:NSMakeRange(0, length/2)],
                    etc,
                    [TOString(theString) substringWithRange:NSMakeRange([TOString(theString) length]-length/2, length/2)]];
        }
        return TOString(theString);
    } withTagName:@"truncate"];
}

@end
