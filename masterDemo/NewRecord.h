//
//  NewRecord.h
//  masterDemo
//
//  Created by Edward on 13-3-6.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputNewRecord.h"
@interface NewRecord : UIViewController <UIPopoverControllerDelegate>

{
    IBOutlet InputNewRecord *inputNewRecord;
}

@property (nonatomic, retain) InputNewRecord *inputNewRecord;
@property (nonatomic, retain) UIPopoverController *popoverController;
-(IBAction)showPopover:(id)sender;
-(IBAction)hide:(id)sender;
@end
