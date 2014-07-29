//
//  SmartyBinder.h
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

typedef void (^SmartyBindCallbackBlock)(UIView *bindView, id dataSource, id bindObject, NSString *key, id newValue);

#import <Foundation/Foundation.h>

@interface SmartyBinder : NSObject

@property (nonatomic, assign) SmartyBindCallbackBlock callback;
@property (nonatomic, copy) NSString *bindKey;
@property (nonatomic, weak) UIView *bindView;
@property (nonatomic, weak) id bindObject;
@property (nonatomic, weak) id dataSource;

- (instancetype)initWithBindObject:(id)argBindObject
                    withDataSource:(id)argDataSource
                          withView:(UIView *)argView
                           withKey:(NSString *)argKey;

@end
