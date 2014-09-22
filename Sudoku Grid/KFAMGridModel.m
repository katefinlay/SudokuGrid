//
//  KFAMGridModel.m
//  Sudoku Grid
//
//  Created by Jun Hong Park on 9/19/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridModel.h"

@implementation KFAMGridModel {
    int _cells[9][9];
    int _initialGrid[9][9];
}

// Initialize grid with information from view controller
-(void)initializeGrid:(int[])initialArray
{
    
    for (int r=0; r<9; r++) {
        for (int c=0; c<9; c++) {
            _cells[c][r] = initialArray[r*8 + c];
            _initialGrid[c][r] = initialArray[r*8 + c];
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
    if (_initialGrid[col][row] == 0) {
        return true;
    }
    else {
        return false;
    }
}

@end
