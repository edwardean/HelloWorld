//
//  MedInfoCell.h
//  masterDemo
//
//  Created by Edward on 13-3-12.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedInfoCell : UITableViewCell {
    IBOutlet UILabel *NameLabel;
    IBOutlet UILabel *SpecifiLabel;
    IBOutlet UILabel *CountLabel;
}

@property (nonatomic, retain) UILabel *NameLabel;
@property (nonatomic, retain) UILabel *SpecifiLabel;
@property (nonatomic, retain) UILabel *CountLabel;
@property (copy, nonatomic) NSString *NameStr;
@property (copy, nonatomic) NSString *SpecifiStr;
@property (copy, nonatomic) NSString *CountStr;

@end
