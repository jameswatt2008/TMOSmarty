//
//  UIView+TMOView.h
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-1.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (TMOView)

/**
 *  为UIView自定义Key-Value
 *
 *  @param argValue Value
 *  @param argKey   Key
 */
- (void)setAdditionValue:(id)argValue forKey:(NSString *)argKey;

/**
 *  取得已经自定义好的Key-Value
 *
 *  @param argKey key
 *
 *  @return Object
 */
- (id)valueForAdditionKey:(NSString *)argKey;

/**
 *  将UIView中的某一Key-Value删除
 *
 *  @param argKey Key
 */
- (void)removeAdditionValueForKey:(NSString *)argKey;


@end
