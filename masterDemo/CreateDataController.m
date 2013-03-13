//
//  CreateDataController.m
//  masterDemo
//
//  Created by Edward on 13-3-3.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "CreateDataController.h"

@interface CreateDataController ()

@property (nonatomic, retain) NSArray *menuArray;
@end

@implementation CreateDataController
@synthesize menuArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuArray = [[NSArray arrayWithObjects:@"新增药品",@"新增科室",@"新增病区",@"新增记录", nil] retain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType  =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithString:[menuArray objectAtIndex:[indexPath row]]];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSUInteger row = [indexPath row];
    UIViewController *controller = [[[UIViewController alloc] init] autorelease];
    NewMedicine *newMedicine = [[NewMedicine alloc] initWithNibName:@"NewMedicine" bundle:nil];
    newMedicine.modalPresentationStyle = UIModalPresentationFormSheet;
    
    NewOffice *newOffice = [[NewOffice alloc] initWithNibName:@"NewOffice" bundle:nil];
    newOffice.modalPresentationStyle = UIModalPresentationFormSheet;

    NewBingQu *newBingQu = [[NewBingQu alloc] initWithNibName:@"NewBingQu" bundle:nil];
    newBingQu.modalPresentationStyle = UIModalPresentationFormSheet;
    
    NewRecord *newRecord = [[NewRecord alloc] initWithNibName:@"NewRecord" bundle:nil];
    newRecord.modalPresentationStyle = UIModalPresentationFormSheet;
    switch (row) {
        case 0:
            controller = [newMedicine retain];
            [newMedicine release];
            break;
        case 1:
            controller = [newOffice retain];
            [newOffice release];
            break;
        case 2:
            controller = [newBingQu  retain];
            [newBingQu release];
            break;
        case 3:
            controller = [newRecord retain];
            [newRecord release];
            break;
        default:
            break;
    }
    [self presentModalViewController:controller animated:YES];
    [newMedicine release];
    [newOffice release];
    [newBingQu release];
    [newRecord release];
}
@end
