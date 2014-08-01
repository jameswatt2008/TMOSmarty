//
//  DemoFunctionViewController.m
//  TMOSmarty
//
//  Created by 崔明辉 on 14-8-1.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "DemoFunctionViewController.h"
#import "DemoObject.h"
#import "TMOSmarty.h"

@interface DemoFunctionViewController ()

@property (nonatomic, strong) DemoObject *myObject;

@end

@implementation DemoFunctionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.myObject = [[DemoObject alloc] init];
        self.myObject.myName = @"PonyCui";
        self.myObject.myAge = 25;
        self.myObject.myWeight = 888.88;
        self.myObject.couple = [[DemoObjectSecond alloc] init];
        self.myObject.couple.myWife = @"Single";
        self.myObject.demoArray = @[@"1",@"2",@"3"];
        self.myObject.demoDictionary = [@{@"hello": @"world"} mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [Smarty addFunction:^NSString *(NSString *theString, NSArray *theParams) {
        return [NSString stringWithFormat:@"%ld", [theString hash]];
    } withTagName:@"tryHash"];
    
    [self.view smartyRendWithObject:self.myObject isRecursive:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
