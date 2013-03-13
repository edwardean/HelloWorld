//
//  NewMedicine.m
//  masterDemo
//
//  Created by Edward on 13-3-5.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "NewMedicine.h"
#import "QuartzCore/QuartzCore.h"
#import "dataBaseManager.h"
#import "Medicine.h"
@interface NewMedicine ()
@property (nonatomic, retain) NSIndexPath *lastIndex;
@property (nonatomic, copy) NSString *specifiStr;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, retain) UIAlertView *alert5;
@end

@implementation NewMedicine

@synthesize specifiTable,nameTextField,specifiTextField,countTextField;
@synthesize lastIndex,specifiStr,alert,alert5;
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
    self.specifiStr = @"";
    self.specifiTable.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.specifiTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    nameTextField.autocorrectionType = UITextAutocapitalizationTypeNone;
    nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    nameTextField.returnKeyType = UIReturnKeyNext;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    nameTextField.delegate = self;
    countTextField.autocorrectionType = UITextAutocapitalizationTypeNone;
    countTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    countTextField.returnKeyType = UIReturnKeyDone;
    countTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    countTextField.keyboardType = UIKeyboardTypeDefault;
    countTextField.delegate = self;
    specifiTextField.autocorrectionType = UITextAutocapitalizationTypeNone;
    specifiTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    specifiTextField.returnKeyType = UIReturnKeyNext;
    specifiTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    specifiTextField.keyboardType = UIKeyboardTypeNumberPad;
    specifiTextField.delegate = self;
    
    
}
#pragma mark UITextField委托
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:specifiTextField]) {
        if (![self.specifiStr isEqualToString:@""]) {
            NSMutableString *mutableStr = [specifiTextField.text mutableCopy];
            [mutableStr appendString:self.specifiStr];
            self.specifiTextField.text = mutableStr;
            [mutableStr release];
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    if (textField==nameTextField) {
        [specifiTextField becomeFirstResponder];
    } else if (textField == specifiTextField) {
        [countTextField becomeFirstResponder];
    } else if (textField == countTextField) {
        [countTextField resignFirstResponder];
    }
    return YES;
}
#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)hide:(id)sender {
    debugMethod();
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)Save:(id)sender {
    debugMethod();
    if ([nameTextField.text length]==0 || [specifiTextField.text length] == 0 || [countTextField.text length]==0) {
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"警告" message:@"信息不完整" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 release];

    } else {
        NSRange range1 = [self.specifiTextField.text rangeOfString:@"mg"];
        NSRange range2 = [self.specifiTextField.text rangeOfString:@"ml"];
        if ((range1.location == NSNotFound)&&(range2.location == NSNotFound)) {
            UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"啊噢!" message:@"主人你忘记选药品规格了" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert2 show];
            [alert2 release];
        } else {
            NSString *message = [NSString stringWithFormat:@"药品名称:%@\n规格:%@\n产地:%@",nameTextField.text,specifiTextField.text,countTextField.text];
            self.alert = [[UIAlertView alloc]initWithTitle:@"确认信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }
    }
}
- (void) dismiss {
    [self dismissModalViewControllerAnimated:YES];
}
- (void) saveDataIntoTable {
    debugMethod();
    GCDiscreetNotificationView *gcd = [[GCDiscreetNotificationView alloc] initWithText:@"" showActivity:NO inPresentationMode:GCDiscreetNotificationViewPresentationModeTop inView:self.view];
    if ([Medicine createNewMedicine:nameTextField.text andSpecifi:specifiTextField.text andContent:countTextField.text]) {
        NSString *str = [NSString stringWithFormat:@"药品%@创建完毕",nameTextField.text];
        [gcd setTextLabel:str];
        [gcd show:YES];
        [gcd hideAnimatedAfter:1.0f];
        [gcd release];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0f];
    }  else {
        [gcd setTextLabel:@"创建失败"];
        [gcd show:YES];
        [gcd hideAnimatedAfter:1.0f];
        [gcd release];
    }
    

    findAllMed();

}
- (void)checkDataInTable {
    debugMethod();
    Medicine *med = [[Medicine alloc] init];
    if ([med findIDByMedicineName:self.nameTextField.text andSpecifi:self.specifiTextField.text]) {
        self.alert5 = [[UIAlertView alloc] initWithTitle:@"有重复" message:@"已经有相同的药的记录了" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续保存", nil];
        [alert5 show];
    } else {
        [self saveDataIntoTable];
    }
    [med release];
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView isEqual:alert]) {
        if (buttonIndex == 1) {
            [self checkDataInTable];
        }
    }
    
    if ([alertView isEqual:alert5]) {
        if (buttonIndex == 1) {
            [self saveDataIntoTable];
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *cellText = nil;
    if ([indexPath row] == 0) {
        cellText = @"ml";
    } else if ([indexPath row] == 1) {
     cellText =@"mg";
    }
    cell.textLabel.text = cellText;
    
    
    if ([self.lastIndex isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[tableView cellForRowAtIndexPath:indexPath] isSelected]) {
        
        if ([specifiTextField.text length]>0) {
            NSMutableString *str = [specifiTextField.text mutableCopy];
            NSRange range1 = [specifiTextField.text rangeOfString:@"mg"];
            NSRange range2 = [specifiTextField.text rangeOfString:@"ml"];
            if ((range1.location == NSNotFound)&&(range2.location == NSNotFound)) {
                [str appendString:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
                self.specifiTextField.text = str;
            } else if ((range1.location>0)||(range2.location>0)) {
                NSMutableString *mutableString = [specifiTextField.text mutableCopy];
                [mutableString replaceCharactersInRange:NSMakeRange([mutableString length]-2, 2) withString:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
                self.specifiTextField.text = mutableString;
                [mutableString release];
            }
            [str release];
        } else
            self.specifiStr = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![indexPath isEqual:self.lastIndex]) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastIndex];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
       
        self.lastIndex = indexPath;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    alert = nil;
    alert5 = nil;
    specifiTable  = nil;
    nameTextField = nil;
    specifiTextField = nil;
    countTextField = nil;
}
- (void) dealloc {
    [super dealloc];
    [alert release];
    [alert5 release];
    [specifiTable release];
    [nameTextField release];
    [specifiTextField release];
    [countTextField release];
}
@end
