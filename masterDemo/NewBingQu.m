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
@synthesize inputTextField;
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
    debugMethod();
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)Save:(id)sender {
    
    debugMethod();
    GCDiscreetNotificationView *gcd = [[[GCDiscreetNotificationView alloc] initWithText:@"" showActivity:NO inPresentationMode:GCDiscreetNotificationViewPresentationModeTop inView:self.view] autorelease];
    if ([inputTextField.text isEqualToString:@""]) {
        return;
    } else {
        if ([BingQu findTheSameBingQu:inputTextField.text]) {
            NSString *str = [NSString stringWithFormat:@"%@已经录入过了",inputTextField.text];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:str delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        } else {
            
            if ([BingQu createNewBingQu:inputTextField.text]) {
                NSString *str = [NSString stringWithFormat:@"病区:%@创建成功",inputTextField.text];
                [gcd setTextLabel:str];
                [gcd show:YES];
                [gcd hideAnimatedAfter:1.0f];
                [self.inputTextField setText:@""];
            } else {
                NSString *str = [NSString stringWithFormat:@"%@创建失败",inputTextField.text];
                [gcd setTextLabel:str];
                [gcd show:YES];
                [gcd hideAnimatedAfter:1.0f];
            }
        }
    }
}
#pragma mark UITextField DelegateMethods
- (BOOL)textFieldShouldReturn:(UITextField *)_textField {
    
    [inputTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

#pragma mark -
- (void) viewDidUnload {
    
    [super viewDidUnload];
    inputTextField = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    
    [super dealloc];
    [inputTextField release];
}
@end
