//
//  InputNewRecord.h
//  masterDemo
//
//  Created by Edward on 13-3-6.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputNewRecord : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    IBOutlet UITableView *table;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) UITextField *field;
@end
