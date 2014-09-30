//
//  KFAMGridGenerator.m
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/29/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridGenerator.h"

@interface KFAMGridGenerator () {
    NSMutableArray* _grid;
    NSString* _readString;
}
@end


@implementation KFAMGridGenerator

- (void)generateNewGrid {
    [self makeGrid:_grid];
}

- (void)initialize {
    _grid = [[NSMutableArray alloc] initWithCapacity:81];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];
    NSError* error;
    _readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
}

- (int)getNumberWithRow:(int)row
                 andCol:(int)col {
    NSNumber* value = [_grid objectAtIndex:(row*9 + col)];
    return value.intValue;
}

- (void)makeGrid:(NSMutableArray*) grid {
    int randomNumber = random()%30000;
    int firstValue = randomNumber - (randomNumber % 82);
    
    for (int i = 0; i < 81; i++) {
        NSString* charToInput = [_readString substringWithRange:NSMakeRange(firstValue+i, 1)];
        NSNumber* numToInput = [NSNumber numberWithInt:[charToInput intValue]];
        if ([charToInput  isEqual: @"."]) {
            NSNumber* zero = [NSNumber numberWithInt:0];
            [grid insertObject:zero atIndex:i];
        } else{
            [grid insertObject:numToInput atIndex:i];
            NSLog(@"value is %d", numToInput.intValue);
            
        }
    }
}

@end
