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

+ (void)initialize {
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
 *  replace all smarty keywords.
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
                    NSArray *theResult = [argParam componentsSeparatedByString:@"."];
                    NSUInteger index = 0;
                    for (NSString *resultItem in theResult) {
                        NSString *theKey = TOString(resultItem);
                        targetKey = theKey;
                        if ([lastValue isKindOfClass:[NSArray class]]) {
                            //get value from array
                            NSInteger theIndex = TOInteger(theKey);
                            if (ISValidArray(lastValue, theIndex)) {
                                targetObject = lastValue;
                                lastValue = [lastValue objectAtIndex:theIndex];
                            }
                        }
                        else {
                            //get value from dictionary or object
                            targetObject = lastValue;
                            lastValue = [lastValue valueForKeyPath:theKey];
                        }
                        index++;
                    }
                    if (targetObject != nil && ![targetObject isKindOfClass:[NSArray class]]) {
                        NSMutableDictionary *binders = [argView valueForAdditionKey:@"smartyBinder"];
                        if (binders == nil) {
                            binders = [NSMutableDictionary dictionary];
                        }
                        
                        [binders setObject:[[SmartyBinder alloc] initWithBindObject:targetObject
                                                                     withDataSource:argDataSource
                                                                           withView:argView
                                                                            withKey:targetKey]
                                    forKey:targetKey];
                        [argView setAdditionValue:binders
                                           forKey:@"smartyBinder"];
                    }
                }
                
            }
        }
    }
}

/**
 *  replace AttributedString
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
 *  get final value
 */
+ (NSString *)stringByParam:(NSString *)argParam withObject:(id)argObject {
    
    NSArray *functionUseArray;
    if ([argParam contains:@"|"]) {
        //custom or system function use
        functionUseArray = [argParam componentsSeparatedByString:@"|"];
        argParam = [functionUseArray firstObject];
    }
    
    id lastValue = argObject;
    NSArray *theResult = [argParam componentsSeparatedByString:@"."];
    NSUInteger index = 0;
    for (NSString *resultItem in theResult) {
        NSString *theKey = TOString(resultItem);
        if ([lastValue isKindOfClass:[NSArray class]]) {
            //get value from array
            NSInteger theIndex = TOInteger(theKey);
            if (ISValidArray(lastValue, theIndex)) {
                lastValue = [lastValue objectAtIndex:theIndex];
            }
        }
        else {
            //get value from dictionary or object
            lastValue = [lastValue valueForKeyPath:theKey];
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
 *  check string if has smarty keywords
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
