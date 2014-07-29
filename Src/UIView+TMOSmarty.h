//
//  UIView+TMOSmarty.h
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartyBinder.h"

@interface UIView (TMOSmarty)

/**
 *  对当前View下的所有SubView执行Smarty替换
 *
 *  @param argDictionary 数据字典
 *  @param argIsRecursive 是否递归执行，即view.subview.subview.subview.....均会被执行替换
 */
- (void)smartyRendWithDictionary:(NSDictionary *)argDictionary
                     isRecursive:(BOOL)argIsRecursive ;

/**
 *  对当前View下的所有SubView执行Smarty替换
 *  V2.1.2新增方法，支持NSObject、NSDictionary替换
 *
 *  @param argObject      数据源
 *  @param argIsRecursive 是否递归执行，即view.subview.subview.subview.....均会被执行替换
 */
- (void)smartyRendWithObject:(id)argObject isRecursive:(BOOL)argIsRecursive;

/**
 *  将View与数据源进行动态绑定（只包括view本身）
 *  数据源的变化将即时反馈到界面上
 */
- (void)smartyBind;

/**
 *  将所有subview与数据源进行动态绑定（包括view本身）
 */
- (void)smartyBindForSubviews;

/**
 *  将View与数据源进行动态绑定（只包括view本身）
 *  Model变化的同时，view的文字属性进行改变，然后执行回调，你可以在回调中执行任意操作
 *
 *  @param argBlock 回调
 */
- (void)smartyBindWithBlock:(SmartyBindCallbackBlock)argBlock;

/**
 *  解除数据源绑定
 */
- (void)smartyUnBind;

@end
