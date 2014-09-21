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
}

-(void)initializeGrid:(int[])initialArray
{
    for (int r=0; r<9; r++) {
        for (int c=0; c<9; c++) {
            _cells[c][r] = initialArray[r*9 + c%9];
        }
    }
}

-(int)getValueAtRow:(int)row andColumn:(int)column
{
    return _cells[column][row];
}

//-(BOOL)gridFull:(int)
//
////-(BOOL)gridComplete:
////
////
//
@end
