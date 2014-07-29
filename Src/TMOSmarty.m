//
//  TMOSmarty.m
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "TMOSmarty.h"

@implementation TMOSmarty

+ (void)instance {
    [Smarty instance];
    [SmartyFunctions instance];
}

@end
