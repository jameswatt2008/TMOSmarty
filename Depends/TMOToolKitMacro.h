//
//  TMOToolKitMacros.h
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-10.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  机器iOS系统版本
 */
#define TMO_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  Release自动去除NSLog
 */
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

@interface TMOToolKitMacros : NSObject

@end
