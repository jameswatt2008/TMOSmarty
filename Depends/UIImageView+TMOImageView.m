//
//  UIImageView+TMOImageView.m
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-8.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#import "UIImageView+TMOImageView.h"
#import "UIView+TMOView.h"

@implementation UIImageView (TMOImageView)

- (void)setPlaceHolderImage:(UIImage *)placeHolderImage {
    [self setAdditionValue:placeHolderImage forKey:@"placeHolderImage"];
}

- (UIImage *)placeHolderImage {
    return [self valueForAdditionKey:@"placeHolderImage"];
}

- (void)setErrorImage:(UIImage *)errorImage {
    [self setAdditionValue:errorImage forKey:@"errorImage"];
}

- (UIImage *)errorImage {
    return [self valueForAdditionKey:@"errorImage"];
}

- (void)setCacheTime:(NSTimeInterval)argCacheTime {
    [self setAdditionValue:[NSNumber numberWithInteger:argCacheTime] forKey:@"imageViewCacheTime"];
}

- (NSTimeInterval)cacheTime {
    if ([self valueForAdditionKey:@"imageViewCacheTime"] == nil) {
        return 86400;
    }
    return [[self valueForAdditionKey:@"imageViewCacheTime"] integerValue];
}

- (void)loadImageWithURLString:(NSString *)urlString {
    #warning You have to load image by yourself
}

- (void)loadImageWithURLString:(NSString *)urlString
                    callBefore:(void(^)(UIImageView *imageView))argCallBefore
                     callAfter:(void(^)(UIImageView *imageView, UIImage *image))argCallAfter {
    #warning You have to load image by yourself
}

@end
