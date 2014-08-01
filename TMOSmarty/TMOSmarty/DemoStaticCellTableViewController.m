//
//  DemoStaticCellTableViewController.m
//  TMOSmarty
//
//  Created by 崔明辉 on 14-8-1.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "DemoStaticCellTableViewController.h"
#import "DemoObject.h"
#import "TMOSmarty.h"

@interface DemoStaticCellTableViewController ()

@property (nonatomic, strong) DemoObject *myObject;

@end

@implementation DemoStaticCellTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell smartyRendWithObject:self.myObject isRecursive:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
