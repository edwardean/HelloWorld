//
//  InputNewRecord.m
//  masterDemo
//
//  Created by Edward on 13-3-6.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "InputNewRecord.h"
#import "dataBaseManager.h"
#import "Medicine.h"
#import "Office.h"
#import "BingQu.h"
#import "Record.h"
#import "MedInfoCell.h"
@interface InputNewRecord ()

@property (nonatomic, retain) NSArray *medArray;
@end

@implementation InputNewRecord
@synthesize table,segment;
@synthesize medArray;
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
    self.medArray = [NSArray array];
    self.contentSizeForViewInPopover = CGSizeMake(375, 530);
    segment.selectedSegmentIndex = 0;
    medArray = [[Medicine findAllMedicineToArray] copy];
    [segment addTarget:self action:@selector(segValueChanged:) forControlEvents:UIControlEventValueChanged];
}
- (void)segValueChanged:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger segmentIndex = segmentedControl.selectedSegmentIndex;
    switch (segmentIndex) {
        case 0:
            self.medArray =[Medicine findAllMedicineToArray];
            break;
        case 1:
            self.medArray = [BingQu findAllBingQuIntoArray];
            break;
        case 2:
            self.medArray = [Office findAllOffcieIntoArray];
            break;
        default:
            
            break;
    }
    [table reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload {
    [super viewDidUnload];
    medArray = nil;
}
#pragma mark TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return  [medArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"CellIdentifier";
    static NSString *CellIdentifier = @"CellID";
    
    UITableViewCell * cell  =[tableView dequeueReusableCellWithIdentifier:CellID];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID] autorelease];
    }

    NSString *str = @"";
    if (segment.selectedSegmentIndex == 0) {
            UINib *nib = [UINib nibWithNibName:@"MedInfoCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:CellIdentifier];
            MedInfoCell *Medcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            NSDictionary *dic = [medArray objectAtIndex:indexPath.row];
            Medcell.NameLabel.text = [NSString stringWithFormat:@"品名:%@",[dic objectForKey:@"Name"] ];
            Medcell.SpecifiStr = [NSString stringWithFormat:@"规格:%@",[dic objectForKey:@"Specifi"] ];
            Medcell.CountStr = [NSString stringWithFormat:@"产地:%@",[dic objectForKey:@"Content"] ];
            cell = Medcell;
        }
    
      if (segment.selectedSegmentIndex == 1)  {
           
            str = [medArray objectAtIndex:indexPath.row];
            cell.textLabel.text = str;

        }

       if (segment.selectedSegmentIndex == 2)  {
            str = [medArray objectAtIndex:indexPath.row];
            cell.textLabel.text = str;
        }

return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (segment.selectedSegmentIndex==0) {
        return 60;
    }
    return 44;
}
#pragma mark -

- (void) dealloc {
    [super dealloc];
    [medArray release];
}
@end
