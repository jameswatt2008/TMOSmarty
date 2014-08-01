//
//  DemoObject.h
//  TMOSmarty
//
//  Created by 崔明辉 on 14-8-1.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoObjectSecond : NSObject

@property (nonatomic, strong) NSString *myWife;

@end

@interface DemoObject : NSObject

@property (nonatomic, strong) NSString *myName;
@property (nonatomic, assign) NSInteger myAge;
@property (nonatomic, assign) CGFloat myWeight;
@property (nonatomic, strong) DemoObjectSecond *couple;

@property (nonatomic, strong) NSArray *demoArray;
@property (nonatomic, strong) NSDictionary *demoDictionary;

@end
