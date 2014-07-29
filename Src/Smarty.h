//
//  Smarty.h
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

typedef NSString *(^SmartyCallbackBlock)(NSString *theString, NSArray *theParams);

#import <Foundation/Foundation.h>

@interface Smarty : NSObject

+ (void)addFunction:(SmartyCallbackBlock)argBlock withTagName:(NSString *)tagName;

+ (void)removeFunctionWithTagName:(NSString *)tagName;

@end

/**
 *  Private Use, Don't call these functions!
 */
@interface Smarty (PrivateUse)

+ (void)instance;

+ (NSString *)stringByReplaceingSmartyCode:(NSString *)argString
                                withObject:(NSDictionary *)argObject;
+ (NSAttributedString *)attributedStringByReplaceingSmartyCode:(NSAttributedString *)argString
                                                    withObject:(NSDictionary *)argObject;
+ (NSString *)stringByParam:(NSString *)argParam withObject:(NSDictionary *)argObject;
+ (BOOL)isSmarty:(NSString *)argString;

+ (void)addSmartyBindBySmartyCode:(NSString *)argString
                         withView:(UIView *)argView
                   withDataSource:(id)argDataSource;

+ (NSMutableDictionary *)smartyDictionary;

@end
