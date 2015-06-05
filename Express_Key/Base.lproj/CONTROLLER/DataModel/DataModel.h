//
//  DataModel.h
//  Kiana
//
//  Created by Ji wonnam on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define TABLE_CONTACTS		@"tbl_pack"

//#define FIELD_CONTACTID     @"userid"
#define FIELD_TEXT         @"text"
#define FIELD_NAME			@"name"

@class PackModel;

@interface DataModel : NSObject <NSXMLParserDelegate>{
	sqlite3         *dbHandler;
    NSMutableArray  *packsArray;
    NSXMLParser*    m_xmlParser;
}

@property (nonatomic)           sqlite3         *dbHandler;
@property (nonatomic, retain)   NSMutableArray  *packsArray;

+ (BOOL)createTable:(sqlite3 *)dbHandler;
- (id)initWithDBHandler:(sqlite3*)dbHandler;
- (BOOL)updateDB:(NSMutableArray*) _packsArray;
- (BOOL)addPack:(NSMutableArray*) _packsArray;

@end
