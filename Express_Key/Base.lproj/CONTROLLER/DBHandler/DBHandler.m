//
//  DatabaseInterface.m
//  Cinema
//
//  Created by System Administrator on 23.1.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "DBHandler.h"
#import "DataModel.h"

@implementation DBHandler

@synthesize dbHandler;

+ (id) connectDB {
	DBHandler *newInterface = [[DBHandler alloc] init];
	NSString* db_path = [documentPath stringByAppendingPathComponent:DB_NAME];
    NSLog(@"db_path = %@", db_path);	
    
	int result = sqlite3_open([db_path UTF8String], &(newInterface->dbHandler));
	
	if (result != SQLITE_OK || ![DataModel createTable:newInterface->dbHandler]) {
//		[newInterface release];
		return nil;
	}
	return newInterface;
}

- (void) disconnectDB {
	sqlite3_close(dbHandler);
}

- (void)dealloc {
	[self disconnectDB];
}

@end
