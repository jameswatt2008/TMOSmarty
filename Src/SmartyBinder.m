//
//  SmartyBinder.m
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "SmartyBinder.h"
#import "UIView+TMOView.h"
#import "UIView+TMOSmarty.h"

@implementation SmartyBinder

- (void)dealloc {
    [self.bindObject removeObserver:self forKeyPath:self.bindKey context:nil];
}

- (instancetype)initWithBindObject:(id)argBindObject
                    withDataSource:(id)argDataSource
                          withView:(UIView *)argView
                           withKey:(NSString *)argKey {
    self = [super init];
    if (self) {
        self.bindObject = argBindObject;
        self.dataSource = argDataSource;
        self.bindView = argView;
        self.bindKey = argKey;
        [self.bindObject addObserver:self
                          forKeyPath:self.bindKey
                             options:NSKeyValueObservingOptionNew
                             context:nil];
        self.callback = [self.bindView valueForAdditionKey:@"smartyBindCallbackBlock"];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self.bindView smartyRendWithObject:self.dataSource isRecursive:NO];
    if (self.callback != nil) {
        self.callback(self.bindView, self.dataSource, self.bindObject, keyPath, change[NSKeyValueChangeNewKey]);
    }
}

@end
