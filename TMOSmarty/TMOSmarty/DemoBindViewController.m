//
//  DemoBindViewController.m
//  TMOSmarty
//
//  Created by 崔明辉 on 14-8-1.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "DemoBindViewController.h"
#import "DemoObject.h"
#import "TMOSmarty.h"
#import "TMOObjectVerifier.h"

@interface DemoBindViewController ()

@property (nonatomic, strong) DemoObject *myObject;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation DemoBindViewController

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
    
    [self.view smartyBindForSubviews];//bind all subviews
    [self useBlockToDoMore];//block usage
    [self.view smartyRendWithObject:self.myObject isRecursive:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(changeModelItems) userInfo:nil repeats:NO];
    
    // Do any additional setup after loading the view.
}

- (void)changeModelItems {
    self.myObject.myName = @"Jobs";
    self.myObject.myAge = 55;
    self.myObject.myWeight = 233.33;
    self.myObject.couple.myWife = @"Beautiful Girl";
    self.myObject.demoArray = @[@"4",@"5",@"6"];
    [self.myObject.demoDictionary setObject:@"world23333!" forKey:@"hello"];
}

- (void)useBlockToDoMore {
    [self.ageLabel smartyBindWithBlock:^(UIView *bindView, id dataSource, id bindObject, NSString *key, id newValue) {
        if (TOInteger(newValue) > 50) {
            [bindView setBackgroundColor:[UIColor yellowColor]];
        }
        else {
            [bindView setBackgroundColor:[UIColor clearColor]];
        }
    }];
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
