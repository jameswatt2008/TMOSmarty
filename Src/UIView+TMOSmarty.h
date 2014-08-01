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
 *  Replace all smarty values with Object/Dictionary/Array.
 *
 *  @param argObject      dataSource
 *  @param argIsRecursive if it's YES, then view.subview.subview.subview..... will be replaced.
 */
- (void)smartyRendWithObject:(id)argObject isRecursive:(BOOL)argIsRecursive;

/**
 *  Declare that this view is a KVO bind View.
 *  When object's item changed, the specific view will rend again automitically.
 */
- (void)smartyBind;

/**
 *  Declare that this view and all subview for this view will are KVO bind Views.
 *  When object's item changed, the specific view will rend again automitically.
 */
- (void)smartyBindForSubviews;

/**
 *  Declare that this view is a KVO bind View.
 *  When object's item changed, it will change rend again, and it will call block you preserved.
 *
 *  @param argBlock block
 */
- (void)smartyBindWithBlock:(SmartyBindCallbackBlock)argBlock;

/**
 *  Undeclare the KVO bind View.
 */
- (void)smartyUnBind;

@end
