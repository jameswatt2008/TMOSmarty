//
//  Smarty.m
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

static NSMutableDictionary *smartyDictionary;
static NSRegularExpression *smartyRegularExpression;

#import "Smarty.h"
#import "TMOObjectVerifier.h"
#import "UIView+TMOView.h"
#import "NSString+TMOString.h"
#import "SmartyBinder.h"

@implementation Smarty

+ (void)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        smartyDictionary = [NSMutableDictionary dictionary];
        smartyRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"<\\{\\$([^\\}]+)\\}>"
                                                                       options:NSRegularExpressionAllowCommentsAndWhitespace
                                                                         error:nil];
    });
}

+ (void)addFunction:(SmartyCallbackBlock)argBlock withTagName:(NSString *)tagName {
    if (smartyDictionary != nil) {
        [smartyDictionary setObject:argBlock forKey:tagName];
    }
}

+ (void)removeFunctionWithTagName:(NSString *)tagName {
    if (smartyDictionary != nil) {
        [smartyDictionary removeObjectForKey:tagName];
    }
}

+ (SmartyCallbackBlock)blockForTagName:(NSString *)tagName {
    return smartyDictionary[tagName];
}

+ (NSString *)executeFunctionWithName:(NSString *)argName
                            withValue:(NSString *)argValue
                           withParams:(NSArray *)argParams{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *returnString = @"";
    SmartyCallbackBlock block = [self blockForTagName:argName];
    if (block != nil) {
        returnString = block(argValue, argParams);
    }
    else {
        returnString = argValue;
    }
    return returnString;
#pragma clang diagnostic pop
}

+ (NSString *)leftDelimiter {
    static NSString *leftDelimiter = @"<{";
    return leftDelimiter;
}

+ (NSString *)rightDelimiter {
    static NSString *rightDelimiter = @"}>";
    return rightDelimiter;
}

/**
 *  替换所有Smarty关键词至最终值
 */
+ (NSString *)stringByReplaceingSmartyCode:(NSString *)argString
                                withObject:(NSDictionary *)argObject {
    NSString *newString = [argString copy];
    NSArray *theResult = [smartyRegularExpression matchesInString:argString
                                                          options:NSMatchingReportCompletion
                                                            range:NSMakeRange(0, [argString length])];
    for (NSTextCheckingResult *resultItem in theResult) {
        if (resultItem.numberOfRanges >= 2) {
            NSString *smartyString = [argString substringWithRange:[resultItem rangeAtIndex:0]];
            NSString *smartyParam = [argString substringWithRange:[resultItem rangeAtIndex:1]];
            newString = [newString stringByReplacingOccurrencesOfString:smartyString
                                                             withString:[self stringByParam:smartyParam
                                                                                 withObject:argObject]];
        }
    }
    return newString;
}

+ (void)addSmartyBindBySmartyCode:(NSString *)argString
                         withView:(UIView *)argView
                   withDataSource:(id)argDataSource {
    if ([argView valueForAdditionKey:@"smartyBinded"] != nil) {
        NSArray *theResult = [smartyRegularExpression matchesInString:argString
                                                              options:NSMatchingReportCompletion
                                                                range:NSMakeRange(0, [argString length])];
        for (NSTextCheckingResult *resultItem in theResult) {
            if (resultItem.numberOfRanges >= 2) {
                NSString *argParam = [argString substringWithRange:[resultItem rangeAtIndex:1]];
                {
                    NSArray *functionUseArray;
                    if ([argParam contains:@"|"]) {
                        //注册函数调用
                        functionUseArray = [argParam componentsSeparatedByString:@"|"];
                        argParam = [functionUseArray firstObject];
                    }
                    
                    id lastValue = argDataSource;
                    id targetObject = argDataSource;
                    NSString *targetKey;
                    NSArray *theResult = [argParam contains:@"."] ? [argParam componentsSeparatedByString:@"."] : [argParam componentsSeparatedByString:@"["];
                    NSUInteger index = 0;
                    for (NSString *resultItem in theResult) {
                        NSString *theKey = [resultItem stringByReplacingOccurrencesOfString:@"]" withString:@""];
                        if ([theKey contains:@"'"] || [theKey contains:@"\""] || index == 0 || ![lastValue isKindOfClass:[NSArray class]]) {
                            theKey = [theKey stringByReplacingOccurrencesOfString:@"'" withString:@""];
                            theKey = [theKey stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                            targetKey = theKey;
                            SEL sel = sel_registerName([theKey cStringUsingEncoding:NSUTF8StringEncoding]);
                            if ([lastValue respondsToSelector:sel]) {
                                //可认为是对象取值
                                targetObject = lastValue;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                lastValue = [lastValue performSelector:sel withObject:nil];
#pragma clang diagnostic pop
                                if (lastValue == nil) {
                                    targetObject = nil;
                                    break;
                                }
                            }
                            else {
                                //可认为是字典取值
                                if ([lastValue isKindOfClass:[NSDictionary class]]) {
                                    targetObject = lastValue;
                                    lastValue = [lastValue valueForKey:TOString(theKey)];
                                }
                                else {
                                    targetObject = nil;
                                    break;
                                }
                            }
                        }
                        else {
                            //可认为是数组取值
                            if (ISValidArray(lastValue, TOInteger(theKey))) {
                                targetObject = lastValue;
                                lastValue = [lastValue objectAtIndex:TOInteger(theKey)];
                            }
                            else{
                                targetObject = nil;
                                break;
                            }
                        }
                        index++;
                    }
                    if (targetObject != nil) {
                        [argView setAdditionValue:[[SmartyBinder alloc] initWithBindObject:targetObject
                                                                            withDataSource:argDataSource
                                                                                  withView:argView
                                                                                   withKey:targetKey]
                                           forKey:@"smartyBinder"];
                    }
                }
                
            }
        }
    }
}

/**
 *  替换AttributedString关键词至最终值
 *
 *  @param argString     NSAttributedString
 *  @param argObject NSDictionary
 *
 *  @return NSAttributedString
 */
+ (NSAttributedString *)attributedStringByReplaceingSmartyCode:(NSAttributedString *)argString
                                                    withObject:(NSDictionary *)argObject {
    NSMutableAttributedString *mutableAttributedString = [argString mutableCopy];
    for (;[Smarty isSmarty:mutableAttributedString.string];) {
        NSArray *theResult = [smartyRegularExpression matchesInString:mutableAttributedString.string
                                                              options:NSMatchingReportCompletion
                                                                range:NSMakeRange(0, [mutableAttributedString.string length])];
        for (NSTextCheckingResult *resultItem in theResult) {
            if (resultItem.numberOfRanges >= 2) {
                NSString *smartyParam = [mutableAttributedString.string substringWithRange:[resultItem rangeAtIndex:1]];
                [mutableAttributedString replaceCharactersInRange:resultItem.range withString:[Smarty stringByParam:smartyParam withObject:argObject]];
            }
            break;
        }
    }
    return [mutableAttributedString copy];
}

/**
 *  取得最终值
 */
+ (NSString *)stringByParam:(NSString *)argParam withObject:(id)argObject {
    
    NSArray *functionUseArray;
    if ([argParam contains:@"|"]) {
        //注册函数调用
        functionUseArray = [argParam componentsSeparatedByString:@"|"];
        argParam = [functionUseArray firstObject];
    }
    
    id lastValue = argObject;
    NSArray *theResult = [argParam contains:@"."] ? [argParam componentsSeparatedByString:@"."] : [argParam componentsSeparatedByString:@"["];
    NSUInteger index = 0;
    for (NSString *resultItem in theResult) {
        NSString *theKey = [resultItem stringByReplacingOccurrencesOfString:@"]" withString:@""];
        if ([theKey contains:@"'"] || [theKey contains:@"\""] || index == 0 || ![lastValue isKindOfClass:[NSArray class]]) {
            theKey = [theKey stringByReplacingOccurrencesOfString:@"'" withString:@""];
            theKey = [theKey stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            SEL sel = sel_registerName([theKey cStringUsingEncoding:NSUTF8StringEncoding]);
            if ([lastValue respondsToSelector:sel]) {
                //可认为是对象取值
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                lastValue = [lastValue performSelector:sel withObject:nil];
#pragma clang diagnostic pop
                if (lastValue == nil) {
                    return @"";
                }
            }
            else {
                //可认为是字典取值
                if ([lastValue isKindOfClass:[NSDictionary class]]) {
                    lastValue = [lastValue valueForKey:TOString(theKey)];
                }
                else {
                    return @"";
                }
            }
        }
        else {
            //可认为是数组取值
            if (ISValidArray(lastValue, TOInteger(theKey))) {
                lastValue = [lastValue objectAtIndex:TOInteger(theKey)];
            }
            else{
                return @"";
            }
        }
        index++;
    }
    
    if (functionUseArray != nil) {
        for (NSUInteger i=1; i<[functionUseArray count]; i++) {
            NSArray *components = [functionUseArray[i] componentsSeparatedByString:@":"];
            NSString *functionName = [components firstObject];
            lastValue = [self executeFunctionWithName:functionName
                                            withValue:TOString(lastValue)
                                           withParams:components];
        }
    }
    
    return TOString(lastValue);
}

/**
 *  检测是否包含Smarty关键词
 */
+ (BOOL)isSmarty:(NSString *)argString {
    if ([argString contains:[self leftDelimiter]] && [argString contains:[self rightDelimiter]]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSMutableDictionary *)smartyDictionary {
    return smartyDictionary;
}

@end
