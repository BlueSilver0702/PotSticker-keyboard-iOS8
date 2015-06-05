//
//  DatabaseInterface.h
//  Cinema
//
//  Created by System Administrator on 23.1.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define DB_NAME					@"packs_info.db"
#define documentPath			[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface DBHandler : NSObject {
    @public
        sqlite3 *dbHandler;
}

@property(nonatomic, getter=getDbHandler) sqlite3 *dbHandler;

+ (id)connectDB;
- (void)disconnectDB;

@end
