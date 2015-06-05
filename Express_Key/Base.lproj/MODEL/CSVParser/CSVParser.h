//
//  CSVParser.h
//  ClickRadio
//
//  Created by Luoyan on 9/23/14.
//  Copyright (c) 2014 zhelong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCSVParser.h"

@interface CSVParser : NSObject <CHCSVParserDelegate>
{
    NSMutableArray* m_arrayResult;
    
    NSMutableArray *_lines;
    NSMutableArray *_currentLine;
}

- (NSMutableArray*) parseCSV:(NSString*)_filePath;

@end
