//
//  PackViewController.h
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackModel.h"

@interface PackViewController : UIViewController

@property (strong, nonatomic) PackModel *model;
@property (strong, nonatomic) IBOutlet UIView *containView;
@property(nonatomic, retain) NSMutableArray *txtViewList;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *actView;

- (IBAction)viewListPage:(id)sender;
- (IBAction)editExpress:(id)sender;
- (IBAction)shareExpress:(id)sender;

- (void)touchPack;

@end
