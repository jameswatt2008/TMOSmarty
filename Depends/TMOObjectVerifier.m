//
//  TMOObjectVerifier.m
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-10.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#import "TMOObjectVerifier.h"

@implementation TMOObjectVerifier

+ (NSString *)toString:(id)argObject {
    if ([argObject isKindOfClass:[NSString class]]) {
        return argObject;
    }
    else {
        if ([argObject isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@", argObject];
        }
    }
    return @"";
}

+ (NSNumber *)toNumber:(id)argObject {
    if ([argObject isKindOfClass:[NSNumber class]]) {
        return argObject;
    }
    else {
        if ([argObject isKindOfClass:[NSString class]]) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            NSNumber *theNumber = [numberFormatter numberFromString:argObject];
            return theNumber == NULL ? @0 : [numberFormatter numberFromString:argObject];
        }
    }
    return @0;
}

+ (NSInteger)toInteger:(id)argObject {
    return [[self toNumber:argObject] integerValue];
}

+ (CGFloat)toFloat:(id)argObject {
    return [[self toNumber:argObject] floatValue];
}

+ (NSDictionary *)toDictionary:(id)argObject {
    if ([argObject isKindOfClass:[NSDictionary class]]) {
        return argObject;
    }
    return @{};
}

+ (NSArray *)toArray:(id)argObject {
    if ([argObject isKindOfClass:[NSArray class]]) {
        return argObject;
    }
    return @[];
}

+ (BOOL)isValidIndexInArray:(NSArray *)argArray index:(NSInteger)argIndex {
    if ([argArray isKindOfClass:[NSArray class]] && argIndex >= 0) {
        if (argIndex < [argArray count]) {
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)objectDebuger:(NSDictionary *)argDictionary {
    NSMutableDictionary *mutableDictionary = [argDictionary mutableCopy];
    for (NSString *theKey in argDictionary) {
        NSInteger random = arc4random() % 126;
        if (random <= 25) {
            [mutableDictionary setObject:TOString(argDictionary[theKey])
                                  forKey:theKey];
        }
        else if (random <= 50) {
            [mutableDictionary setObject:TONumber(argDictionary[theKey])
                                  forKey:theKey];
        }
        else if (random <= 75) {
            [mutableDictionary setObject:TODictionary(argDictionary[theKey])
                                  forKey:theKey];
        }
        else if (random <= 100) {
            [mutableDictionary setObject:TOArray(argDictionary[theKey])
                                  forKey:theKey];
        }
        else if (random <= 125) {
            [mutableDictionary setObject:[NSNull null]
                                  forKey:theKey];
        }
    }
    return mutableDictionary;
}

@end
