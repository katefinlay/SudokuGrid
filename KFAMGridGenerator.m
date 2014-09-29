//
//  KFAMGridGenerator.m
//  Sudoku Grid
//
//  Created by Jun Hong Park on 9/26/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridGenerator.h"

@implementation KFAMGridGenerator {
    KFAMGridModel* _gridForUse;
    NSMutableArray* _intRandomGrid;
}

// parse the text file with our grids and randomly select a line representing a grid
- (void)getRawGrid
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSError* error;

    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    NSArray* allLinedStrings = [readString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSUInteger randomIndex = arc4random() % [allLinedStrings count];
    
    NSString* randomGrid = [allLinedStrings objectAtIndex:randomIndex];
    
    
    _intRandomGrid = [NSMutableArray array];
    for (int i = 0; i < randomGrid.length; i++) {
        unichar c = [randomGrid characterAtIndex:i];
        if (!isnumber(c)) {
            [_intRandomGrid addObject:[NSNumber numberWithInt:0]];
        } else {
            [_intRandomGrid addObject:[NSNumber numberWithInt:c - '0']];
        }
    }
    
    int gridToSend[81];
    
    for(int i=0;i<[_intRandomGrid count];i++) {
        NSNumber *index = [_intRandomGrid objectAtIndex:(NSUInteger) i];
        int toAdd = [index intValue];
        gridToSend[i] = toAdd;
    }
    
    _gridForUse = [[KFAMGridModel alloc] init];
    [_gridForUse initializeGrid:gridToSend];
}

- (KFAMGridModel*)getGridModel
{
    return _gridForUse;
}

- (NSMutableArray*)getArray
{
    return _intRandomGrid;
}

@end
