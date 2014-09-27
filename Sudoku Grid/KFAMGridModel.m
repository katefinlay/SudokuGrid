//
//  KFAMGridModel.m
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/20/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridModel.h"
@interface KFAMGridModel () {
    NSMutableArray* _initialGrid;
    NSMutableArray* _currentGrid;
    NSString* _readString;
}
@end

@implementation KFAMGridModel 

//int initialGrid[81] =
//{1,0,3,5,0,0,0,0,9,
//    0,0,2,4,6,0,0,7,0,
//    2,4,0,1,0,0,0,0,0,
//    0,0,0,0,2,6,7,0,8,
//    0,0,1,0,7,0,9,4,0,
//    0,6,4,0,1,0,0,0,2,
//    5,0,0,9,0,1,6,0,0,
//    0,0,0,0,5,4,0,1,0,
//    7,3,0,0,0,0,0,0,0};

-(void) initialize {
    _initialGrid = [[NSMutableArray alloc] initWithCapacity:81];
    _currentGrid = [[NSMutableArray alloc] initWithCapacity:81];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];
    NSError* error;
    _readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    [self getGrid:_initialGrid];
    for (int i = 0; i < 81; i++) {
        [_currentGrid insertObject:[_initialGrid objectAtIndex:i] atIndex:i];
        NSLog(@"_currentgrid[%d] is %@, initial was %@", i, [_currentGrid objectAtIndex:i], [_initialGrid objectAtIndex:i]);
    }
}

- (int)getNumberWithRow:(int)row
                 andCol:(int)col {
    NSNumber* value = [_currentGrid objectAtIndex:(row*9 + col)];
    return value.intValue;
}

- (void)getGrid:(NSMutableArray*) grid {
    int randomNumber = random()%30000;
    int firstValue = randomNumber - (randomNumber % 82);
    NSLog(@"Random number: %d, firstValue %d, firstValue + 81 %d", randomNumber, firstValue, firstValue + 81);
    //Current problem is grid doesn't display any numbers yet seems to have some knowledge of its
    //contents. Also this parsing is taking forever and printing way more than 81 characters.
    for (int i = 0; i < 81; i++) {
        NSString* charToInput = [_readString substringWithRange:NSMakeRange(firstValue+i, 1)];
        NSLog(@"On char %@", charToInput);
        NSNumber* numToInput = [NSNumber numberWithInt:[charToInput intValue]];
        if ([charToInput  isEqual: @"."]) {
            NSNumber* zero = [NSNumber numberWithInt:0];
            [grid insertObject:zero atIndex:i];
        } else{
            [grid insertObject:numToInput atIndex:i];

        }
        
    }
}

- (void)getNewGrid:(NSMutableArray*) grid {
    int randomNumber = random()%30000;
    int firstValue = randomNumber - (randomNumber % 82);
    NSLog(@"Random number: %d, firstValue %d, firstValue + 81 %d", randomNumber, firstValue, firstValue + 81);
    //Current problem is grid doesn't display any numbers yet seems to have some knowledge of its
    //contents. Also this parsing is taking forever and printing way more than 81 characters.
    for (int i = 0; i < 81; i++) {
        NSString* charToInput = [_readString substringWithRange:NSMakeRange(firstValue+i, 1)];
        NSLog(@"On char %@", charToInput);
        NSNumber* numToInput = [NSNumber numberWithInt:[charToInput intValue]];
        if ([charToInput  isEqual: @"."]) {
            NSNumber* zero = [NSNumber numberWithInt:0];
            [grid replaceObjectAtIndex:i withObject:zero];
        } else{
            [grid replaceObjectAtIndex:i withObject:numToInput];
            
        }
        
    }
}

- (BOOL)isValidValue:(int)val
                   forRow:(int)row
                   andCol:(int)col {
    // check if row valid
    for (int i = 0; i < 9; i++) {
        NSNumber *currentNum = [_currentGrid objectAtIndex:(row*9 + i)];
        if (currentNum.intValue == val) {
            NSLog(@"invalid row");
            return false;
        }
    }
    
    // check is column valid
    for (int i = 0; i < 9; i++) {
        NSNumber *currentNum = [_currentGrid objectAtIndex:(i*9 + col)];
        if (currentNum.intValue == val) {
            NSLog(@"invalid col at [%d][%d], conflicting value at [%d][%d]", row, col, i, col);
            return false;
        }
    }
    
    // check if subgrid is valid
    int initSubgridRow = (row - row%3);
    int initSubgridCol = (col - col%3);
    for (int i = initSubgridRow; i < initSubgridRow + 3; i++) {
        for (int k = initSubgridCol; k < initSubgridCol + 3; k++) {
            NSNumber *currentNum = [_currentGrid objectAtIndex:(i*9 + k)];
            if (currentNum.intValue == val) {
                NSLog(@"invalid subgrid");
                return false;
            }
        }
    }
    
    return true;
}

- (BOOL)isMutableForRow:(int)row
              andCol:(int)col {
    
    NSNumber *currentNum = [_initialGrid objectAtIndex:(row*9 + col)];
    if (currentNum.intValue == 0) {
        return true;
    }
    
    return false;
}

- (void)inputNumber:(int)newNum
              atRow:(int)row
             andCol:(int)col {
    NSNumber *number = [NSNumber numberWithInteger:newNum];
    
    [_currentGrid replaceObjectAtIndex:(row*9 + col) withObject:number];
    NSLog(@"input num %d at %d %d, now current grid is %@", newNum, row, col, [_currentGrid objectAtIndex:(row*9 + col)]);
}

- (void)makeNewGame
{
    [self getNewGrid:_initialGrid];
    for (int i = 0; i < 81; i++) {
        [_currentGrid replaceObjectAtIndex:i withObject:[_initialGrid objectAtIndex:i]];
    }
}

@end
