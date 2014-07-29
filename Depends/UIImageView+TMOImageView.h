//
//  UIImageView+TMOImageView.h
//  TeemoV2
//
//  Created by 崔明辉 on 14-4-8.
//  Copyright (c) 2014年 com.duowan.zpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView (TMOImageView)

/**
 *  图片缓存时间，缓存规则与HTTP缓存规则一致
 *  小于0 -> 不缓存加载图片，并清除缓存
 *  等于0 -> 无限期缓存图片
 *  大于0 -> N秒后图片缓存失效
 */
@property (nonatomic, readwrite) NSTimeInterval cacheTime;

/**
 *  加载过程中的替换图片，相当于[UIImage imageNamed:@"placeHolderImageName"]
 */
@property (nonatomic, copy) UIImage *placeHolderImage;

/**
 *  加载失败后的替换图片，相当于[UIImage imageNamed:@"errorImageName"]
 */
@property (nonatomic, copy) UIImage *errorImage;

/**
 *  异步加载图片
 *
 *  @param urlString 需要加载的图片HTTP URL
 */
- (void)loadImageWithURLString:(NSString *)urlString;

/**
 *  异步加载图片
 *  在加载前、加载后执行用户指定回调
 *
 *  @param urlString     需要加载的图片HTTP URL
 *  @param argCallBefore 加载前的回调
 *  @param argCallAfter  加载后的回调（程序不会为你将image填充到imageView，你需要自行填充）
 */
- (void)loadImageWithURLString:(NSString *)urlString
                    callBefore:(void(^)(UIImageView *imageView))argCallBefore
                     callAfter:(void(^)(UIImageView *imageView, UIImage *image))argCallAfter;

@end
