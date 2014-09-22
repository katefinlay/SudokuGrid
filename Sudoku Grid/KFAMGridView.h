//
//  KFAMGridView.h
//
//  Created by John Park and Alejandro Mendoza on 9/16/14.
//  Copyright (c) 2014 John Park, Alejandro Mendoza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFAMGridView : UIView

// Creates the Sudoku board within the subview frame
- (void)makeButtonsWithFrame:(CGRect)frame;

// Returns the button in the NSMutable array of all the
// buttons placed on the board
- (UIButton*)getCellWithRow:(int)row
                     andCol:(int)col;

// Inserts the designated value into the correct
// button given a row and column
- (void)setValueForCellAtCol:(int)col
                      andRow:(int)row
                   withValue:(int)value;

// Defines viewcontroller as the target class to return
// information about the Sudoku board to.
-(void)setAction:(SEL)action
      withTarget:(id)target;

@end