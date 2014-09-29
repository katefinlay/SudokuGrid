//
//  KFAMGridModel.m
//  Sudoku Grid
//
//  Created by Jun Hong Park on 9/19/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridModel.h"

// used provided initial array, just for testing purposes
int _testArray[81] =
{1,0,3,5,0,0,0,0,9,
    0,0,2,4,6,0,0,7,0,
    2,4,0,1,0,0,0,0,0,
    0,0,0,0,2,6,7,0,8,
    0,0,1,0,7,0,9,4,0,
    0,6,4,0,1,0,0,0,2,
    5,0,0,9,0,1,6,0,0,
    0,0,0,0,5,4,0,1,0,
    7,3,0,0,0,0,0,0,0};

int _fullArray[81] =
{1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1};

@implementation KFAMGridModel {
    int _cells[9][9];
    int _initialGrid[9][9];
}

// overriding intializers for test cases
-(id)init
{
    return [self initWithArray:_testArray];
}

// overriding initializers for test cases
-(id)fullinit
{
    return [self initWithArray:_fullArray];
}

-(id)initWithArray:(int[])array
{
    self = [super init];
    if (self) {
        [self initializeGrid:array];
    }
    return self;
}

// Initialize grid with information from view controller
-(void)initializeGrid:(int[])initialArray
{
    for (int r=0; r<9; r++) {
        for (int c=0; c<9; c++) {
            _cells[c][r] = initialArray[r*9 + c];
            _initialGrid[c][r] = initialArray[r*9 + c];
        }
    }
}

// Return the value at a row and column of the cell array
-(int)getValueAtRow:(int)row andColumn:(int)column
{
    return _cells[column][row];
}

// Set the value at a cell to be val
-(void)setValueAtRow:(int)row column:(int)col withValue:(int)val {
    _cells[col][row] = val;
}

// Identify whether a number in the grid is an initial value or not
-(BOOL)canInsertAtRow:(int)row andColumn:(int)col
{
    
    // if the value is 0, it is blank
    if (_initialGrid[col][row] == 0 || _initialGrid[col][row] == 10) {
        return true;
    }
    else {
        return false;
    }
}

// Identify whether a number can be inserted at a certain row
-(BOOL)canInsertValue:(int)value atRow:(int)row {
    if (value == 10) {
        return true;
    }
    
    for (int i=0; i<9; i++)
    {
        if (_cells[i][row] == value) {
            return false;
        }
    }
    return true;
}

// Identify whether a number can be inserted at a certain column
-(BOOL)canInsertValue:(int)value atCol:(int)col {
    if (value == 10) {
        return true;
    }
    
    for (int i=0; i<9; i++)
    {
        if (_cells[col][i] == value) {
            return false;
        }
    }
    return true;
}

// Identify whather a number can be inserted at a certain subgrid
-(BOOL)canInsertIntoSubgrid:(int)value atRow:(int)row andCol:(int)col  {
    if (value == 10) {
        return true;
    }
    
    if (row < 3 && col < 3) {
        for (int c=0;c<3;c++) {
            for (int r=0;r<3;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    } else if (row < 3 && 2 < col && col < 6) {
        for (int c=3;c<6;c++) {
            for (int r=0;r<3;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    } else if (row < 3 && 5 < col) {
        for (int c=6;c<9;c++) {
            for (int r=0;r<3;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    } else if (2 < row && row < 6 && col < 3) {
        for (int c=0;c<3;c++) {
            for (int r=3;r<6;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    }  else if (2 < row && row < 6 && 2 < col && col < 6) {
        for (int c=3;c<6;c++) {
            for (int r=3;r<6;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    }  else if (2 < row && row < 6 && 5 < col) {
        for (int c=6;c<9;c++) {
            for (int r=3;r<6;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    } else if (5 < row && col < 3) {
        for (int c=0;c<3;c++) {
            for (int r=6;r<9;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    } else if (5 < row && 2 < col && col < 6) {
        for (int c=3;c<6;c++) {
            for (int r=6;r<9;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
        }
    } else {
        for (int c=6;c<9;c++) {
            for (int r=6;r<9;r++) {
                if (_cells[c][r] == value) {
                    return false;
                }
                
            }
      }
    } return true;
}

// Check whether the grid is complete or not
- (BOOL)gridComplete
{
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++ ) {
            if (_cells[j][i] == 0) {
                return false;
            }
        }
    }
    return true;
}

// Return the number of currently blank cells
- (int)remainingCells
{
    int count = 0;
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (_cells[j][i] == 0 || _cells[j][i] == 10) {
                count++;
            }
        }
    }
    return count;
}

@end
