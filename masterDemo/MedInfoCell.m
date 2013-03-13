//
//  MedInfoCell.m
//  masterDemo
//
//  Created by Edward on 13-3-12.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "MedInfoCell.h"

@implementation MedInfoCell
@synthesize NameStr,SpecifiStr,CountStr;
@synthesize NameLabel,SpecifiLabel,CountLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setNameStr:(NSString *)Str {
    
    if (![Str isEqualToString:NameStr]) {
        NameStr = [Str copy];
        self.NameLabel.text = NameStr;
    }
}
- (void) setSpecifiStr:(NSString *)Str {
    if (![Str isEqualToString:SpecifiStr]) {
        SpecifiStr = [Str copy];
        self.SpecifiLabel.text = SpecifiStr;
    }
}

- (void) setCountStr:(NSString *)Str {
    if (![Str isEqualToString:CountStr]) {
        CountStr = [Str copy];
        self.CountLabel.text = CountStr;
    }
}
@end
