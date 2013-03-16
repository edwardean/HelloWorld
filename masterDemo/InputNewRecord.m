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
@synthesize table;
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

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.medArray = [Medicine findAllMedicineToArray];
        if ([medArray count]==[Medicine countAllMedicine]) {
            debugLog(@"药品获取完毕");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        }
    });
    
}
- (void) viewDidAppear:(BOOL)animated {
    
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
            UINib *nib = [UINib nibWithNibName:@"MedInfoCell" bundle:nil];
            [self.table registerNib:nib forCellReuseIdentifier:CellIdentifier];
            MedInfoCell *Medcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            NSDictionary *dic = [medArray objectAtIndex:indexPath.row];
            Medcell.NameLabel.text = [NSString stringWithFormat:@"品名:%@",[dic objectForKey:@"Name"] ];
            Medcell.SpecifiStr = [NSString stringWithFormat:@"规格:%@%@",[dic objectForKey:@"Specifi"],[dic objectForKey:@"Unit"] ];
            Medcell.CountStr = [NSString stringWithFormat:@"产地:%@",[dic objectForKey:@"Content"] ];
            Medcell.PYMStr = [NSString stringWithFormat:@"拼音码:%@",[dic objectForKey:@"PYM"]];
            cell = Medcell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return 60;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    debugMethod();
}
#pragma mark -

- (void) dealloc {
    [super dealloc];
    [medArray release];
}
@end
