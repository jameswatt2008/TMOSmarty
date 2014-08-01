//
//  DemoViewController.m
//  TMOSmarty
//
//  Created by 崔 明辉 on 14-7-29.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoObject.h"
#import "TMOSmarty.h"

@interface DemoViewController ()

@property (nonatomic, strong) DemoObject *myObject;

@end

@implementation DemoViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.myObject = [[DemoObject alloc] init];
        self.myObject.myName = @"PonyCui";
        self.myObject.myAge = 25;
        self.myObject.myWeight = 888.88;
        self.myObject.couple = [[DemoObjectSecond alloc] init];
        self.myObject.couple.myWife = @"Single";
        self.myObject.demoArray = @[@"1",@"2",@"3"];
        self.myObject.demoDictionary = @{@"hello": @"world"};
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view smartyRendWithObject:self.myObject isRecursive:YES];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
