//
//  KFAMGridView.m
//  viewTutorial
//
//  Created by Katharine Finlay on 9/11/14.
//  Copyright (c) 2014 Kate Finlay. All rights reserved.
//

#import "KFAMGridView.h"

@interface KFAMGridView () {
    NSMutableArray* _cells;
    id _target;
    SEL _action;
}

@end

@implementation KFAMGridView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeButtonsWithFrame:frame];
    }
    return self;
}

-(void)setAction:(SEL)action withTarget:(id)target
{
    _target = target;
    _action = action;
}

- (void)buttonPressed:(id)sender
{
    UIButton* button = (UIButton*) sender;
    //NSLog(@"You pressed the button at row %d, column %d!", [button tag]/9, [button tag]%9);
    NSNumber* num = [NSNumber numberWithInteger:[button tag]];
    [_target performSelector:_action withObject:num];
}




- (void)makeButtonsWithFrame:(CGRect)frame
{
    _cells = [[NSMutableArray alloc] initWithCapacity:9];
    // create grid frame
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.8+.03*x+.03*y;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    CGFloat offset = .11*size;
    
    //create grid view
    self.backgroundColor = [UIColor blackColor];
    int currentTag = 0;
    float yoffsetToAdd = 0;
    
    for (int r = 0; r < 9; r++) {
        float xoffsetToAdd = 0;
        NSMutableArray* row = [[NSMutableArray alloc] initWithCapacity:9];
        if (r%3 == 0)
        {
            yoffsetToAdd+=.01*size;
        }
        for (int c = 0; c < 9; c++) {
            if (c%3 == 0 ) {
                xoffsetToAdd+=.01*size;
            }
            //createbutton
            UIButton* button;
            CGFloat buttonSize = size/10.0;
            CGRect buttonFrame = CGRectMake(.01*size+r*offset+yoffsetToAdd, .01*size+c*offset+xoffsetToAdd, buttonSize, buttonSize);
            button = [[UIButton alloc] initWithFrame:buttonFrame];
            button.backgroundColor = [UIColor whiteColor];
            [self addSubview:button];
            
            // give button correct attributes
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside]; //make own version of this
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            button.showsTouchWhenHighlighted = YES;
            button.tag = currentTag;
            currentTag++;
            [row insertObject:button atIndex:c];
        }
        [_cells insertObject: row atIndex: r];
    }
}


- (UIButton*)getCellWithRow:(int)row
                     andCol:(int)col
{
    return _cells[row][col];
}


- (void)setValueForCellAtRow:(int)row
                      andCol:(int)col
                   withValue:(int)value
{
    UIButton* cell = [self getCellWithRow:row andCol:col];
    
    //retrieve the proper number
    NSString* numToFill;
    if (value == 0) {
        numToFill = @"";
    }
    else {
        numToFill = [NSString stringWithFormat:@"%d", value];
    }
    
    [cell setTitle:numToFill forState:UIControlStateNormal];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
