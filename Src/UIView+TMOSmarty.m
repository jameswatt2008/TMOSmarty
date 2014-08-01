//
//  UIView+TMOSmarty.m
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "UIView+TMOSmarty.h"
#import "UIView+TMOView.h"
#import "TMOObjectVerifier.h"
#import "UIImageView+TMOImageView.h"
#import "TMOToolKitMacro.h"
#import "Smarty.h"

@implementation UIView (TMOSmarty)

- (void)smartyRendWithObject:(id)argObject isRecursive:(BOOL)argIsRecursive {
    //self
    [self smartyReplaceWithObject:argObject];
    if (argIsRecursive) {
        for (UIView *subView in self.subviews) {
            [subView smartyRendWithObject:argObject isRecursive:YES];
        }
    }
}

/**
 *  SmartyBind
 *  Model View动态绑定
 */

- (void)smartyBind {
    [self setAdditionValue:@(YES) forKey:@"smartyBinded"];
}

- (void)smartyBindForSubviews {
    [self setAdditionValue:@(YES) forKey:@"smartyBinded"];
    [self.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj smartyBindForSubviews];
    }];
}

- (void)smartyBindWithBlock:(SmartyBindCallbackBlock)argBlock {
    [self setAdditionValue:@(YES) forKey:@"smartyBinded"];
    [self setAdditionValue:argBlock forKey:@"smartyBindCallbackBlock"];
}

- (void)smartyUnBind {
    [self removeAdditionValueForKey:@"smartyBinded"];
    [self removeAdditionValueForKey:@"smartyBinder"];
    [self.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj smartyUnBind];
    }];
}

- (void)smartyReplaceWithObject:(id)argObject {
    [self smartySaveOriginData:argObject];
    if ([self valueForAdditionKey:@"smartyAttributedText"] != nil) {
        NSAttributedString *attributedString = [self valueForAdditionKey:@"smartyAttributedText"];
        [(UILabel *)self setAttributedText:[Smarty attributedStringByReplaceingSmartyCode:attributedString
                                                                               withObject:argObject]];
    }
    else if ([self valueForAdditionKey:@"smartyText"] != nil) {
        NSString *text = [self valueForAdditionKey:@"smartyText"];
        [(UILabel *)self setText:[Smarty stringByReplaceingSmartyCode:text withObject:argObject]];
    }
    if ([self valueForAdditionKey:@"smartyPlaceholder"] != nil) {
        NSString *text = [self valueForAdditionKey:@"smartyPlaceholder"];
        [(UITextField *)self setPlaceholder:[Smarty stringByReplaceingSmartyCode:text withObject:argObject]];
    }
    if ([self valueForAdditionKey:@"smartyTitle"] != nil) {
        NSString *text = [self valueForAdditionKey:@"smartyTitle"];
        [(UIButton *)self setTitle:[Smarty stringByReplaceingSmartyCode:text withObject:argObject]
                          forState:UIControlStateNormal];
    }
    if ([self valueForAdditionKey:@"smartyImageURLString"] != nil) {
        NSString *text = [self valueForAdditionKey:@"smartyImageURLString"];
        [(UIImageView *)self loadImageWithURLString:[Smarty stringByReplaceingSmartyCode:text withObject:argObject]];
    }
}

- (void)smartySaveOriginData:(id)argDataSource {
    if ([self isKindOfClass:[UILabel class]]) {
        if ([Smarty isSmarty:TOString([(UILabel *)self text])]) {
            [self setAdditionValue:[(UILabel *)self text] forKey:@"smartyText"];
            [Smarty addSmartyBindBySmartyCode:[(UILabel *)self text] withView:self withDataSource:argDataSource];
        }
        if (TMO_SYSTEM_VERSION >= 6.0 &&
            [Smarty isSmarty:TOString([[(UILabel *)self attributedText] string])]) {
            [self setAdditionValue:[(UILabel *)self attributedText] forKey:@"smartyAttributedText"];
            [Smarty addSmartyBindBySmartyCode:[[(UILabel *)self attributedText] string] withView:self withDataSource:argDataSource];
        }
    }
    else if ([self isKindOfClass:[UITextField class]]) {
        if ([Smarty isSmarty:TOString([(UITextField *)self text])]) {
            [self setAdditionValue:[(UITextField *)self text] forKey:@"smartyText"];
            [Smarty addSmartyBindBySmartyCode:[(UITextField *)self text] withView:self withDataSource:argDataSource];
        }
        if ([Smarty isSmarty:TOString([(UITextField *)self placeholder])]) {
            [self setAdditionValue:[(UITextField *)self placeholder] forKey:@"smartyPlaceholder"];
            [Smarty addSmartyBindBySmartyCode:[(UITextField *)self placeholder] withView:self withDataSource:argDataSource];
        }
    }
    else if ([self isKindOfClass:[UITextView class]]) {
        if ([Smarty isSmarty:TOString([(UITextView *)self text])]) {
            [self setAdditionValue:[(UITextView *)self text] forKey:@"smartyText"];
            [Smarty addSmartyBindBySmartyCode:[(UITextView *)self text] withView:self withDataSource:argDataSource];
        }
        if (TMO_SYSTEM_VERSION >= 6.0 &&
            [Smarty isSmarty:TOString([[(UITextView *)self attributedText] string])]) {
            [self setAdditionValue:[(UITextView *)self attributedText] forKey:@"smartyAttributedText"];
            [Smarty addSmartyBindBySmartyCode:[[(UITextView *)self attributedText] string] withView:self withDataSource:argDataSource];
        }
    }
    else if ([self isKindOfClass:[UIButton class]]) {
        if ([Smarty isSmarty:TOString([(UIButton *)self titleForState:UIControlStateNormal])]) {
            [self setAdditionValue:[(UIButton *)self titleForState:UIControlStateNormal] forKey:@"smartyTitle"];
            [Smarty addSmartyBindBySmartyCode:[(UIButton *)self titleForState:UIControlStateNormal] withView:self withDataSource:argDataSource];
        }
    }
    else if ([self isKindOfClass:[UIImageView class]]) {
        if ([Smarty isSmarty:TOString(self.accessibilityLabel)]) {
            [self setAdditionValue:self.accessibilityIdentifier forKey:@"smartyImageURLString"];
            [Smarty addSmartyBindBySmartyCode:[(UIImageView *)self accessibilityIdentifier] withView:self withDataSource:argDataSource];
        }
    }
}

@end
