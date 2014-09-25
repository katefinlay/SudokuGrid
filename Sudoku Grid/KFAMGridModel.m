//
//  KFAMGridModel.m
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/20/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridModel.h"
@interface KFAMGridModel () {
    int _initialGrid[81];
    int _currentGrid[81];
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
    [self getGrid:_initialGrid];
    for (int i = 0; i < 81; i++) {
        _currentGrid[i] = _initialGrid[i];
    }
}

- (int)getNumberWithRow:(int)row
                 andCol:(int)col {
    return _currentGrid[row*9 + col];
}

- (void)getGrid:(int*) grid {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];
    NSError* error;
    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    int randomNumber = random()%30000;
    int firstValue = randomNumber - (randomNumber % 82);
    //Current problem is grid doesn't display any numbers yet seems to have some knowledge of its
    //contents. Also this parsing is taking forever and printing way more than 81 characters.
    for (int i = firstValue; i < firstValue + 81; i++) {
        NSString* charToInput = [readString substringFromIndex:i];
        NSLog(@"On char %@", charToInput);
        int numToInput = [charToInput intValue];
        if ([charToInput  isEqual: @"."]) {
            numToInput = 0;
        }
        grid[i] = numToInput;
    }
}

- (BOOL)isValidValue:(int)val
                   forRow:(int)row
                   andCol:(int)col {
    
    // check if row valid
    for (int i = 0; i < 9; i++) {
        if (_currentGrid[row*9 + i] == val) {
            return false;
        }
    }
    
    // check is column valid
    for (int i = 0; i < 9; i++) {
        if (_currentGrid[i*9 + col] == val) {
            return false;
        }
    }
    
    // check if subgrid is valid
    int initSubgridRow = (row - row%3);
    int initSubgridCol = (col - col%3);
    for (int i = initSubgridRow; i < initSubgridRow + 3; i++) {
        for (int k = initSubgridCol; k < initSubgridCol + 3; k++) {
            if (_currentGrid[i*9 + k] == val) {
                return false;
            }
        }
    }
    
    return true;
}

- (BOOL)isMutableForRow:(int)row
              andCol:(int)col {
    
    if (_initialGrid[row*9 + col] == 0) {
        return true;
    }
    
    return false;
}

- (void)inputNumber:(int)newNum
              atRow:(int)row
             andCol:(int)col {
    _currentGrid[row*9+col] = newNum;
}

@end
