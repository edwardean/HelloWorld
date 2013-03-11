//
//  NewBingQu.m
//  masterDemo
//
//  Created by Edward on 13-3-6.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "NewBingQu.h"
#import "GCDiscreetNotificationView.h"
#import "BingQu.h"
@interface NewBingQu ()

@end

@implementation NewBingQu

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
    inputTextField.autocorrectionType = UITextAutocapitalizationTypeNone;
    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    inputTextField.returnKeyType = UIReturnKeyDone;
    inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputTextField.keyboardType = UIKeyboardTypeDefault;
    inputTextField.delegate = self;
}
- (IBAction)hide:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
