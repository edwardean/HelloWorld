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
#import <QuartzCore/QuartzCore.h>
#define markMedNameLabelTag 1
#define markCountLabelTag 2
#define markPymLabelTag 3
#define markUnitLabelTag 4
#define markCountField 5
#define markDanweiLabel 6
#define markOKBtnTag 7
#define MedNameLabelTag 11
#define CountLabelTag 12
#define PymLabelTag 13
#define UnitLabelTag 14
@interface InputNewRecord ()

@property (nonatomic, retain) NSArray *medArray;
@property(retain, nonatomic) NSIndexPath *selectIndex;
@property (nonatomic, retain) NSMutableArray *indexArray;
@property (nonatomic, retain) NSMutableArray *contentArray;//存放所选药量和index
@end

@implementation InputNewRecord
@synthesize table;
@synthesize medArray;
@synthesize field;
@synthesize contentArray;
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
    self.indexArray = [NSMutableArray arrayWithCapacity:0];
    self.selectIndex = nil;
    self.contentArray = [NSMutableArray arrayWithCapacity:0];
    self.contentSizeForViewInPopover = CGSizeMake(375, 600);
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //因为cell有两种状态，选中时展开输入药量，未选中时关闭显示正常状态
    if (indexPath.row == self.selectIndex.row && self.selectIndex != nil) {
        return 105;
    } else
        return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return  [medArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [UIFont fontWithName:@"Arial" size:13.0f];
    if (indexPath.row == self.selectIndex.row && self.selectIndex != nil) {
        static NSString *markCellID = @"MARKED";
        UITableViewCell *markCell = [tableView dequeueReusableCellWithIdentifier:markCellID];
        NSDictionary *markdic = [medArray objectAtIndex:indexPath.row];
        if (!markCell) {
            markCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:markCellID] autorelease];
            //药名
            UILabel *medNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, -6, 150, 36)];
            medNameLabel.tag = markMedNameLabelTag;
            [markCell.contentView addSubview:medNameLabel];
            [medNameLabel release];
            
            //产地
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 150, 20)];
            countLabel.tag = markCountLabelTag;
            [markCell.contentView addSubview:countLabel];
            [countLabel release];
            
            //拼音码
            UILabel *pymlabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 17, 150, 20)];
            pymlabel.tag = markPymLabelTag;
            [markCell.contentView addSubview:pymlabel];
            [pymlabel release];
            
            //规格
            UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 34, 150, 20)];
            unitLabel.tag = markUnitLabelTag;
            [markCell.contentView addSubview:unitLabel];
            [unitLabel release];
            
            //cell展开
            //背景
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, 392, 53)];
            [imgView setImage:[UIImage imageNamed:@"arraw"]];
            [markCell.contentView addSubview:imgView];
            [imgView release];
            
            //左边的删除按钮
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(10, 70, 24, 24);
            [cancelBtn setBackgroundImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [markCell.contentView addSubview:cancelBtn];
            
            //输入用药量textField
            UITextField *countField = [[UITextField alloc] initWithFrame:CGRectMake(60, 65, 180, 30)];
            countField.tag  = markCountField;
            [markCell.contentView addSubview:countField];
            [countField release];
            
            //右边一点的药品单位mg/ml
            UILabel *danweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 65, 50, 30)];
            danweiLabel.tag = markDanweiLabel;
            [markCell.contentView addSubview:danweiLabel];
            [danweiLabel release];
            
            //右侧的确认按钮
            UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            okBtn.frame = CGRectMake(310, 70, 24, 24);
            okBtn.tag = markOKBtnTag;
//            NSString *Imgstr = [self.indexArray containsObject:indexPath] ? @"refresh" : @"ok";
//            [okBtn setBackgroundImage:[UIImage imageNamed:Imgstr] forState:UIControlStateNormal];
//            [okBtn addTarget:self action:@selector(okBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [markCell.contentView addSubview:okBtn];
            
            markCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //根据tag获取每个控件实例
        UILabel *_medNameLabel = (UILabel *)[markCell.contentView viewWithTag:markMedNameLabelTag];
        [_medNameLabel setFont:font];
        [_medNameLabel setBackgroundColor:[UIColor clearColor]];
        [_medNameLabel setText:[NSString stringWithFormat:@"%@",[markdic objectForKey:@"Name"]]];
        
        UILabel *_countLabel = (UILabel *)[markCell.contentView viewWithTag:markCountLabelTag];
        [_countLabel setFont:font];
        [_countLabel setText:[NSString stringWithFormat:@"产地:%@",[markdic objectForKey:@"Content"]]];
        
        UILabel *_pymLabel = (UILabel *)[markCell.contentView viewWithTag:markPymLabelTag];
        [_pymLabel setFont:font];
        [_pymLabel setText:[NSString stringWithFormat:@"拼音码:%@",[markdic objectForKey:@"PYM"]]];
        
        UILabel *_unitLabel = (UILabel *)[markCell.contentView viewWithTag:markUnitLabelTag];
        [_unitLabel setFont:font];
        [_unitLabel setText:[NSString stringWithFormat:@"规格:%@%@",[markdic objectForKey:@"Specifi"],[markdic objectForKey:@"Unit"]]];
        
        UITextField *tempField = (UITextField *)[markCell.contentView viewWithTag:markCountField];
        [tempField setBackgroundColor:[UIColor whiteColor]];
        tempField.layer.cornerRadius = 10.0f;
        self.field = [tempField retain];
        [tempField release];
        self.field.placeholder = @"输入用药量";
        [self.field setText:@""];
        self.field.returnKeyType = UIReturnKeyDone;
        self.field.keyboardType = UIKeyboardTypeNumberPad;
        self.field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.field.delegate = self;
        
        UILabel *_danweiLabel = (UILabel *)[markCell.contentView viewWithTag:markDanweiLabel];
        [_danweiLabel setFont:font];
        [_danweiLabel setBackgroundColor:[UIColor clearColor]];
        [_danweiLabel setText:[NSString stringWithFormat:@"%@",[markdic objectForKey:@"Unit"]]];
        
        UIButton *_okbtn = (UIButton *)[markCell.contentView viewWithTag:markOKBtnTag];
        NSString *Imgstr = [self.indexArray containsObject:indexPath] ? @"refresh" : @"ok";
        [_okbtn setBackgroundImage:[UIImage imageNamed:Imgstr] forState:UIControlStateNormal];
        [_okbtn addTarget:self action:@selector(okBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return markCell;
        
    } else {
        static NSString *CellID = @"CELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        NSDictionary *dic = [medArray objectAtIndex:indexPath.row];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID] autorelease];
            
            //药名
            UILabel *medNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, -6, 150, 36)];
            medNameLabel.tag = MedNameLabelTag;
            [cell.contentView addSubview:medNameLabel];
            [medNameLabel release];
            
            //产地
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 150, 20)];
            countLabel.tag = CountLabelTag;
            [cell.contentView addSubview:countLabel];
            [countLabel release];
            
            //拼音码
            UILabel *pymlabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 17, 150, 20)];
            pymlabel.tag = PymLabelTag;
            [cell.contentView addSubview:pymlabel];
            [pymlabel release];
            
            //规格
            UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 34, 150, 20)];
            unitLabel.tag = UnitLabelTag;
            [cell.contentView addSubview:unitLabel];
            [unitLabel release];
        }
        
        UILabel *_medNameLabel = (UILabel *)[cell.contentView viewWithTag:MedNameLabelTag];
        [_medNameLabel setFont:font];
        [_medNameLabel setBackgroundColor:[UIColor clearColor]];
        [_medNameLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]]];
        
        UILabel *_countLabel = (UILabel *)[cell.contentView viewWithTag:CountLabelTag];
        [_countLabel setFont:font];
        [_countLabel setText:[NSString stringWithFormat:@"产地:%@",[dic objectForKey:@"Content"]]];
        
        UILabel *_pymLabel = (UILabel *)[cell.contentView viewWithTag:PymLabelTag];
        [_pymLabel setFont:font];
        [_pymLabel setText:[NSString stringWithFormat:@"拼音码:%@",[dic objectForKey:@"PYM"]]];
        
        UILabel *_unitLabel = (UILabel *)[cell.contentView viewWithTag:UnitLabelTag];
        [_unitLabel setFont:font];
        [_unitLabel setText:[NSString stringWithFormat:@"规格:%@%@",[dic objectForKey:@"Specifi"],[dic objectForKey:@"Unit"]]];
        
        UILabel *contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 34, 150, 20)];
        contentlabel.tag = 8;
        [cell.contentView addSubview:contentlabel];
        [contentlabel setFont:[UIFont fontWithName:@"Arial" size:13]];
        for (id obj in self.contentArray)
        {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *d = (NSDictionary *)obj;
                NSString *content = [d objectForKey:@"Content"];
                if (indexPath.row == [[d objectForKey:@"IndexPath"] integerValue]) {
                    [contentlabel setText:[NSString stringWithFormat:@"已选:%@ %@",content,[d objectForKey:@"Unit"]]];
                }
            }
        }
        [contentlabel release];
        
        
        
        if ([self.indexArray containsObject:indexPath]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!self.selectIndex) {
        self.selectIndex = indexPath;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.selectIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        BOOL selectTheSameRow = indexPath.row == self.selectIndex.row ? YES : NO;
        
        if (!selectTheSameRow) {
            NSIndexPath *tempIndexPath = [self.selectIndex copy];
            self.selectIndex = nil;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tempIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            self.selectIndex = indexPath;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.selectIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            self.selectIndex = nil;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
    [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)cancelBtnClicked:(UIButton *)button {
    NSIndexPath *indexPath = nil;
    if ([button.superview.superview isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
        indexPath = [table indexPathForCell:cell];
    }
    
    NSMutableArray *tempAray = [NSMutableArray arrayWithCapacity:0];
    for (id obj in self.contentArray) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            if (indexPath.row == [[dic objectForKey:@"IndexPath"] integerValue]) {
                [tempAray addObject:obj];
            }
        }
    }
    [self.contentArray removeObjectsInArray:tempAray];
    
    self.selectIndex = nil;
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    UITableViewCell *cell = [table cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if ([self.indexArray containsObject:indexPath]) {
        [self.indexArray removeObject:indexPath];
    }
    
    
}

- (void)okBtnClicked:(UIButton *)button {
    NSIndexPath *indexPath = nil;
    
    if ([button.superview.superview isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
        indexPath = [table indexPathForCell:cell];
        
        UITextField *textField = (UITextField *)[cell.contentView viewWithTag:markCountField];
        if ([textField.text length]!=0 && [textField.text intValue]>0) {
            [self.field resignFirstResponder];
            
            if (![self.indexArray containsObject:indexPath]) {
                [self.indexArray addObject:indexPath];
            }
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textField.text,@"Content",
                                 [NSNumber numberWithInteger:[indexPath row]],@"IndexPath",
                                 [NSString stringWithFormat:@"%@",[[self.medArray objectAtIndex:indexPath.row] objectForKey:@"Unit"]],@"Unit",nil];
            if (![contentArray containsObject:dic]) {
            [self.contentArray addObject:dic];
            }
            
            
            self.selectIndex = nil;
            [table reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            UITableViewCell *cell = [table cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        }
    }
}
#pragma mark -



#pragma mark UITextField Delegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    debugMethod();
    self.table.frame = CGRectMake(0, 0, 375, 300);
    return YES;
}
- (void) textFieldDidBeginEditing:(UITextField *)textField {
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if ([textField isEqual:field]) {
        if ([textField.text length] != 0) {
            
        }
    }
    return YES;
}

//限制只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *cs = nil;
    if ([textField isEqual:field]) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSPERIOD]invertedSet];
    } 
    else
        return YES;
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
	BOOL basicTest = [string isEqualToString:filtered];
	return basicTest;
}
#pragma mark -
- (void) dealloc {
    [super dealloc];
    [medArray release];
}
@end
