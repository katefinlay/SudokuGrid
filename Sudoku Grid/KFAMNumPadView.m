//
//  KFAMNumPadView.m
//  Sudoku Grid
//
//  Created by Jun Hong Park on 9/19/14.
//  Copyright (c) 2014 Kate Finlay, Alejandro Mendoza. All rights reserved.
//

#import "KFAMNumPadView.h"

@implementation KFAMNumPadView
{
    NSMutableArray* _buttons;
    id _target;
    SEL _action;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeButtonsWithFrame:frame];
    }
    return self;
}

// Defines viewcontroller as the target class to return
// information about the number pad to.
-(void)setAction:(SEL)action
      withTarget:(id)target {
    _target = target;
    _action = action;
}

// This returns information to the viewcontroller
// about which button was pressed
- (void)buttonPressed:(id)sender {
    // take the tag of button selected and send it back to the
    // target (which is viewcontroller)
    UIButton* button = (UIButton*) sender;
    NSNumber* tag = [NSNumber numberWithInteger:[button tag] ];
    [_target performSelector:_action withObject:tag];
    
    // unhighlight all currently highlighted buttons and then highlight pressed button
    [self unhighlightAll];
    [(id)sender setBackgroundColor:[UIColor grayColor]];
}

// helper method to unhighlight all currently highlighted buttons
-(void)unhighlightAll
{
    for (int i = 0; i < 9; i++) {
        UIButton *button = _buttons[i];
        [button setBackgroundColor:[UIColor whiteColor]];
    }
}

// 
- (void)makeButtonsWithFrame:(CGRect)frame {
    _buttons = [ [NSMutableArray alloc] initWithCapacity:9];
    
    // create grid frame
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.75;
    CGFloat xsize = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.8+.03*x+.03*y;
    CGRect buttonFrame = CGRectMake(x, y, xsize*0.97, xsize/6.5);
    CGFloat offset = .10*xsize;
    
    // create numpad view
    UIView* backgroundView;
    backgroundView = [ [UIView alloc] initWithFrame:buttonFrame];
    [backgroundView setBackgroundColor:[ [UIColor alloc] initWithRed:0/255 green:0/255 blue:0/255 alpha:1] ];
    [self addSubview:backgroundView];
    
    // set initial values for buttons we will create
    int currentTag = 0;
    
    // Build the board and fill the NSMutable array with buttons

    for (int i = 0; i < 9; i++) {
        // create the button
        UIButton* button;
        CGFloat buttonSize = xsize/11;
        CGRect buttonFrame = CGRectMake(.16*xsize+i*offset, y+offset*0.35, buttonSize,buttonSize);
        button = [ [UIButton alloc] initWithFrame:buttonFrame];
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];
            
        // give button correct attributes
        [button addTarget:self action:@selector(buttonPressed:)
            forControlEvents:UIControlEventTouchUpInside]; //make own version of this
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button.showsTouchWhenHighlighted = YES;
        button.tag = currentTag;
        
        currentTag++;
        
        // insert the button
        [_buttons insertObject:button atIndex:i];
    }
}

//
-(UIButton*)getCellWithIndex:(int)index {
    return _buttons[index];
}


// Inserts the designated value into the correct
// button on the numPad
- (void)setValueAtIndex:(int)index
            withValue:(int)value {
    UIButton* cell = [self getCellWithIndex:index];
    
    //retrieve the proper number
    NSString* numToFill;
    
    if (value == 0) {
        numToFill = @"";
    } else {
        numToFill = [NSString stringWithFormat:@"%d", value];
    }
    [cell setTitle:numToFill forState:UIControlStateNormal];
}

@end
