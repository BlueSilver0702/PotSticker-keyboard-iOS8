//
//  CSVParser.m
//  ClickRadio
//
//  Created by Luoyan on 9/23/14.
//  Copyright (c) 2014 zhelong. All rights reserved.
//

#import "CSVParser.h"
#import "CHCSVParser.h"

@implementation CSVParser

- (NSMutableArray*) parseCSV:(NSString*)_filePath;
{
    NSLog(@"Beginning...");
    NSStringEncoding encoding = 0;
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:_filePath];
    CHCSVParser * p = [[CHCSVParser alloc] initWithInputStream:stream usedEncoding:&encoding delimiter:';'];
    [p setRecognizesBackslashesAsEscapes:YES];
    [p setSanitizesFields:YES];
    [p setDelegate:self];
    [p parse];
    
    return [self makeResultFromArray:_lines];
}

- (NSMutableArray*) makeResultFromArray:(NSMutableArray*)_array
{
    NSString* str;
    for (int i = 0; i < [_array count]; i ++) {
       str = [[_array objectAtIndex:i] objectAtIndex:0];
        
        [m_arrayResult addObject:[self makeArrayFromText:str]];
        
    }
    return m_arrayResult;
}

- (NSArray*) makeArrayFromText:(NSString*)_string
{
    NSArray* _array;// = [[NSArray alloc] init];
    
    _array = [_string componentsSeparatedByString:@","];
    
    return _array;
}

#pragma mark ------ delegate -------
- (void)parserDidBeginDocument:(CHCSVParser *)parser {
    m_arrayResult = [[NSMutableArray alloc] init];
    _lines = [[NSMutableArray alloc] init];
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber {
    _currentLine = [[NSMutableArray alloc] init];
}

- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex {
    NSLog(@"%@", field);
    [_currentLine addObject:field];
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber {
    [_lines addObject:_currentLine];
    _currentLine = nil;
}

- (void)parserDidEndDocument:(CHCSVParser *)parser {
    //	NSLog(@"parser ended: %@", csvFile);
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"ERROR: %@", error);
    for (int i = 0; i < [_lines count]; i ++) {
        
    }
    //_lines = nil;
}


@end
