//
//  SelectBQ.m
//  masterDemo
//
//  Created by Edward on 13-3-14.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "SelectBQ.h"
#import "BingQu.h"
@interface SelectBQ ()

@property (nonatomic, retain) NSArray *array;
@end

@implementation SelectBQ

@synthesize table,BQStr;
@synthesize array;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.array = [NSArray array];
    self.contentSizeForViewInPopover = CGSizeMake(375, 530);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.array = [BingQu findAllBingQuIntoArray];
        if ([array count] == [BingQu countAllBingQu]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        }
        
    });
}



#pragma mark UITableViewDelegete 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   static NSString *CellID = @"Cell";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID]autorelease];
    }
    
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    debugLog(@"%@",cell.textLabel.text);
    return cell;
    
}
#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload {
    [super viewDidUnload];
    table = nil;
    BQStr = nil;
}

- (void) dealloc {
    [super dealloc];
    [table release];
    [BQStr release];
}
@end
