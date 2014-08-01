//
//  DemoTableViewController.m
//  TMOSmarty
//
//  Created by 崔明辉 on 14-8-1.
//  Copyright (c) 2014年 崔 明辉. All rights reserved.
//

#import "DemoTableViewController.h"
#import "DemoObject.h"
#import "TMOSmarty.h"

@interface DemoTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation DemoTableViewController

- (void)dealloc {
    [self.view smartyUnBind];
}

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
        self.data = [NSMutableArray array];
        for (NSInteger i=0; i<100; i++) {
            DemoObject *demoObject = [[DemoObject alloc] init];
            demoObject.myName = [NSString stringWithFormat:@"PonyCui_%ld", i];
            demoObject.myAge = 25;
            demoObject.myWeight = 888.88;
            demoObject.couple = [[DemoObjectSecond alloc] init];
            demoObject.couple.myWife = @"Single";
            demoObject.demoArray = @[@"1",@"2",@"3"];
            demoObject.demoDictionary = [@{@"hello": @"world"} mutableCopy];
            [self.data addObject:demoObject];
            [self performSelector:@selector(objectChangeTest:) withObject:demoObject afterDelay:3.0];
        }
    }
    return self;
}

- (void)objectChangeTest:(DemoObject *)theObject {
    theObject.myWeight = arc4random() % 1000;
    if (theObject.myWeight > 500.0) {
        theObject.myChild = @"Hello!";
    }
    else {
        theObject.myChild = nil;
    }
    [self performSelector:@selector(objectChangeTest:) withObject:theObject afterDelay:1.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    DemoObject *theObject = self.data[indexPath.row];
    [cell smartyBindForSubviews];
    [cell smartyRendWithObject:theObject isRecursive:YES];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
