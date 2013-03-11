//
//  NewRecord.m
//  masterDemo
//
//  Created by Edward on 13-3-6.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "NewRecord.h"

@interface NewRecord ()

@end

@implementation NewRecord
@synthesize inputNewRecord;
@synthesize popoverController;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showPopover:(id)sender {
    
    if (popoverController == nil) {
        popoverController = [[UIPopoverController alloc] initWithContentViewController:inputNewRecord];
        CGRect popoverRect =  CGRectMake(130, 330, 0, 0);
        [popoverController presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        popoverController.delegate = self;
    }
}
- (IBAction)hide:(id)sender {

    [self dismissModalViewControllerAnimated:YES];
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)PopoverController {
    
    if (PopoverController == popoverController) {
        [popoverController release];
        popoverController = nil;
    }
}
@end
