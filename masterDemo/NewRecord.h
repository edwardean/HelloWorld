//
//  NewRecord.h
//  masterDemo
//
//  Created by Edward on 13-3-6.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputNewRecord.h"
#import "SelectBQ.h"
@interface NewRecord : UIViewController <UIPopoverControllerDelegate>

{
    IBOutlet InputNewRecord *inputNewRecord;
    IBOutlet SelectBQ *selectBQ;
}

@property (nonatomic, retain) InputNewRecord *inputNewRecord;
@property (nonatomic, retain) SelectBQ *selectBQ;
@property (nonatomic, retain) UIPopoverController *popoverController;
-(IBAction)showPopover:(id)sender;
-(IBAction)hide:(id)sender;
- (IBAction)showBQ:(id)sender;
@end
