//
//  KFAMGridView.m
//
//  Created by John Park and Alejandro Mendoza on 9/16/14.
//  Copyright (c) 2014 John Park, Alejandro Mendoza. All rights reserved.
//

#import "KFAMGridView.h"

@interface KFAMGridView () {
    NSMutableArray* _cells;
    id _target;
    SEL _action;
}

@end

@implementation KFAMGridView

// Initializes the subframe where we will create
// our Sudoku board
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeButtonsWithFrame:frame];
    }
    return self;
}

// Defines viewcontroller as the target class to return
// information about the Sudoku board to.
-(void)setAction:(SEL)action
      withTarget:(id)target {
    _target = target;
    _action = action;
}

// This returns information to the viewcontroller
// about which button was pressed
- (void)cellPressed:(id)sender {
    // take the tag of button selected and send it back to the
    // target (which is viewcontroller)
    UIButton* button = (UIButton*) sender;
    NSNumber* tag = [NSNumber numberWithInteger:[button tag] ];
    [_target performSelector:_action withObject:tag];
}

// Creates the Sudoku board within the subview frame
- (void)makeButtonsWithFrame:(CGRect)frame {
    _cells = [ [NSMutableArray alloc] initWithCapacity:9];
    
    // create grid frame
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame));
    CGRect gridFrame = CGRectMake(0, 0, size, size);
    CGFloat offset = .1*size;
    
    // create grid view
    UIView* backgroundView;
    backgroundView = [ [UIView alloc] initWithFrame:gridFrame];
    [backgroundView setBackgroundColor:[ [UIColor alloc] initWithRed:0/255 green:0/255 blue:0/255 alpha:1] ];
    [self addSubview:backgroundView];
    
    // set initial values for buttons we will create
    int currentTag = 0;
    float yoffsetToAdd = 0;
    
    // Build the board and fill the NSMutable array with buttons
    for (int r = 0; r < 9; r++) {
        float xoffsetToAdd = 0;
        NSMutableArray* row = [ [NSMutableArray alloc] initWithCapacity:9];
        
        if (r%3 == 0) {
            yoffsetToAdd+=.01*size;
        }
        for (int c = 0; c < 9; c++) {
            if (c%3 == 0 ) {
                xoffsetToAdd+=.01*size;
            }
            // create the button
            UIButton* button;
            CGFloat buttonSize = size/11;
            CGRect buttonFrame = CGRectMake(.035*size+r*offset+yoffsetToAdd, .035*size+c*offset+xoffsetToAdd, buttonSize, buttonSize);
            button = [ [UIButton alloc] initWithFrame:buttonFrame];
            button.backgroundColor = [[UIColor alloc] initWithRed:1 green:0.7 blue:0.8 alpha:1];
            [self addSubview:button];
            
            // give button correct attributes
            [button addTarget:self action:@selector(cellPressed:) forControlEvents:UIControlEventTouchUpInside]; //make own version of this
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            button.showsTouchWhenHighlighted = YES;
            button.tag = currentTag;
            
            currentTag++;
            
            // insert the button
            [row insertObject:button atIndex:c];
        }
        // insert the array of buttons into another array
        [_cells insertObject: row atIndex: r];
    }
}

// Returns the button in the NSMutable array at the
// given row and column
- (UIButton*)getCellWithRow:(int)row
                     andCol:(int)col {
    return _cells[row][col];
}

// Inserts the designated value into the correct
// button given a row and column
- (void)setValueForCellAtCol:(int)col
                      andRow:(int)row
                   withValue:(int)value {
    UIButton* cell = [self getCellWithRow:col andCol:row];
    
    [cell setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    //retrieve the proper number
    NSString* numToFill;
    
    if (value == 0) {
        numToFill = @"";
    } else {
        numToFill = [NSString stringWithFormat:@"%d", value];
    }
    [cell setTitle:numToFill forState:UIControlStateNormal];
}

// Inserts the designated value into the correct
// button given a row and column
- (void)setValueForCellAtCol:(int)col
                      andRow:(int)row
                   withValue:(int)value
                   withColor:(UIColor*)color
{
    UIButton* cell = [self getCellWithRow:col andCol:row];
    
    [cell setTitleColor:color forState:UIControlStateNormal];
    [cell setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    //retrieve the proper number
    NSString* numToFill;
    
    if (value == 0 || value == 10) {
        numToFill = @"";
    } else {
        numToFill = [NSString stringWithFormat:@"%d", value];
    }
    [cell setTitle:numToFill forState:UIControlStateNormal];
}

@end
