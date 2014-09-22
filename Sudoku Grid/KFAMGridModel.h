//
//  KFAMGridModel.h
//  Sudoku Grid
//
//  Created by Jun Hong Park on 9/19/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFAMGridModel : NSObject

// Initialize grid with information from view controller
-(void)initializeGrid:(int[])initialArray;

// Return the value at a row and column of the cell array
-(int)getValueAtRow:(int)row andColumn:(int)column;

// Identify whether a number in the grid is an initial value or not
-(BOOL)canInsertAtRow:(int)row andColumn:(int)col;

// Set the value at a cell to be val
-(void)setValueAtRow:(int)row column:(int)col withValue:(int)val;

// Identify whether a number can be inserted at a certain row
-(BOOL)canInsertValue:(int)value atRow:(int)row;

// Identify whether a number can be inserted at a certain column
-(BOOL)canInsertValue:(int)value atCol:(int)col;

// Identify whether a number can be inserted at a certain subgrid
-(BOOL)canInsertIntoSubgrid:(int)value atRow:(int)row andCol:(int)col;

@end
