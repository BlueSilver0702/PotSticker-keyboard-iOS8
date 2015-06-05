//
//  ListViewController.h
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) IBOutlet UITableView *listTable;

@end
