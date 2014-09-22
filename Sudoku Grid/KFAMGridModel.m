//
//  KFAMGridModel.m
//  Sudoku Grid
//
//  Created by Katharine Finlay on 9/20/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridModel.h"

@implementation KFAMGridModel

int initialGrid[81] =
{1,0,3,5,0,0,0,0,9,
    0,0,2,4,6,0,0,7,0,
    2,4,0,1,0,0,0,0,0,
    0,0,0,0,2,6,7,0,8,
    0,0,1,0,7,0,9,4,0,
    0,6,4,0,1,0,0,0,2,
    5,0,0,9,0,1,6,0,0,
    0,0,0,0,5,4,0,1,0,
    7,3,0,0,0,0,0,0,0};

int currentGrid[81] =
{1,0,3,5,0,0,0,0,9,
    0,0,2,4,6,0,0,7,0,
    2,4,0,1,0,0,0,0,0,
    0,0,0,0,2,6,7,0,8,
    0,0,1,0,7,0,9,4,0,
    0,6,4,0,1,0,0,0,2,
    5,0,0,9,0,1,6,0,0,
    0,0,0,0,5,4,0,1,0,
    7,3,0,0,0,0,0,0,0};

- (int)getNumberWithRow:(int)row
                 andCol:(int)col {
    return initialGrid[row*9 + col];
}

- (BOOL)isValidValue:(int)val
                   forRow:(int)row
                   andCol:(int)col {
    
    // check if row valid
    for (int i = 0; i < 9; i++) {
        if (currentGrid[row*9 + i] == val) {
            return false;
        }
    }
    
    // check is column valid
    for (int i = 0; i < 9; i++) {
        if (currentGrid[i*9 + col] == val) {
            return false;
        }
    }
    
    // check if subgrid is valid
    int initSubgridRow = row/3;
    int initSubgridCol = col/3;
    for (int i = initSubgridRow; i < initSubgridRow + 3; i++) {
        for (int k = initSubgridCol; k < initSubgridRow + 3; k++) {
            if (currentGrid[i*9 + k] == val) {
                return false;
            }
        }
    }
    
    return true;
}

- (BOOL)isMutableforRow:(int)row
              andCol:(int)col {
    if (initialGrid[row*9 + col] == 0) {
        return true;
    }
    
    return false;
}

- (void)inputNumber:(int)newNum
              atRow:(int)row
             andCol:(int)col {
    currentGrid[row*9+col] = newNum;
}

@end
