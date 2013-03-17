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
@property (nonatomic, retain) NSIndexPath *lastPath;
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
    self.lastPath = nil;
    self.BQStr = @"NULL";
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
    
    if ([self.lastPath isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BOOL isMarked = [[table cellForRowAtIndexPath:self.lastPath] accessoryType] == UITableViewCellAccessoryCheckmark ? YES : NO;
    if (![indexPath isEqual:self.lastPath]) {

        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        self.lastPath = indexPath;
        self.BQStr = [array objectAtIndex:indexPath.row];
        
    } else {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        if (isMarked) {
        self.BQStr = @"NULL";
        newCell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.BQStr = [array objectAtIndex:indexPath.row];
        }
        
    }
    NSLog(@"%@",self.BQStr);

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
