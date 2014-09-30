//
//  KFAMGridModel.m
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/20/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridModel.h"
#import "KFAMGridGenerator.h"

@interface KFAMGridModel () {
    NSMutableArray* _initialGrid;
    NSMutableArray* _currentGrid;
    KFAMGridGenerator* _gridGenerator;
}
@end

@implementation KFAMGridModel 

-(void) initialize {
    _initialGrid = [[NSMutableArray alloc] initWithCapacity:81];
    _currentGrid = [[NSMutableArray alloc] initWithCapacity:81];
    
    _gridGenerator = [KFAMGridGenerator alloc];
    [_gridGenerator initialize];
    [_gridGenerator generateNewGrid];
    
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            NSNumber* numToInput = [NSNumber numberWithInt:[_gridGenerator getNumberWithRow:r andCol:c]];
            [_initialGrid insertObject:numToInput atIndex:(r*9 + c)];
            [_currentGrid insertObject:numToInput atIndex:(r*9 + c)];
        }
    }
}

- (int)getNumberWithRow:(int)row
                 andCol:(int)col {
    NSNumber* value = [_currentGrid objectAtIndex:(row*9 + col)];
    return value.intValue;
}

//- (void)getGrid:(NSMutableArray*) grid {
//    int randomNumber = random()%30000;
//    int firstValue = randomNumber - (randomNumber % 82);
//
//    for (int i = 0; i < 81; i++) {
//        NSNumber* numToInput = [NSNumber numberWithInt:[charToInput intValue]];
//        if ([charToInput  isEqual: @"."]) {
//            NSNumber* zero = [NSNumber numberWithInt:0];
//            [grid insertObject:zero atIndex:i];
//        } else{
//            [grid insertObject:numToInput atIndex:i];
//
//        }
//        
//    }
//}
//
//- (void)getNewGrid:(NSMutableArray*) grid {
//    int randomNumber = random()%30000;
//    int firstValue = randomNumber - (randomNumber % 82);
//    
//    for (int i = 0; i < 81; i++) {
//        NSString* charToInput = [_readString substringWithRange:NSMakeRange(firstValue+i, 1)];
//        NSNumber* numToInput = [NSNumber numberWithInt:[charToInput intValue]];
//        if ([charToInput  isEqual: @"."]) {
//            NSNumber* zero = [NSNumber numberWithInt:0];
//            [grid replaceObjectAtIndex:i withObject:zero];
//        } else{
//            [grid replaceObjectAtIndex:i withObject:numToInput];
//            
//        }
//        
//    }
//}

- (BOOL)isValidValue:(int)val
                   forRow:(int)row
                   andCol:(int)col {
    // check if row valid
    for (int i = 0; i < 9; i++) {
        NSNumber *currentNum = [_currentGrid objectAtIndex:(row*9 + i)];
        if (currentNum.intValue == val) {
            return false;
        }
    }
    
    // check is column valid
    for (int i = 0; i < 9; i++) {
        NSNumber *currentNum = [_currentGrid objectAtIndex:(i*9 + col)];
        if (currentNum.intValue == val) {
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
}

- (void)makeNewGame
{
    [_gridGenerator generateNewGrid];
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            NSNumber* numToInput = [NSNumber numberWithInt:[_gridGenerator getNumberWithRow:r andCol:c]];
            [_currentGrid replaceObjectAtIndex:(r*9 + c) withObject:numToInput];
        }
    }
}

- (BOOL)checkSolution {
    for (int i = 0; i < 81; i++) {
        NSNumber* currentNum = [_currentGrid objectAtIndex:i];
        if (currentNum.intValue == 0) {
            return false;
        }
    }
    return true;
}

@end
