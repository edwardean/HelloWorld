//
//  InputNewRecord.h
//  masterDemo
//
//  Created by Edward on 13-3-6.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputNewRecord : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UISegmentedControl *segment;
    IBOutlet UITableView *table;
}

@property (nonatomic, retain) UISegmentedControl *segment;
@property (nonatomic, retain) UITableView *table;
@end
