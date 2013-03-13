//
//  MasterViewController.m
//  masterDemo
//
//  Created by Edward on 13-3-3.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "CreateDataController.h"
#import "ScanInfoController.h"
#import "SearchInfoController.h"
#import "SettingController.h"
#import "ViewController1.h"

#import "tableViewController.h"
#import "dataBaseManager.h"
#import "FMDatabase.h"
#import "AppDelegate.h"
@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    NSArray *arry = [NSArray arrayWithObjects:@"信息录入",@"查看",@"查询信息",@"设置", nil];
    [_objects addObjectsFromArray:arry];
    dataBaseManager *manager = [[dataBaseManager alloc] init];
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    if ([dataBase open]) {
        if ([manager createTable]) {
            debugLog(@"建表成功");
        }
    }
    [manager release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger counter = 0;
    switch (section) {
        case 0:
            counter = 1;
            break;
        case 1:
            counter = 1;
            break;
        case 2:
            counter = 1;
            break;
        case 3:
            counter = 1;
            break;
            }
    return counter;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    NSDate *object = _objects[indexPath.row];
//    cell.textLabel.text = [object description];
    NSInteger counter = 0;
    NSString *menuString = nil;
    counter = [indexPath section];
    switch (counter) {
        case 0:
            menuString = _objects[counter];
            break;
        case 1:
            menuString = _objects[counter];
            break;
        case 2:
            menuString = _objects[counter];
            break;
        case 3:
            menuString = _objects[counter];
            break;
        default:
            break;
    }
    cell.textLabel.text = menuString;
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headerTitle = nil;
    switch (section) {
        case 0:
            headerTitle = @"录入药品，科室，用药记录等信息";
            break;
        case 1:
            headerTitle = @"查看一些信息";
            break;
        case 2:
            headerTitle = @"查找信息";
            break;
        case 3:
            headerTitle = @"后台数据库管理以及数据导出";
            break;
        default:
            break;
    }
    return headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDate *object = _objects[indexPath.row];
//    self.detailViewController.detailItem = object;
    NSUInteger row = [indexPath section];
    if (row==0) {
//        DetailViewController *detailVC = [[DetailViewController alloc]
//                                          initWithNibName:@"DetailViewController" bundle:nil];
//        nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
//        nav.navigationItem.title = @"detailvc";

        CreateDataController *createVC = [[[CreateDataController alloc] init] autorelease];
        [self.navigationController pushViewController:createVC animated:YES];
        
    } else if (row == 1)
    {
        ScanInfoController *scanVC = [[[ScanInfoController alloc] init]autorelease];
        [self.navigationController pushViewController:scanVC animated:YES];
    } else if (row == 2)
    {
        SearchInfoController *searchVC = [[[SearchInfoController alloc] init]autorelease];
        [self.navigationController pushViewController:searchVC animated:YES];
    } else if (row == 3)
    {
        SettingController *settingVC = [[[SettingController alloc] init] autorelease];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

@end
