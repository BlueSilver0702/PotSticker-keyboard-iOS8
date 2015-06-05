//
//  CreateViewController.h
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackModel.h"
#import "DataModel.h"
#import "DBHandler.h"
#import "PackTextView.h"

@interface CreateViewController : UIViewController <UITextViewDelegate>

@property(nonatomic, retain) PackModel *currentPack;
@property(nonatomic, retain) IBOutlet PackTextView *txtView;
@property(nonatomic, retain) NSMutableArray *txtViewList;
@property(nonatomic, retain) PackTextView *currentTxtView;
@property(nonatomic, retain) NSString *editText;
@property(nonatomic, retain) IBOutlet UIView *containView;

- (IBAction)viewListPage:(id)sender;
- (IBAction)saveExpress:(id)sender;

@end
