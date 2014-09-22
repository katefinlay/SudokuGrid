//
//  KFAMNumPadView.h
//  Sudoku Grid
//
//  Created by Jun Hong Park on 9/19/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFAMNumPadView : UIView

// Creates the Sudoku board within the subview frame
- (void)makeButtonsWithFrame:(CGRect)frame;

// Returns the button in the NSMutable array of all the
// buttons placed on the numPad
- (UIButton*)getCellWithIndex:(int)index;

// Inserts the designated value into the correct
// button given a row and column
- (void)setValueAtIndex:(int)index
                     withValue:(int)value;

// Defines viewcontroller as the target class to return
// information about the Sudoku board to.
-(void)setAction:(SEL)action
      withTarget:(id)target;

-(int)numSelected;

@end
