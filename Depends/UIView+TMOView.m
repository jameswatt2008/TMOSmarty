//
//  UIView+TMOView.m
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-1.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#define kTMOBadgeViewTag -10001

#import "UIView+TMOView.h"
#import <objc/runtime.h>

static char kUIViewAddtionValueKey;

@interface UIView (TMOViewAddtional)

@property (strong, nonatomic) NSMutableDictionary *additionValueDictionary;

@end

@implementation UIView (TMOViewAddtional)

@dynamic additionValueDictionary;

- (NSMutableDictionary *)additionValueDictionary {
    return (NSMutableDictionary *)objc_getAssociatedObject(self, &kUIViewAddtionValueKey);
}

- (void)setAdditionValueDictionary:(NSMutableDictionary *)additionValueDictionary {
    objc_setAssociatedObject(self, &kUIViewAddtionValueKey, additionValueDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIView (TMOView)

- (void)setAdditionValue:(id)argValue forKey:(NSString *)argKey {
    if (self.additionValueDictionary == nil) {
        self.additionValueDictionary = [NSMutableDictionary dictionary];
    }
    if (argValue == nil) {
        return;
    }
    [self.additionValueDictionary setObject:argValue forKey:argKey];
}

- (id)valueForAdditionKey:(NSString *)argKey {
    if (self.additionValueDictionary == nil) {
        return nil;
    }
    return self.additionValueDictionary[argKey];
}

- (void)removeAdditionValueForKey:(NSString *)argKey {
    if (self.additionValueDictionary == nil) {
        self.additionValueDictionary = [NSMutableDictionary dictionary];
    }
    [self.additionValueDictionary removeObjectForKey:argKey];
}

@end
