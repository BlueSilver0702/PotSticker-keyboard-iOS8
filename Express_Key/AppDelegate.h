//
//  AppDelegate.h
//  Express_Key
//
//  Created by Jan on 10/23/14.
//  Copyright (c) 2014 Jan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBHandler;
@class DataModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) DBHandler *gDBHandler;
@property (nonatomic, retain) DataModel *gDataModel;
@property (nonatomic, retain) NSMutableArray *gPackList;

- (void)refreshData;


@end

AppDelegate* gAppDelegate;

